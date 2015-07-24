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
  float previousValue;
}

@end

@implementation XDMotionManager

- (id)initWith {
  self = [super init];
  if (self) {
    previousValue = 0.0;
    motionManager = [[CMMotionManager alloc] init];
    motionManager.deviceMotionUpdateInterval = 0.1;
    
    if (motionManager.deviceMotionAvailable) {
      [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                         withHandler:^(CMDeviceMotion *motion, NSError *error) {
           float value = motion.attitude.pitch * 180 / M_PI;
           if (value - previousValue > 40) {
             [self.delegate motionUpSender];
           } else if (previousValue - value > 40) {
             [self.delegate motionDownSender];
           }
           previousValue = value;
       }];
    }
  }
  return self;
}

@end
