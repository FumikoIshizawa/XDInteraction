//
//  XDMotionManager.m
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/06.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "XDMotionManager.h"

@interface XDMotionManager () {
  CMMotionManager *motionManager;
  CMDeviceMotion *prevMotion;
}

@end

@implementation XDMotionManager

- (id)initWith {
  self = [super init];
  if (self) {
    motionManager = [[CMMotionManager alloc] init];
    motionManager.deviceMotionUpdateInterval = 1 / 2;
    
    if (motionManager.deviceMotionAvailable) {
      [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                         withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                           // function first touch
                                           if (!prevMotion) {
                                             prevMotion = motion;
                                           }
                                           
                                           // Gyro filteration
                                           int pinchDelta = (int)((prevMotion.attitude.pitch - motion.attitude.pitch) * 1000);
                                           int rollDelta  = (int)((prevMotion.attitude.roll - motion.attitude.roll) * 1000);
                                           //NSLog(@"%d", /*pinchDelta, */abs(rollDelta));
                                           if( abs(rollDelta) >= 5 || abs(pinchDelta) >= 5 ){
                                             [self motionHandler: motion];
                                           }
                                           prevMotion = motion;
       }];
    }
  }
  return self;
}

- (void)motionHandler:(CMDeviceMotion *)motion
{
  // check if user has implemeted the delegate method
  if ([self.delegate respondsToSelector:@selector(motionSender:)])
  {
    // fire sampleDelegate
    [self.delegate motionSender:motion];
  }
}

@end
