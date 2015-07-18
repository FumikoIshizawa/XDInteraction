//
//  XDOutputViewController.h
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/27.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WSUIButton.h"

@interface XDOutputViewController : UIViewController

- (id)init;
- (void)updateMousePositionByChangeX:(NSString *)changeX changeY:(NSString *)changeY;
- (void)scrollUpByChange:(NSString *)changeUp;
- (void)scrollDownByChange:(NSString *)changeDown;
- (void)goBackPage;
- (void)goForwardPage;
- (void)handleSingleClick;
- (void)handleDoubleClick;

@property (nonatomic) NSInteger positionX;
@property (nonatomic) NSInteger positionY;
@property (nonatomic) UIImageView *mouse;
@property (nonatomic) UIWebView *webView1;
@property (nonatomic) NSURL *currentURL;
@property (nonatomic) NSInteger currentPosition;

@end
