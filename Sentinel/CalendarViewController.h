//
//  CalendarViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 11-12-30.
//  Copyright (c) 2011 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
