//
//  WebsiteViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 11-12-31.
//  Copyright (c) 2011 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
@class MBProgressHUD;
@interface WebsiteViewController : PullRefreshTableViewController

@property (nonatomic, strong) NSArray *websitesArray;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@end
