//
//  XDMotionManager.h
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/06.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import <Foundation/Foundation.h>

@protocol XDMotionDelegate <NSObject>

- (void)motionUpSender;
- (void)motionDownSender;

@end

@interface XDMotionManager : NSObject 

- (id)initWith;

@property (nonatomic, assign) id<XDMotionDelegate> delegate;

@end
