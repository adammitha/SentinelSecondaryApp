//
//  EventsDetailViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 11-12-22.
//  Copyright (c) 2011 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "MBProgressHUD.h"
#import "GAITrackedViewController.h"

@interface EventsDetailViewController : GAITrackedViewController <UIWebViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) NSString *eventTitle;
@property (strong, nonatomic) NSString *eventDescription;
@property (strong, nonatomic) NSString *eventLink;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) MBProgressHUD *progressHUD;
- (void)launchURL;
- (void)swipeDidOccur;
- (void)openActionSheet;
@end
