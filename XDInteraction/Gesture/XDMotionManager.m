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
  int pitchDelta;
  int rollDelta;
}

@end

@implementation XDMotionManager

- (id)initWith {
  self = [super init];
  if (self) {
    motionManager = [[CMMotionManager alloc] init];
    motionManager.deviceMotionUpdateInterval = 0.1;
  
    if (motionManager.deviceMotionAvailable) {
      [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                         withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                           // function first touch
                                           if (!prevMotion) {
                                             prevMotion = motion;
                                           }
                                           
                                           // Gyro filteration
                                           pitchDelta = (int)((prevMotion.attitude.pitch - motion.attitude.pitch) * 100);
                                           rollDelta  = (int)((prevMotion.attitude.roll - motion.attitude.roll) * 100);
                                           if( abs(rollDelta) >= 5 || abs(pitchDelta) >= 5 ){
                                             NSLog(@"%d", /*pinchDelta, */rollDelta);
                                             [self motionHandler];
                                           }
                                           prevMotion = motion;
       }];
    }
  }
  return self;
}

- (void)motionHandler {
  // check if user has implemeted the delegate method
  if ([self.delegate respondsToSelector:@selector(motionSender:)])
  {
    
    // fire sampleDelegate
    if( abs(pitchDelta) > abs(rollDelta) ){
      if( pitchDelta > 0 ){
        [self.delegate motionSender:@"Scroll UP"];
      }
      else{
        [self.delegate motionSender:@"Scroll Down"];
      }
    }
    else{
      if( rollDelta > 0 ){
        [self.delegate motionSender:@"Scroll Left"];
      }
      else{
        [self.delegate motionSender:@"Scroll Right"];
      }
    }

  }
}

@end
