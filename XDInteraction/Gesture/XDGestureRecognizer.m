//
//  XDGestureRecognizer.m
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/04.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "XDGestureRecognizer.h"

@implementation XDGestureRecognizer

@synthesize gestureManager;
@synthesize motionManager;

- (id)initWithView:(UIView *)view {
  self = [super init];
  if (self) {
    gestureManager = [[XDGestureManager alloc] initWithView:view];
    motionManager = [[XDMotionManager alloc] initWith];
  }
  return self;
}

@end
