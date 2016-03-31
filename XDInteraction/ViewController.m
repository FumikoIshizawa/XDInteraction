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
@synthesize defineNavController;
@synthesize defineViewController;
@synthesize model;
@synthesize userName;
@synthesize isConnected;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.jsonTextview.editable = NO;
  self.firstView = YES;
  self.isConnected = false;

  outputView = [[XDOutputViewController alloc] init];
  defineViewController = [[XDUsersDefineViewController alloc] init];
  defineNavController = [[UINavigationController alloc] initWithRootViewController:defineViewController];
  model = [[XDUserDefineModel alloc] init];
  jsonMessage = [[XDJsonMessageManager alloc] initWithModel:model];
  
//  WSUIButton *ioButton =
//  [[WSUIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 280,
//                                               40,
//                                               60,
//                                               60)
//                          withTitle:@"input"];
//  [ioButton addTarget:self
//               action:@selector(ioButtonTapped:)
//     forControlEvents:UIControlEventTouchUpInside];
//  [self.view addSubview:ioButton];

//  WSUIButton *defineButton =
//  [[WSUIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 70,
//                                               40,
//                                               60,
//                                               60)
//                          withTitle:@"output"];
//  [defineButton addTarget:self
//               action:@selector(defineButtonTapped:)
//         forControlEvents:UIControlEventTouchUpInside];
//  [self.view addSubview:defineButton];

  gestureUIComponents = [[XDGestureUIComponents alloc] initWithView:self.view];

//  gestureUIComponents.keyLogManager.textField.delegate = self;
  gestureUIComponents.gestureManager.delegate = self;
  gestureUIComponents.tableView.delegate = self;
  gestureUIComponents.motionManager.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  if (self.firstView) {
    self.firstView = NO;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StartViewController" bundle:nil];
    StartViewController *startViewController = [storyboard instantiateInitialViewController];
    
    __weak typeof(self) wself = self;
    startViewController.userNameChangeBlock = ^(NSString *name) {
      wself.userName = name;
      wself.jsonMessage.myName = name;
    };
    startViewController.addressChangeBlock = ^(NSString *address) {
      [wself openWebSocket:address];
    };
    [startViewController loadViewData];
    
    [self presentViewController:startViewController animated:YES completion:nil];
  }
}

- (void)openWebSocket:(NSString *)address {
  NSString *url = @"ws://";
  url = [url stringByAppendingString:address];
  url = [url stringByAppendingString:@":5001"];
  web_socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
  
  [web_socket setDelegate:self];
  [web_socket open];
}

- (void)sendCustomMessage:(NSString *)message {
  NSString *json = [jsonMessage getJSONMessageWithCustomMessage:message];
  [web_socket send:json];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [defineViewController prepareForUse:model userName:userName];
  
  __weak typeof(self) wself = self;
  defineViewController.bipMessageSendBlock = ^(NSString* message) {
    if (wself.isConnected) {
      [wself sendBIPMessage:message];
    }
  };
  
  [self.buttonA setTitle:[model getButtonLeftActionTitle] forState:UIControlStateNormal];
  [self.buttonB setTitle:[model getButtonRightActionTitle] forState:UIControlStateNormal];
}

- (IBAction)defineButtonTouchUpInside:(UIButton *)sender {
    [self defineButtonTapped:sender];
}

- (IBAction)connectButtonTouchUpInside:(UIButton *)sender {
    [gestureUIComponents selectButtonTapped:sender];
}

- (void)sendBIPMessage:(NSString *)message {
  [web_socket send:message];
}

- (void)ioButtonTapped:(UIButton *)button {
//  [self presentViewController:outputView animated:YES completion:^{}];
}

- (void)defineButtonTapped:(UIButton *)button {
  [self presentViewController:defineNavController animated:YES completion:^{}];
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
  [web_socket send:jsonMessage.jsonInit];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
  [self.jsonTextview setText:[self.jsonTextview.text stringByAppendingString:message]];
  NSRange range = NSMakeRange(self.jsonTextview .text.length - 1, 1);
  [self.jsonTextview scrollRangeToVisible:range];
  
  NSMutableDictionary *dict = [jsonMessage parseJsonMessage:message];
  NSString *type = [dict objectForKey:@"type"];
  
  // Add new type!
  if ([type isEqualToString:@"users"]) {
    [self receiveUsersMessageWith:[dict objectForKey:@"names"]
                      withDevices:[dict objectForKey:@"devices"]];
  } else if ([type isEqualToString:@"error"]) {
    NSLog(@"Error: %@", [dict objectForKey:@"detail"]);
  } else if ([type isEqualToString:@"connected"]) {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Connection" message:@"ログの取得を開始しました" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
  } else if ([type isEqualToString:@"disconnected"]) {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Connection" message:@"ログの取得を停止しました" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
  } else if ([type isEqualToString:@"swipe"]) {
    if ([[dict objectForKey:@"detail"] isEqualToString:@"Up"]) {
      // 5 tmp
      [outputView scrollDownByChange:@"5"];
    } else if ([[dict objectForKey:@"detail"] isEqualToString:@"Down"]) {
      // 5 tmp
      [outputView scrollUpByChange:@"5" ];
    } else if ([[dict objectForKey:@"detail"] isEqualToString:@"Left"]) {
      [outputView goForwardPage];
    } else if ([[dict objectForKey:@"detail"] isEqualToString:@"Right"]) {
      [outputView goBackPage];
    }
  } else if ([type isEqualToString:@"key"]) {
    // debug
    [outputView updateMousePositionByChangeX:@"2"
                                     changeY:@"4"];
  } else if ([type isEqualToString:@"point"]) {
// TODO: implement :)
//    [outputView updateMousePositionByChangeX:[dict objectForKey:@"X"]
//                                     changeY:[dict objectForKey:@"Y"]];
  } else if ([type isEqualToString:@"click"]) {
    if ([[dict objectForKey:@"detail"] isEqualToString:@"single"]) {
      [outputView handleSingleClick];
    } else if ([[dict objectForKey:@"detail"] isEqualToString:@"double"]) {
      [outputView handleDoubleClick];
    }
  } else if ([type isEqualToString:@"pinch"]) {

  }
}

//When receiving type "users", please call this
- (void)receiveUsersMessageWith:(NSArray *)names
                    withDevices:(NSArray *)devices {
  if ([names indexOfObject:jsonMessage.endUser] == NSNotFound
          && ![jsonMessage.endUser isEqualToString:@"no user"]) {
    UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@"User Lost"
                                            message:@"Please Select endUser."
                                     preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {}]];
    [self presentViewController:alertController animated:YES completion:nil];
    self.isConnected = false;
  }
  [gestureUIComponents.tableView updateTableViewWith:names
                                         withDevices:devices];
}

- (IBAction)buttonLeftTouchUpInside:(UIButton *)sender {
  NSString *message = [jsonMessage getJSONMessageWithType:@"ButtonLeft"];
  if (message != nil && isConnected) {
    [web_socket send:message];
  }
  NSLog(@"Detected: Button left");
}

- (IBAction)buttonRightTouchUpInside:(UIButton *)sender {
  NSString *message = [jsonMessage getJSONMessageWithType:@"ButtonRight"];
  if (message != nil && isConnected) {
    [web_socket send:message];
  }
  NSLog(@"Detected: Button right");
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
//  [self.gestureUIComponents.keyLogManager endEditing:YES];
  NSLog(@"%@", textField.text);
  textField.text = @"";
  
  [web_socket sendPing:nil];
  return YES;
}

-(BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
//  NSString *message = [jsonMessage capturedKey:string];
//  [web_socket send:message];

  return YES;
}

#pragma XDGestureDelegate
- (void)swipeLeftSender {
  NSString *message = [jsonMessage getJSONMessageWithType:@"SwipeLeft"];
  if (message != nil && isConnected) {
    [web_socket send:message];
  }
  NSLog(@"Detected: SwipeLeft");
}

- (void)swipeRightSender {
  NSString *message = [jsonMessage getJSONMessageWithType:@"SwipeRight"];
  if (message != nil && isConnected) {
    [web_socket send:message];
  }
  NSLog(@"Detected: SwipeRight");
}

- (void)swipeUpSender {
  NSString *message = [jsonMessage getJSONMessageWithType:@"SwipeUp"];
  if (message != nil && isConnected) {
    [web_socket send:message];
  }
  NSLog(@"Detected: SwipeUp");
}

- (void)swipeDownSender {
  NSString *message = [jsonMessage getJSONMessageWithType:@"SwipeDown"];
  if (message != nil && isConnected) {
    [web_socket send:message];
  }
  NSLog(@"Detected: SwipeDown");
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"Please select"
                                        message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
  NSString *connectionMessage = isConnected ? @"Stop" : @"Start";
  [alertController addAction:
     [UIAlertAction actionWithTitle:connectionMessage
                              style:UIAlertActionStyleDefault
                            handler: ^(UIAlertAction *action) {
                              [self startOrStopConnection:tableView
                                  didSelectRowAtIndexPath:indexPath
                               ];
                            }]];
  [alertController addAction:
     [UIAlertAction actionWithTitle:@"Send Message"
                              style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction *action) {
                              [self sendCustomMessage];
                            }]];
  alertController.popoverPresentationController.sourceView = self.view;
  alertController.popoverPresentationController.sourceRect = CGRectMake(100.0, 100.0, 20.0, 20.0);
  [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                      style:  UIAlertActionStyleCancel
                                                    handler:nil]];
  [self presentViewController:alertController animated:YES completion:nil];
  [gestureUIComponents showTableView];
}

- (void)startOrStopConnection:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  if (isConnected && [jsonMessage.myName
                      isEqualToString:gestureUIComponents.tableView.usersNameList[indexPath.row]]) {
    NSString *message = [jsonMessage getJSONMessageForDisconnect];
    [web_socket send:message];
    isConnected = false;
  } else if (!isConnected) {
    jsonMessage.endUser = gestureUIComponents.tableView.usersNameList[indexPath.row];
    NSString *message = [jsonMessage getJSONMessageForConnect];
    [web_socket send:message];
    isConnected = true;
  }
}

- (void)sendCustomMessage {
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StartViewController" bundle:nil];
  StartViewController *messageViewController = [storyboard instantiateInitialViewController];
  
  __weak typeof(self) wself = self;

  messageViewController.isStartView = false;
  messageViewController.sendMessageBlock = ^(NSString *message) {
    [wself sendCustomMessage:message];
  };
  
  [self presentViewController:messageViewController animated:YES completion:nil];
  [messageViewController loadViewData];
}

#pragma -
#pragma mark tapSender
- (void)singleTapSender {
  NSString *message = [jsonMessage getJSONMessageWithType:@"SingleTap"];
  if (message != nil && isConnected) {
    [web_socket send:message];
  }
  NSLog(@"Detected: SingleTap");
}

- (void)doubleTapSender {
  NSString *message = [jsonMessage getJSONMessageWithType:@"DoubleTap"];
  if (message != nil && isConnected) {
    [web_socket send:message];
  }
  NSLog(@"Detected: DoubleTap");
}
#pragma -
#pragma mark
- (void)pinchSender:(CGFloat)scale {
  NSString *message;
  if(scale >= 1.0f){
    NSLog(@"Pinching IN: %f", scale);
    message = [jsonMessage getJSONMessageWithType:@"PinchIn"];
    NSLog(@"Detected: PinchIn");
  }
  else{
    NSLog(@"Pinching OUT: %f", scale);
    message = [jsonMessage getJSONMessageWithType:@"PinchOut"];
    NSLog(@"Detected: PinchOut");
  }
  if (message != nil && isConnected) {
    [web_socket send:message];
  }
}

#pragma -
#pragma mark
- (void)motionUpSender {
  NSString *message = [jsonMessage getJSONMessageWithType:@"GyroUp"];
  if (message != nil && isConnected) {
    [web_socket send:message];
  }
  NSLog(@"Detected: GyroUp");
}

- (void)motionDownSender {
  NSString *message = [jsonMessage getJSONMessageWithType:@"GyroDown"];
  if (message != nil && isConnected) {
    [web_socket send:message];
  }
  NSLog(@"Detected: GyroDown");
}

@end
