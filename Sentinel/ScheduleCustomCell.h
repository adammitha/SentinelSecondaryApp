//
//  ScheduleCustomCell.h
//  Sentinel
//
//  Created by Justin Wong on 2013-01-18.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleCustomCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UILabel *awayTeam;
@property (nonatomic,weak) IBOutlet UILabel *homeTeam;
@property (nonatomic,weak) IBOutlet UILabel *theDate;
@property (nonatomic,weak) IBOutlet UILabel *gameTime;

@end
