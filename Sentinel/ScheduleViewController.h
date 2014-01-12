//
//  ScheduleViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 2013-12-29.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleViewController : UIViewController <UITableViewDataSource>

@property (nonatomic, strong) UITableView *scheduleTableView;
@property (nonatomic, strong) NSArray *scheduleArray;
@property (nonatomic, strong) NSString *codekey;

@end
