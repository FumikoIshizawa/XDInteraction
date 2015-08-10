//
//  XDJsonMessageManager.h
//  XDInteraction
//
//  Created by DCL_JT on 2015/06/16.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XDInteraction-Swift.h"

typedef NS_ENUM(NSInteger, actionType) {
  ScrollUp,
  ScrollDown,
  ZoomIn,
  ZoomOut,
  TextBig,
  TextSmall,
  NextPage,
  SwitchWindow,
  NoGesture,
};

typedef NS_ENUM(NSInteger, Window) {
  Window1,
  Window2,
};

@interface XDJsonMessageManager : NSObject

- initWithModel:(XDUserDefineModel *)model;

- (NSMutableDictionary *)parseJsonMessage:(NSString *)jsonString;
- (NSString *)jsonInit;
- (NSString *)getJSONMessageWithType:(NSString *)type;

@property (nonatomic) NSString *endUser;
@property (nonatomic) NSString *myName;
@property (nonatomic) XDUserDefineModel *model;
@property (nonatomic) Window window;

@end
