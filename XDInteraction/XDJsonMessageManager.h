//
//  XDJsonMessageManager.h
//  XDInteraction
//
//  Created by DCL_JT on 2015/06/16.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDJsonMessageManager : NSObject

- (NSString *)jsonInit;
- (NSString *)capturedKey:(NSString *)capturedKey;
- (NSString *)detectedSwipe:(NSString *)swipeDirection;
- (NSString *)detectedTap:(NSString *)tapType;
- (NSString *)detectedPinch:(NSString *)pinchType;

@end
