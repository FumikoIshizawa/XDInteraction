//
//  XDOutputViewController.m
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/27.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "XDOutputViewController.h"

@implementation XDOutputViewController

@synthesize positionX;
@synthesize positionY;
@synthesize mouse;
@synthesize webView1;
@synthesize currentURL;
@synthesize currentPosition;

- (id)init {
  self = [super init];
  if (self) {
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.positionX = 50;
    self.positionY = 100;
    
    webView1 = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView1];
    currentURL = [NSURL URLWithString:@"http://google.com"];
    [webView1 loadRequest:[NSURLRequest requestWithURL:currentURL]];
    
    WSUIButton *ioButton =
    [[WSUIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 70,
                                                 40,
                                                 60,
                                                 60)
                            withTitle:@"output"];
    [ioButton addTarget:self
                 action:@selector(ioButtonTapped:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ioButton];
    
    mouse = [[UIImageView alloc] initWithFrame:CGRectMake(self.positionX, self.positionY, 20, 20)];
    mouse.image = [UIImage imageNamed:@"mouse"];
    [self.view addSubview:mouse];
  }
  return self;
}

- (void)ioButtonTapped:(UIButton *)button {
  [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)updateMousePositionByChangeX:(NSString *)changeX
                             changeY:(NSString *)changeY {
  positionX += [changeX intValue];
  positionY += [changeY intValue];
  [UIView animateWithDuration:0.2f
                        delay:0.0f
                      options:UIViewAnimationOptionCurveLinear
                   animations:^{
                     mouse.frame = CGRectMake(positionX,
                                              positionY,
                                              20,
                                              20);
                   }
                   completion:nil];
}

- (void)scrollUpByChange:(NSString *)changeUp {
  //TODO: Change scroll size - webView1.bounds.size.height / 3
  [self.webView1.scrollView setContentOffset:CGPointMake(webView1.scrollView.contentOffset.x,
                                                         MAX(webView1.scrollView.contentOffset.y -
                                                             webView1.bounds.size.height / 3, 0))
                                    animated:YES];
}

- (void)scrollDownByChange:(NSString *)changeDown {
  float maxOffset =
      self.webView1.scrollView.contentSize.height - webView1.scrollView.frame.size.height;
  [self.webView1.scrollView setContentOffset:CGPointMake(webView1.scrollView.contentOffset.x,
                                                         MIN(webView1.scrollView.contentOffset.y
                                                             + webView1.bounds.size.height / 3,
                                                             maxOffset))
                                    animated:YES];
}

- (void)goBackPage {
  if ([webView1 canGoBack]) {
    [webView1 goBack];
  }
}

- (void)goForwardPage {
  if ([webView1 canGoForward]) {
    [webView1 goForward];
  }
}

- (void)handleSingleClick {
  NSString *script = [NSString stringWithFormat:@"var ev = document.createEvent('MouseEvents'); var el = document.elementFromPoint(%d,%d); ev.initMouseEvent('click', true, true, window, null, %d, %d, %d, %d, false, false, false, false, 0, null); el.dispatchEvent(ev);" , positionX, positionY, positionX, positionY, positionX, positionY];
  [webView1 stringByEvaluatingJavaScriptFromString:script];
}

@end
