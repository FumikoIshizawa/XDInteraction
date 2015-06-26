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

@synthesize gestureRecognizer;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  gestureRecognizer = [[XDGestureRecognizer alloc] initWithView:self.view];

  gestureRecognizer.keyLogManager.textField.delegate = self;
  gestureRecognizer.gestureManager.delegate = self;
  
  
#if TARGET_IPHONE_SIMULATOR
  web_socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://localhost:10001"]]];//192.168.10.67
#else
  web_socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.10.3:5001"]]];//192.168.10.67
#endif
  
  [web_socket setDelegate:self];
  [web_socket open];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
  XDJsonMessageManager *message = [[XDJsonMessageManager alloc] init];
  [web_socket send:message.jsonInit];
  
  // Begin 10sec-interval pinging function
  NSTimer *pingTimer = [NSTimer scheduledTimerWithTimeInterval:10.0f
                                                        target:self
                                                      selector:@selector(firePing:)
                                                      userInfo:nil
                                                       repeats:YES];
  [pingTimer fire];
}

- (void)firePing:(NSTimer *)timer {
  NSLog(@"send a Ping");
  [web_socket sendPing:nil];
  
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
  [self.gestureRecognizer.keyLogManager endEditing:YES];
  NSLog(@"%@", textField.text);
  textField.text = @"";
  
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
  [web_socket send:message];
}

- (void)swipeUpSender {
  XDJsonMessageManager *jsonMessage = [[XDJsonMessageManager alloc] init];
  NSString *message = [jsonMessage detectedSwipe:@"Up"];
  [web_socket send:message];
}

- (void)swipeDownSender {
  XDJsonMessageManager *jsonMessage = [[XDJsonMessageManager alloc] init];
  NSString *message = [jsonMessage detectedSwipe:@"Down"];
  [web_socket send:message];
}

- (void)singleTapSender {
  NSLog(@"singleTapped");
}

- (void)doubleTapSender {
  NSLog(@"doubleTapped");
}

- (void)pinchSender:(CGFloat)scale {
  if(scale >= 1.0f){
    NSLog(@"Pinching IN: %f", scale);
  }
  else{
    NSLog(@"Pinching OUT: %f", scale);
  }
  
}

@end
