//
//  ScheduleViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 2013-12-29.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface ScheduleViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *scheduleTableView;
@property (nonatomic, strong) NSArray *scheduleArray;
@property (nonatomic, strong) NSString *codekey;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, strong) UIView *detailView;
@property (nonatomic, strong) UILabel *homeTeamLabel;
@property (nonatomic, strong) UILabel *awayTeamLabel;
@property (nonatomic, strong) UILabel *dateTimeLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) NSString *address;

@end
