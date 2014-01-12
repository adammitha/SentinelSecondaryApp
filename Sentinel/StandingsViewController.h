//
//  StandingsViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 2013-12-29.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface StandingsViewController : UITableViewController <UITableViewDelegate>
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, strong) NSString *codekey;
@property (nonatomic, strong) NSArray *standingsArray;
@end
