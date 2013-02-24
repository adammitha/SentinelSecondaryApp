//
//  HomePageViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 12-01-19.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface HomePageViewController : GAITrackedViewController
{
    UILabel *statusLabel;
}


@property (weak, nonatomic) IBOutlet UIButton *about;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (nonatomic, strong) NSDictionary *rotationsDict;
@property (weak, nonatomic) IBOutlet UILabel *rotationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIImageView *infoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *infoArrow;
@property (weak, nonatomic) IBOutlet UIButton *athleticsButton;
@property (weak, nonatomic) IBOutlet UIImageView *athleticsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *athleticsArrow;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;

@end
