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

  UIButton *inputButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  inputButton.frame = CGRectMake(20,
                                 40,
                                 50,
                                 30);
  [inputButton setTitle:@"Send"
               forState:UIControlStateNormal];
  [inputButton addTarget:self
                  action:@selector(buttonTapped:)
        forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:inputButton];
  
  textView =[[UITextView alloc] initWithFrame:CGRectMake(20, 100, 270, 400)];
  textView.editable = NO;
  textView.backgroundColor = [UIColor grayColor];
  [self.view addSubview:textView];
  
#if TARGET_IPHONE_SIMULATOR
  socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://localhost:5001"]]];//192.168.10.67
#else
  socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.10.67:5001"]]];//192.168.10.67
#endif
  
  [socket setDelegate:self];
  [socket open];
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
  NSLog(@"Received: %@", [message description]);
  textView.text = [textView.text stringByAppendingString:[message description]];
}

- (void)buttonTapped:(UIButton *)button {
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  NSError *error = nil;
  NSLog(@"Open input view");
  [dict setObject:@"com" forKey:@"type"];
  [dict setObject:@"swipe" forKey:@"command"];
  [dict setObject:@"up" forKey:@"detail"];
#if TARGET_IPHONE_SIMULATOR
  [dict setObject:@"sim" forKey:@"dst"];
  [dict setObject:@"iphone5" forKey:@"origin"];
#else
  [dict setObject:@"iphone5" forKey:@"dst"];
  [dict setObject:@"sim" forKey:@"origin"];
#endif
  NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                 options:NSJSONWritingPrettyPrinted
                                                   error:&error];
  NSString *jsonstr = [[NSString alloc] initWithData:data
                                            encoding:NSUTF8StringEncoding];
  NSLog(@"%@", jsonstr);
  NSString *json = [jsonstr stringByReplacingOccurrencesOfString:@"\n"
                                                      withString:@""];
  [socket send:json];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
