//
//  XDGestureManager.m
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/06.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "XDGestureManager.h"

@interface XDGestureManager () {
  UISwipeGestureRecognizer *swipeLeft;
  UISwipeGestureRecognizer *swipeRight;
  UISwipeGestureRecognizer *swipeUp;
  UISwipeGestureRecognizer *swipeDown;
}

@end

@implementation XDGestureManager

- (id)initWithView:(UIView *)view {
  self = [super init];
  if (self) {
    swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(swipeLeftHandler:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [view addGestureRecognizer:swipeLeft];
    
    swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                           action:@selector(swipeRightHandler:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [view addGestureRecognizer:swipeRight];
    
    swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(swipeUpHandler:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [view addGestureRecognizer:swipeUp];
    
    swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(swipeDownHandler:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [view addGestureRecognizer:swipeDown];
  }
  return self;
}

- (void)swipeLeftHandler:(UISwipeGestureRecognizer *)sender {
  NSLog(@"left");
}

- (void)swipeRightHandler:(UISwipeGestureRecognizer *)sender {
  NSLog(@"right");
}

- (void)swipeUpHandler:(UISwipeGestureRecognizer *)sender {
  NSLog(@"up");
}

- (void)swipeDownHandler:(UISwipeGestureRecognizer *)sender {
  NSLog(@"down");
}

@end
