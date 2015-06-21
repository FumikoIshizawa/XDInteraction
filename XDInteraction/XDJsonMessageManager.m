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

- (id)init {
  self = [super init];
  
  return self;
}

- (NSString *)jsonInit {
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  NSError *error = nil;
  
#if TARGET_IPHONE_SIMULATOR
  [dict setObject:@"open" forKey:@"type"];
  [dict setObject:@"iOS Simulator" forKey:@"name"];
  [dict setObject:@"ios_sim" forKey:@"device"];

#else
  [dict setObject:@"open" forKey:@"type"];
  [dict setObject:@"myiOS" forKey:@"name"];
  [dict setObject:@"ios_dev" forKey:@"device"];
#endif

  NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                 options:NSJSONWritingPrettyPrinted
                                                   error:&error];
  NSString *jsonstr = [[NSString alloc] initWithData:data
                                            encoding:NSUTF8StringEncoding];
  NSLog(@"%@", jsonstr);
  NSString *json = [jsonstr stringByReplacingOccurrencesOfString:@"\n"
                                                      withString:@""];
  
  return json;
}

- (NSString *)capturedKey:(NSString *)capturedKey {
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  NSError *error = nil;
  
  
  [dict setObject:@"com" forKey:@"type"];
  [dict setObject:@"key" forKey:@"command"];
  [dict setObject:capturedKey forKey:@"detail"];
#if TARGET_IPHONE_SIMULATOR
  [dict setObject:@"myiOS" forKey:@"dst"];
  [dict setObject:@"iOS Simulator" forKey:@"origin"];
#else
  [dict setObject:@"iOS Simulator" forKey:@"dst"];
  [dict setObject:@"myiOS" forKey:@"origin"];
#endif
  
  NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                 options:NSJSONWritingPrettyPrinted
                                                   error:&error];
  NSString *jsonstr = [[NSString alloc] initWithData:data
                                            encoding:NSUTF8StringEncoding];
  NSLog(@"%@", jsonstr);
  NSString *json = [jsonstr stringByReplacingOccurrencesOfString:@"\n"
                                                      withString:@""];
  
  return json;
}

- (NSString *)detectedSwipe:(NSString *)swipeDirection {
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  NSError *error = nil;
  
  
  [dict setObject:@"com" forKey:@"type"];
  [dict setObject:@"swipe" forKey:@"command"];
  [dict setObject:swipeDirection forKey:@"detail"];
#if TARGET_IPHONE_SIMULATOR
  [dict setObject:@"myiOS" forKey:@"dst"];
  [dict setObject:@"iOS Simulator" forKey:@"origin"];
#else
  [dict setObject:@"iOS Simulator" forKey:@"dst"];
  [dict setObject:@"myiOS" forKey:@"origin"];
  
#endif
   
   NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                  options:NSJSONWritingPrettyPrinted
                                                    error:&error];
   NSString *jsonstr = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
   NSLog(@"%@", jsonstr);
   NSString *json = [jsonstr stringByReplacingOccurrencesOfString:@"\n"
                                                       withString:@""];
   
   return json;
   }
   
@end
