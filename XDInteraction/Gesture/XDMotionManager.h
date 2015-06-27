//
//  XDMotionManager.h
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/06.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import <Foundation/Foundation.h>

@protocol XDMotionManagerDelegate <NSObject>

- (void)motionSender:(NSString *)motion;

@end

@interface XDMotionManager : NSObject 
@property (nonatomic, assign) id<XDMotionManagerDelegate> delegate;
- (id)initWith;
- (void)motionHandler;
@end
