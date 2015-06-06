//
//  XDGestureManager.h
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/06.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XDGestureManager : NSObject <UIGestureRecognizerDelegate>

- (id)initWithView:(UIView *)view;

@end
