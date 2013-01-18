//
//  AthleticsDetailViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 2013-01-18.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AthleticsDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSString *codekey;
@property (nonatomic, strong) UITableView *standingsTableView;
@property (nonatomic, strong) UITableView *scheduleTableView;
@property (nonatomic, strong) NSArray *standingsArray;
@property (nonatomic, strong) NSArray *scheduleArray;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *sportName;
@end
