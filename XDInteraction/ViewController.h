//
//  ViewController.h
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/04.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XDGestureRecognizer.h"
#import "XDWebSocketManager.h"
#import "SRWebSocket.h"

@interface ViewController : UIViewController <SRWebSocketDelegate> {
  SRWebSocket *socket;
}

@property (nonatomic) XDGestureRecognizer *gestureRecognizer;

@end

