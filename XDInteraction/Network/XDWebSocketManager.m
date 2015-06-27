//
//  XDWebSocketManager.m
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/11.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "XDWebSocketManager.h"

@implementation XDWebSocketManager

- (id)initWith {
  self = [super init];
  if (self) {
    SRWebSocket *web_socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://localhost:4210"]]];
    [web_socket setDelegate:self];
    [web_socket open];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"aaaaaaa");
  }
  return self;
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
  [webSocket send:@"{\"id\":\"1\"}"];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
  NSLog(@"didReceiveMessage: %@", [message description]);
}

//When receiving type "users", please call this
- (void)receiveUsersMessage:(NSMutableDictionary *)usersList {
  if ([self.delegate respondsToSelector:@selector(updateUsersList:)]) {
    [self.delegate updateUsersList:usersList];
  }
}

@end
