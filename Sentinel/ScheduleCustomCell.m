//
//  ScheduleCustomCell.m
//  Sentinel
//
//  Created by Justin Wong on 2013-01-18.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import "ScheduleCustomCell.h"

@implementation ScheduleCustomCell
@synthesize awayTeam;
@synthesize homeTeam;
@synthesize theDate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
