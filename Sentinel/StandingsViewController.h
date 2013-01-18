//
//  StandingsViewController.h
//  Sentinel
//
//  Created by Justin Wong on 13-01-13.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;
@interface StandingsViewController : UITableViewController
@property (nonatomic, strong) NSArray *testArray;
@property (nonatomic, strong) NSString *codekey;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@end
