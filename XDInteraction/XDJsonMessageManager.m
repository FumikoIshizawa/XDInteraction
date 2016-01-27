//
//  XDJsonMessageManager.m
//  XDInteraction
//
//  Created by DCL_JT on 2015/06/16.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "XDJsonMessageManager.h"
#include <TargetConditionals.h>

@implementation XDJsonMessageManager

@synthesize endUser;
@synthesize myName;
@synthesize model;

- (id)initWithModel:(XDUserDefineModel *)mmodel {
  self = [super init];
  if (self) {
    endUser = @"no user";
    myName = @"no name";
    self.model = mmodel;
  }
  return self;
}

- (NSMutableDictionary *)parseJsonMessage:(NSString *)jsonString {
  NSString *str = [@"[" stringByAppendingString:jsonString];
  str = [str stringByAppendingString:@"]"];
  NSLog(@"json: %@", str);
  NSData *jsonData = [str dataUsingEncoding:NSUnicodeStringEncoding];
  NSError *error;
  NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&error];
  
  NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
  for (NSDictionary *obj in array) {
    for (id key in [obj keyEnumerator]) {
      [results setObject:[obj valueForKey:key] forKey:key];
    }
    
  }
  return results;
}

- (NSString *)jsonInit {
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  NSError *error = nil;
  
#if TARGET_IPHONE_SIMULATOR
  [dict setObject:@"open" forKey:@"type"];
  [dict setObject:@"iOS Simulator" forKey:@"name"];
  [dict setObject:@"ios_sim" forKey:@"device"];
  self.myName = @"iOS Simulator";
#else
  [dict setObject:@"open" forKey:@"type"];
  [dict setObject:@"myiOS" forKey:@"name"];
  [dict setObject:@"ios_dev" forKey:@"device"];
  self.myName = @"myiOS";
#endif
  
  NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                 options:NSJSONWritingPrettyPrinted
                                                   error:&error];
  NSString *jsonstr = [[NSString alloc] initWithData:data
                                            encoding:NSUTF8StringEncoding];
  NSLog(@"Send: %@", jsonstr);
  NSString *json = [jsonstr stringByReplacingOccurrencesOfString:@"\n"
                                                      withString:@""];
  
  return json;
}

- (NSString *)getJSONMessageWithType:(NSString *)type {
  NSInteger actionType = [model getAction:type];
  if (actionType == NoGesture) {
    return nil;
  }

  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  NSError *error = nil;
  [dict setObject:@"com" forKey:@"type"];
  NSString *detail;

  switch (actionType) {
    case Click:
      detail = @"click";
      [dict setObject:@"click" forKey:@"command"];
      break;
    case ScrollUp:
    case ScrollDown:
      detail = (actionType == ScrollUp) ? @"up" : @"down";
      [dict setObject:@"scroll" forKey:@"command"];
      [dict setObject:detail forKey:@"detail"];
      break;
    case ZoomOut:
    case ZoomIn:
      detail = (actionType == ZoomOut) ? @"out" : @"in";
      [dict setObject:@"zoom" forKey:@"command"];
      [dict setObject:detail forKey:@"detail"];
      break;
    case TextBig:
    case TextSmall:
      detail = (actionType == TextBig) ? @"big" : @"small";
      [dict setObject:@"text" forKey:@"command"];
      [dict setObject:detail forKey:@"detail"];
      break;
    case NextPage:
      detail = (actionType == NextPage) ? @"next" : @"back";
      [dict setObject:@"page" forKey:@"command"];
      [dict setObject:detail forKey:@"detail"];
      break;
    default:
      break;
  }

  NSString *window = [model getWindow: type];
  [dict setObject:window forKey:@"window"];
  [dict setObject:self.endUser forKey:@"dst"];
  [dict setObject:self.myName forKey:@"origin"];

  NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                 options:NSJSONWritingPrettyPrinted
                                                   error:&error];
  NSString *jsonstr = [[NSString alloc] initWithData:data
                                            encoding:NSUTF8StringEncoding];
  NSLog(@"Send: %@", jsonstr);
  NSString *json = [jsonstr stringByReplacingOccurrencesOfString:@"\n"
                                                      withString:@""];

  return json;
}

@end
