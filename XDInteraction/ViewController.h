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
#import "XDGestureManager.h"

@interface ViewController : UIViewController <SRWebSocketDelegate,
                                              UITextFieldDelegate,
                                              XDGestureDelegate,
                                              XDJsonMessageDelegate> {
  SRWebSocket *socket;
  UITextView *textView;
}

@property (nonatomic) XDGestureUIComponents *gestureUIComponents;
@property (weak, nonatomic) IBOutlet UITextView *jsonTextview;

@end

