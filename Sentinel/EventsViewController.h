//
//  EventsViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 11-12-08.
//  Copyright (c) 2011 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
@class MBProgressHUD;
@interface EventsViewController : PullRefreshTableViewController

@property (nonatomic, strong) NSArray *eventsArray;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
- (void)goHome;
@end
