//
//  XDJsonMessageManager.h
//  XDInteraction
//
//  Created by DCL_JT on 2015/06/16.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDJsonMessageManager : NSObject

- (NSString *)jsonInit;
- (NSString *)jsonMessageWith:(NSString *)capturedKey;

@end
