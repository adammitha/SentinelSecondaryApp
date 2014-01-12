//
//  AnnouncementsViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 11-12-16.
//  Copyright (c) 2011 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"

@class MBProgressHUD;
@interface AnnouncementsViewController : UITableViewController

@property (nonatomic, strong) NSArray *announcementsArray;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
- (void)goHome;
- (void)swipeDidOccur;
@end
