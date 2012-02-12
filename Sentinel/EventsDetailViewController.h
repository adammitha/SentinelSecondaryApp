//
//  EventsDetailViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 11-12-22.
//  Copyright (c) 2011 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsDetailViewController : UIViewController
@property (strong, nonatomic) NSString *eventTitle;
@property (strong, nonatomic) NSString *eventDescription;
@property (strong, nonatomic) NSString *eventLink;
@property (weak, nonatomic) IBOutlet UITextView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
- (void)launchURL;
- (void)swipeDidOccur;
@end
