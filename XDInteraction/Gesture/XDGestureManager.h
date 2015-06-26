//
//  XDGestureManager.h
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/06.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol XDGestureDelegate <NSObject>

- (void)swipeLeftSender;
- (void)swipeUpSender;
- (void)swipeDownSender;
- (void)swipeRightSender;

- (void)singleTapSender;
- (void)doubleTapSender;

@end

@interface XDGestureManager : NSObject <UIGestureRecognizerDelegate>

- (id)initWithView:(UIView *)view;

@property (nonatomic, assign) id<XDGestureDelegate> delegate;

@end
