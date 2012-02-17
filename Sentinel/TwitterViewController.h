//
//  TwitterViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 12-02-16.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;
@interface TwitterViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@end
