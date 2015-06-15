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

- (id)initWithView:(UIView *)view {
  self = [super init];
  if (self) {
    parentView = view;
    self.frame = CGRectMake(view.frame.size.width / 2,
                            view.frame.size.height / 2,
                            0,
                            0);
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    self.textField =
        [[UITextField alloc] initWithFrame:CGRectMake(view.frame.size.width / 2 - 100,
                                                      view.frame.size.height / 2 - 60,
                                                      200,
                                                      50)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.delegate = self;
    
    [self addSubview:self.textField];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeButton.frame = CGRectMake(view.frame.size.width / 2 - 50,
                                   view.frame.size.height / 2,
                                   100,
                                   50);
    [closeButton setTitle:@"close"
                 forState:UIControlStateNormal];
    [closeButton addTarget:self
                    action:@selector(closeButtonTapped:)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
  }
  
  return self;
}

- (void)closeButtonTapped:(UIButton *)button {
  [UIView animateWithDuration:0.2f
                        delay:0.0f
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^{
                     self.frame = CGRectMake(parentView.frame.size.width / 2,
                                             parentView.frame.size.height / 2,
                                             0,
                                             0);
                   }
                   completion:^(BOOL finished){
                     [self removeFromSuperview];
                   }];
  
}

#pragma UITextFiled
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self endEditing:YES];
  NSLog(@"%@", textField.text);
  textField.text = @"";
  
  return YES;
}



@end
