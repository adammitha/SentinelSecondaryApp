//
//  AnnouncementsDetailViewController.m
//  Sentinel
//
//  Created by Adam Mitha on 11-12-30.
//  Copyright (c) 2011 Sentinel Secondary School. All rights reserved.
//

#import "AnnouncementsDetailViewController.h"

@implementation AnnouncementsDetailViewController
@synthesize announcementTitle = _announcementTitle;
@synthesize announcementDescription = _announcementDescription;
@synthesize announcementLink = _announcementLink;
@synthesize webView = _webView;
@synthesize progressHUD = _progressHUD;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)launchURL
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.announcementLink]];
}
#pragma mark - View lifecycle


- (void)viewDidLoad
{
    self.tabBarController.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.announcementLink]]];
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHUD.labelText = @"Loading...";
    
    [super viewDidLoad];
    self.trackedViewName = @"Announcements Detail View";
    // Do any additional setup after loading the view from its nib.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
