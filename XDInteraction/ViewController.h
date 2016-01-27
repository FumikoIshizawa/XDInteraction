//
//  ViewController.h
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/04.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XDGestureUIComponents.h"
#import "XDWebSocketManager.h"
#import "SRWebSocket.h"
#import "XDJsonMessageManager.h"
#import "XDGestureManager.h"
#import "XDOutputViewController.h"
#import "XDInteraction-Swift.h"

@interface ViewController : UIViewController <SRWebSocketDelegate,
                                              UITextFieldDelegate,
                                              XDGestureDelegate,
                                              UITableViewDelegate,
                                              XDMotionDelegate> {
  SRWebSocket *socket;
  UITextView *textView;
}

@property (nonatomic) XDGestureUIComponents *gestureUIComponents;
@property (nonatomic) XDOutputViewController *outputView;
@property (nonatomic) UINavigationController *defineNavController;
@property (nonatomic) XDUsersDefineViewController *defineViewController;
@property (nonatomic) XDJsonMessageManager *jsonMessage;
@property (weak, nonatomic) IBOutlet UITextView *jsonTextview;
@property (nonatomic) XDUserDefineModel *model;
@property (weak, nonatomic) IBOutlet UIButton *buttonA;
@property (weak, nonatomic) IBOutlet UIButton *buttonB;

@end

