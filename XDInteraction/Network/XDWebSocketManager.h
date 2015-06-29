//
//  XDWebSocketManager.h
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/11.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SRWebSocket.h"

@protocol XDJsonMessageDelegate <NSObject>

- (void)updateUsersList:(NSMutableDictionary *)users;

@end

@interface XDWebSocketManager : NSObject <SRWebSocketDelegate> {
  SRWebSocket *socket;
}

- (id)initWith;

@property (nonatomic, assign) id<XDJsonMessageDelegate> delegate;

@end
