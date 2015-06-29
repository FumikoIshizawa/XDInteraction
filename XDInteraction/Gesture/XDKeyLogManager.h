//
//  XDKeyLogManager.h
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/07.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDKeyLogManager : UIView <UITextFieldDelegate>

@property (nonatomic) UITextField *textField;

- (id)initWithView:(UIView *)parentView;

@end
