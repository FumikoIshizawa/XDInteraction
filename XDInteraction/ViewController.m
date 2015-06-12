//
//  ViewController.m
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/04.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize gestureRecognizer;

- (void)viewDidLoad {
  [super viewDidLoad];
  gestureRecognizer = [[XDGestureRecognizer alloc] initWithView:self.view];
//  XDWebSocketManager *socketManager = [[XDWebSocketManager alloc] initWith];
  
  SRWebSocket *web_socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.10.80:4210"]]];
  [web_socket setDelegate:self];
  [web_socket open];
  // Do any additional setup after loading the view, typically from a nib.
  NSLog(@"aaaaaaa");
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
  [webSocket send:@"{\"id\":\"1\"}"];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
  NSLog(@"didReceiveMessage: %@", [message description]);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
