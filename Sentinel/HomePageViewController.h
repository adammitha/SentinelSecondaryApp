//
//  HomePageViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 12-01-19.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (nonatomic, strong) NSDictionary *rotationsDict;
@property (weak, nonatomic) IBOutlet UILabel *rotationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end
