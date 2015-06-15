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
//         NSLog(@"%f, %f", motion.attitude.pitch * 180 / M_PI,
//               motion.attitude.roll * 180 / M_PI);
       }];
    }
  }
  return self;
}

@end
