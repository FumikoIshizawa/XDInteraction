//
//  XDUsersTableView.m
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/25.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import "XDUsersTableView.h"

@implementation XDUsersTableView

@synthesize usersNameList;
@synthesize usersDeviceList;

- (id)init {
  self = [super initWithFrame:CGRectMake(40, 210, 240, 300) style:UITableViewStylePlain];
  if (self) {
    self.delegate = self;
    self.dataSource = self;
    
    //Dubug
    usersNameList = [[NSMutableArray alloc] init];
    usersDeviceList = [[NSMutableArray alloc] init];
    
    [usersNameList addObject:@"iOS Simulator"];
    [usersNameList addObject:@"myiOS"];
    [usersDeviceList addObject:@"ios_sim"];
    [usersDeviceList addObject:@"ios_dev"];
  }
  return self;
}

- (void)updateTableView:(NSMutableDictionary *)users {
  [usersNameList removeAllObjects];
  [usersDeviceList removeAllObjects];
  for (id key in [users keyEnumerator]) {
    [usersNameList addObject:key];
    [usersDeviceList addObject:users[key]];
  }
  
  [self reloadData];
}

- (NSInteger)numberOfSections {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return usersNameList.count;
  }
  return 0;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
  switch (section) {
    case 0:
      return @"User List";
  }
  return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:@"Cell"];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:@"Cell"];
  }
  if (indexPath.section == 0) {
    NSString *text = [usersNameList[indexPath.row] stringByAppendingString:@" : "];
    text = [text stringByAppendingString:usersDeviceList[indexPath.row]];
    cell.textLabel.text = text;
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  // indexPath.rowを利用して、接続ユーザの変更
  
  NSLog(@"%@ is selected", usersNameList[indexPath.row]);
}

@end