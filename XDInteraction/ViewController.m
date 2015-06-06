//
//  ViewController.m
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/04.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize gestureRecognizer;

- (void)viewDidLoad {
  [super viewDidLoad];
  gestureRecognizer = [[XDGestureRecognizer alloc] initWithView:self.view];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
