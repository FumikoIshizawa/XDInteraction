//
//  ViewController.m
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/04.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "ViewController.h"
#include "TargetConditionals.h"

@interface ViewController (){
  SRWebSocket *web_socket;
}

@end

@implementation ViewController

@synthesize gestureUIComponents;
@synthesize jsonMessage;
@synthesize outputView;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.jsonTextview.editable = NO;
  
  jsonMessage = [[XDJsonMessageManager alloc] init];
  outputView = [[XDOutputViewController alloc] init];
  WSUIButton *ioButton =
  [[WSUIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 70,
                                               40,
                                               60,
                                               60)
                          withTitle:@"input"];
  [ioButton addTarget:self
               action:@selector(ioButtonTapped:)
     forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:ioButton];
  
  gestureUIComponents = [[XDGestureUIComponents alloc] initWithView:self.view];

  gestureUIComponents.keyLogManager.textField.delegate = self;
  gestureUIComponents.gestureManager.delegate = self;
  
#if TARGET_IPHONE_SIMULATOR
  web_socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://localhost:5001"]]];//192.168.10.67
#else
  web_socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.10.54:5001"]]];//192.168.10.67
#endif
  
  [web_socket setDelegate:self];
  [web_socket open];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)ioButtonTapped:(UIButton *)button {
  [self presentViewController:outputView animated:YES completion:^{}];
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
  XDJsonMessageManager *message = [[XDJsonMessageManager alloc] init];

  [web_socket send:message.jsonInit];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
  [self.jsonTextview setText:[self.jsonTextview.text stringByAppendingString:message]];
  NSRange range = NSMakeRange(self.jsonTextview .text.length - 1, 1);
  [self.jsonTextview scrollRangeToVisible:range];
  
  NSMutableDictionary *dict = [jsonMessage parseJsonMessage:message];
  NSString *type = [dict objectForKey:@"type"];
  
  // Add new type!
  if ([type isEqualToString:@"users"]) {
    NSLog(@"users recieved");
  } else if ([type isEqualToString:@"error"]) {
    NSLog(@"error recieved");
  } else if ([type isEqualToString:@"swipe"]) {
    
  } else if ([type isEqualToString:@"key"]) {
    
  }
}

//When receiving type "users", please call this
- (void)receiveUsersMessage:(NSMutableDictionary *)usersList {
  [gestureUIComponents.tableView updateTableView:usersList];
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
  NSString *message = [jsonMessage capturedKey:string];
  [web_socket send:message];
  
  return YES;
}

#pragma XDGestureDelegate
- (void)swipeLeftSender {
  NSString *message = [jsonMessage detectedSwipe:@"Left"];
  [web_socket send:message];
}

- (void)swipeRightSender {
  NSString *message = [jsonMessage detectedSwipe:@"Right"];
  [web_socket send:message];}

- (void)swipeUpSender {
  NSString *message = [jsonMessage detectedSwipe:@"Up"];
  [web_socket send:message];}

- (void)swipeDownSender {
  NSString *message = [jsonMessage detectedSwipe:@"Down"];
  [web_socket send:message];}

@end
