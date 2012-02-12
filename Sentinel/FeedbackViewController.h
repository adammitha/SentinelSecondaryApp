//
//  FeedbackViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 11-12-31.
//  Copyright (c) 2011 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface FeedbackViewController : UIViewController
- (IBAction)feedback:(id)sender;
@property (nonatomic, retain) NSDictionary *rotationsDict;
@property (weak, nonatomic) IBOutlet UILabel *rotationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
- (void)swipeDidOccur;
@end
