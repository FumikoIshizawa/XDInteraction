//
//  XDOutputViewController.m
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/27.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "XDOutputViewController.h"

@implementation XDOutputViewController

- (id)init {
  self = [super init];
  if (self) {
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
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

  }
  return self;
}

- (void)ioButtonTapped:(UIButton *)button {
  [self dismissViewControllerAnimated:YES completion:^{}];
}


@end
