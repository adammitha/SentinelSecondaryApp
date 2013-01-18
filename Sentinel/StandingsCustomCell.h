//
//  StandingsCustomCell.h
//  Sentinel
//
//  Created by Justin Wong on 13-01-13.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StandingsCustomCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *teamName;
@property (nonatomic,weak) IBOutlet UILabel *wins;
@property (nonatomic,weak) IBOutlet UILabel *losses;
@property (nonatomic,weak) IBOutlet UILabel *ties;
@property (nonatomic,weak) IBOutlet UILabel *gamesPlayed;
@property (nonatomic,weak) IBOutlet UILabel *points;

@end
