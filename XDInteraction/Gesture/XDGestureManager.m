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
  if ([self.delegate respondsToSelector:@selector(swipeLeftSender)]) {
    [self.delegate swipeLeftSender];
  }
}

- (void)swipeRightHandler:(UISwipeGestureRecognizer *)sender {
  if ([self.delegate respondsToSelector:@selector(swipeRightSender)]) {
    [self.delegate swipeRightSender];
  }
}

- (void)swipeUpHandler:(UISwipeGestureRecognizer *)sender {
  if ([self.delegate respondsToSelector:@selector(swipeUpSender)]) {
    [self.delegate swipeUpSender];
  }
}

- (void)swipeDownHandler:(UISwipeGestureRecognizer *)sender {
  if ([self.delegate respondsToSelector:@selector(swipeDownSender)]) {
    [self.delegate swipeDownSender];
  }
}


@end
