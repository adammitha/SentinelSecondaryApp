//
//  AboutUsViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 12-02-18.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import "GAITrackedViewController.h"
#import <UIKit/UIKit.h>


@interface AboutUsViewController : GAITrackedViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)goHome:(id)sender;
@end
