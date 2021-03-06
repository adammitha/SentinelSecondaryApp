//
//  AnnouncementsDetailViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 11-12-30.
//  Copyright (c) 2011 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "GAITrackedViewController.h"

@interface AnnouncementsDetailViewController : GAITrackedViewController <UIWebViewDelegate>

- (void)launchURL;
@property (nonatomic, strong) NSString *announcementTitle;
@property (nonatomic, strong) NSString *announcementDescription;
@property (nonatomic, strong) NSString *announcementLink;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@end
