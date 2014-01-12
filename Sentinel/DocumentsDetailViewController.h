//
//  DocumentsDetailViewController.h
//  Sentinel
//
//  Created by Mr. Wong on 12-02-11.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "GAITrackedViewController.h"


@interface DocumentsDetailViewController : GAITrackedViewController <UIWebViewDelegate>
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *fileName;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@end
