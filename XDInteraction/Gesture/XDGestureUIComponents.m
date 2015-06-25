//
//  XDGestureUIComponents.m
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/04.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "XDGestureUIComponents.h"

@interface XDGestureUIComponents () {
  UIView *parentView;
  BOOL _keyLogOpend;
  BOOL _tableViewOpend;
}

@end

@implementation XDGestureUIComponents

@synthesize gestureManager;
@synthesize motionManager;
@synthesize keyLogManager;
@synthesize tableView;

- (id)initWithView:(UIView *)view {
  self = [super init];
  if (self) {
    parentView = view;
    gestureManager = [[XDGestureManager alloc] initWithView:view];
    motionManager = [[XDMotionManager alloc] initWith];
    keyLogManager = [[XDKeyLogManager alloc] initWithView:view];
    tableView = [[XDUsersTableView alloc] init];
    _keyLogOpend = NO;
    _tableViewOpend = NO;
    
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(parentView.frame.size.width - 80, 0);
    CGAffineTransform t2 = CGAffineTransformScale(t1, 1/240, 1/150);
    keyLogManager.transform = t2;
    tableView.transform = t2;
    
    [parentView addSubview:keyLogManager];
    [parentView addSubview:tableView];
    
    WSUIButton *inputButton =
        [[WSUIButton alloc] initWithFrame:CGRectMake(view.frame.size.width - 70,
                                                     40,
                                                     60,
                                                     60)
                                withTitle:@"input"];
    [inputButton addTarget:self
                    action:@selector(inputButtonTapped:)
          forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:inputButton];
    
    WSUIButton *selectButton =
        [[WSUIButton alloc] initWithFrame:CGRectMake(view.frame.size.width - 70,
                                                     110,
                                                     60,
                                                     60)
                                withTitle:@"select"];
    [selectButton addTarget:self
                    action:@selector(selectButtonTapped:)
          forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:selectButton];
  }
  return self;
}

- (void)inputButtonTapped:(UIButton *)button {
  if (_keyLogOpend) {
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                       CGAffineTransform t1 =
                       CGAffineTransformMakeTranslation(parentView.frame.size.width - 80, 0);
                       CGAffineTransform t2 = CGAffineTransformScale(t1, 1/240, 1/150);
                       keyLogManager.transform = t2;
                     }
                     completion:^(BOOL finished){
                     }];
    _keyLogOpend= NO;
  } else {
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                       CGAffineTransform t1 = CGAffineTransformMakeScale(1, 1);
                       CGAffineTransform t2 = CGAffineTransformTranslate(t1, 0, 0);
                       keyLogManager.transform = t2;
                     }
                     completion:^(BOOL finished) {
                     }];
    _keyLogOpend= YES;
  }
}

- (void)selectButtonTapped:(UIButton *)button {
  if (_tableViewOpend) {
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                       CGAffineTransform t1 =
                       CGAffineTransformMakeTranslation(parentView.frame.size.width - 80, 0);
                       CGAffineTransform t2 = CGAffineTransformScale(t1, 1/240, 1/150);
                       tableView.transform = t2;
                     }
                     completion:^(BOOL finished){
                     }];
    _tableViewOpend = NO;
  } else {
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                       CGAffineTransform t1 = CGAffineTransformMakeScale(1, 1);
                       CGAffineTransform t2 = CGAffineTransformTranslate(t1, 0, 0);
                       tableView.transform = t2;
                     }
                     completion:^(BOOL finished) {
                     }];
    _tableViewOpend = YES;
  }
}

@end
