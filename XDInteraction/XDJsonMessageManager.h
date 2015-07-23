//
//  XDJsonMessageManager.h
//  XDInteraction
//
//  Created by DCL_JT on 2015/06/16.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDJsonMessageManager : NSObject

- (NSMutableDictionary *)parseJsonMessage:(NSString *)jsonString;
- (NSString *)jsonInit;
- (NSString *)capturedKey:(NSString *)capturedKey;
- (NSString *)detectedSwipe:(NSString *)swipeDirection;
- (NSString *)detectedTap:(NSString *)tapType;
- (NSString *)detectedPinch:(NSString *)pinchType;
- (NSString *)detectedGyroX:(NSString *)x gyroY:(NSString *)y;

@property (nonatomic) NSString *endUser;
@property (nonatomic) NSString *myName;
@property (nonatomic) XDUserDefineModel *model;

@end
