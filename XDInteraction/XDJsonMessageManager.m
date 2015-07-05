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

- (id)init {
  self = [super init];
  if (self) {
    endUser = @"no user";
    myName = @"no name";
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

- (NSString *)capturedKey:(NSString *)capturedKey {
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  NSError *error = nil;
  
  [dict setObject:@"com" forKey:@"type"];
  [dict setObject:@"key" forKey:@"command"];
  [dict setObject:capturedKey forKey:@"detail"];
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

- (NSString *)detectedSwipe:(NSString *)swipeDirection {
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  NSError *error = nil;
  
  [dict setObject:@"com" forKey:@"type"];
  [dict setObject:@"swipe" forKey:@"command"];
  [dict setObject:swipeDirection forKey:@"detail"];
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

- (NSString *)detectedTap:(NSString *)tapType {
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  NSError *error = nil;
  
  [dict setObject:@"com" forKey:@"type"];
  [dict setObject:@"tap" forKey:@"command"];
  [dict setObject:tapType forKey:@"detail"];
  [dict setObject:self.endUser forKey:@"dst"];
  [dict setObject:self.myName forKey:@"origin"];
  
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

- (NSString *)detectedPinch:(NSString *)pinchType {
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  NSError *error = nil;
  
  [dict setObject:@"com" forKey:@"type"];
  [dict setObject:@"pinch" forKey:@"command"];
  [dict setObject:pinchType forKey:@"detail"];
  [dict setObject:self.endUser forKey:@"dst"];
  [dict setObject:self.myName forKey:@"origin"];
  
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

- (NSString *)detectedGyro:(NSString *)gyroDirection {
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  NSError *error = nil;
  
  
  [dict setObject:@"com" forKey:@"type"];
  [dict setObject:@"gyro" forKey:@"command"];
  [dict setObject:gyroDirection forKey:@"detail"];
  [dict setObject:self.endUser forKey:@"dst"];
  [dict setObject:self.myName forKey:@"origin"];
  
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
