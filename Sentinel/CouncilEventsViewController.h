//
//  CouncilEventsViewController.h
//  Sentinel
//
//  Created by Justin Wong on 12-02-17.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
@class MBProgressHUD;
@interface CouncilEventsViewController : PullRefreshTableViewController

@property (nonatomic, strong) NSArray *councileventsArray;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
- (void)goHome;
- (void)swipeDidOccur;
@end
