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

@interface ViewController : UIViewController <SRWebSocketDelegate,
                                              UITextFieldDelegate,
                                              XDGestureDelegate> {
  SRWebSocket *socket;
  UITextView *textView;
}

@property (nonatomic) XDGestureUIComponents *gestureUIComponents;
@property (nonatomic) XDOutputViewController *outputView;
@property (nonatomic) XDJsonMessageManager *jsonMessage;
@property (weak, nonatomic) IBOutlet UITextView *jsonTextview;

@end

