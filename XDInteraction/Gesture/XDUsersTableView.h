//
//  XDUsersTableView.h
//  XDInteraction
//
//  Created by FumikoIshizawa on 2015/06/25.
//  Copyright (c) 2015年 FumikoIshiawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDUsersTableView : UITableView <UITableViewDataSource>

- (id)init;
- (void)updateTableViewWith:(NSArray *)names withDevices:(NSArray *)devices;

@property (nonatomic) NSMutableArray *usersNameList;
@property (nonatomic) NSMutableArray *usersDeviceList;

@end
