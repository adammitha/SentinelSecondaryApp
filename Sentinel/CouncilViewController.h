//
//  CouncilViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 12-01-04.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
@class MBProgressHUD;
@interface CouncilViewController : PullRefreshTableViewController
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, strong) NSArray *councilArray;
@end
