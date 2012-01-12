//
//  WebsiteDetailViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 11-12-31.
//  Copyright (c) 2011 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;
@interface WebsiteDetailViewController : UIViewController <UIWebViewDelegate>
@property (nonatomic, strong) NSString *teacherName;
@property (nonatomic, strong) NSString *siteLink;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
- (void)launchURL;
@end
