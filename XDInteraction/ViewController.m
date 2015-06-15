//
//  ViewController.m
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/04.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "ViewController.h"

#include "TargetConditionals.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize gestureRecognizer;

- (void)viewDidLoad {
  [super viewDidLoad];
  gestureRecognizer = [[XDGestureRecognizer alloc] initWithView:self.view];
//  XDWebSocketManager *socketManager = [[XDWebSocketManager alloc] initWith];
  
#if TARGET_IPHONE_SIMULATOR
  SRWebSocket *web_socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://localhost:5001"]]];//192.168.10.67
#else
  SRWebSocket *web_socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.10.54:5001"]]];//192.168.10.67
#endif
  
  [web_socket setDelegate:self];
  [web_socket open];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  NSError *error = nil;
#if TARGET_IPHONE_SIMULATOR
  [dict setObject:@"open" forKey:@"type"];
  [dict setObject:@"iphone5" forKey:@"name"];
  [dict setObject:@"ios_sim" forKey:@"device"];
  NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                 options:NSJSONWritingPrettyPrinted
                                                   error:&error];
  NSString *jsonstr = [[NSString alloc] initWithData:data
                                            encoding:NSUTF8StringEncoding];
  NSLog(@"%@", jsonstr);
  NSString *json = [jsonstr stringByReplacingOccurrencesOfString:@"\n"
                                                      withString:@""];
  [webSocket send:json];
#else
  [dict setObject:@"open" forKey:@"type"];
  [dict setObject:@"sim" forKey:@"name"];
  [dict setObject:@"ios_dev" forKey:@"device"];
  NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                 options:NSJSONWritingPrettyPrinted
                                                   error:&error];
  NSString *jsonstr = [[NSString alloc] initWithData:data
                                            encoding:NSUTF8StringEncoding];
  NSLog(@"%@", jsonstr);
  NSString *json = [jsonstr stringByReplacingOccurrencesOfString:@"\n"
                                                      withString:@""];
  [webSocket send:json];
#endif
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
  NSLog(@"%@", [message description]);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
