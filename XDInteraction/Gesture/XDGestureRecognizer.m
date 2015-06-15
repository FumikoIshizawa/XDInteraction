//
//  XDGestureRecognizer.m
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/04.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "XDGestureRecognizer.h"

@interface XDGestureRecognizer () {
  UIView *parentView;
}

@end

@implementation XDGestureRecognizer

@synthesize gestureManager;
@synthesize motionManager;
@synthesize keyLogManager;

- (id)initWithView:(UIView *)view {
  self = [super init];
  if (self) {
    parentView = view;
    gestureManager = [[XDGestureManager alloc] initWithView:view];
    motionManager = [[XDMotionManager alloc] initWith];
    keyLogManager = [[XDKeyLogManager alloc] initWithView:view];
    
    UIButton *inputButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    inputButton.frame = CGRectMake(view.frame.size.width - 60,
                                   40,
                                   50,
                                   30);
    [inputButton setTitle:@"Input"
                 forState:UIControlStateNormal];
    [inputButton addTarget:self
                    action:@selector(buttonTapped:)
          forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:inputButton];
  }
  return self;
}

- (void)buttonTapped:(UIButton *)button {
  NSLog(@"Open input view");
  [parentView addSubview:keyLogManager];
  [UIView animateWithDuration:0.2f
                        delay:0.0f
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^{
                     keyLogManager.frame = CGRectMake(0,
                                                      0,
                                                      parentView.frame.size.width,
                                                      parentView.frame.size.height);
                   }
                   completion:nil];
}

@end
