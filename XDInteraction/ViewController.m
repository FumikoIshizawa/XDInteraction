//
//  ViewController.m
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/04.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "ViewController.h"
#import "XDJsonMessageManager.h"
#include "TargetConditionals.h"

@interface ViewController (){
  SRWebSocket *web_socket;
}

@end

@implementation ViewController

@synthesize gestureUIComponents;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  gestureUIComponents = [[XDGestureUIComponents alloc] initWithView:self.view];

  gestureUIComponents.keyLogManager.textField.delegate = self;
  gestureUIComponents.gestureManager.delegate = self;
  
#if TARGET_IPHONE_SIMULATOR
  web_socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://localhost:5001"]]];//192.168.10.67
#else
  web_socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.10.54:5001"]]];//192.168.10.67
#endif
  web_socket.delegate = self;
  
  [socket setDelegate:self];
  [socket open];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
  XDJsonMessageManager *message = [[XDJsonMessageManager alloc] init];

  [web_socket send:message.jsonInit];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
  NSLog(@"%@", [message description]);
  [self.jsonTextview setText:[self.jsonTextview.text stringByAppendingString:message]];
  NSRange range = NSMakeRange(self.jsonTextview .text.length - 1, 1);
  [self.jsonTextview scrollRangeToVisible:range];
}

#pragma mark -
#pragma mark Pong
- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload;
{
  NSLog(@"server received pong");
}

#pragma mark -
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma UITextFiled
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self.gestureUIComponents.keyLogManager endEditing:YES];
  NSLog(@"%@", textField.text);
  textField.text = @"";
  
  [web_socket sendPing:nil];
  return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  XDJsonMessageManager *jsonMessage = [[XDJsonMessageManager alloc] init];
  NSString *message = [jsonMessage capturedKey:string];
  [web_socket send:message];
  
  return YES;
}

#pragma XDGestureDelegate
- (void)swipeLeftSender {
  XDJsonMessageManager *jsonMessage = [[XDJsonMessageManager alloc] init];
  NSString *message = [jsonMessage detectedSwipe:@"Left"];
  [web_socket send:message];
}

- (void)swipeRightSender {
  XDJsonMessageManager *jsonMessage = [[XDJsonMessageManager alloc] init];
  NSString *message = [jsonMessage detectedSwipe:@"Right"];
  [web_socket send:message];}

- (void)swipeUpSender {
  XDJsonMessageManager *jsonMessage = [[XDJsonMessageManager alloc] init];
  NSString *message = [jsonMessage detectedSwipe:@"Up"];
  [web_socket send:message];}

- (void)swipeDownSender {
  XDJsonMessageManager *jsonMessage = [[XDJsonMessageManager alloc] init];
  NSString *message = [jsonMessage detectedSwipe:@"Down"];
  [web_socket send:message];}

#pragma XDJsonMessageDelegate
- (void)updateUsersList:(NSMutableDictionary *)users {
  [gestureUIComponents.tableView updateTableView:users];
}

@end
