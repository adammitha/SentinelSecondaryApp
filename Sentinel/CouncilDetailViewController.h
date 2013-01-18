//
//  CouncilDetailViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 12-01-07.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouncilDetailViewController : UIViewController
@property (nonatomic, strong) NSString *councilTitle;
@property (nonatomic, strong) NSString *councilDescription;
@property (nonatomic, strong) NSString *councilDate;
@property (weak, nonatomic) IBOutlet UITextView *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;
@end
