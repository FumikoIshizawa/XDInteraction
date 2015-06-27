//
//  XDKeyLogManager.m
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/07.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "XDKeyLogManager.h"

@interface XDKeyLogManager () {
  UIView *parentView;
}

@end

@implementation XDKeyLogManager

@synthesize textField;

- (id)initWithView:(UIView *)view {
  self = [super init];
  if (self) {
    parentView = view;
    self.frame = CGRectMake(40,
                            140,
                            240,
                            150);
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.9];
    
    textField =
        [[UITextField alloc] initWithFrame:CGRectMake((parentView.frame.size.width - 80) / 2 - 100,
                                                        50,
                                                        200,
                                                        50)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.delegate = self;
    [self addSubview:textField];
  }
  
  return self;
}

@end
