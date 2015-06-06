//
//  XDGestureRecognizer.h
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/04.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XDGestureManager.h"
#import "XDMotionManager.h"

@interface XDGestureRecognizer : NSObject

- (id)initWithView:(UIView *)view;

@property (nonatomic) XDGestureManager *gestureManager;
@property (nonatomic) XDMotionManager *motionManager;

@end
