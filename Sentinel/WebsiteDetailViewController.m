//
//  WebsiteDetailViewController.m
//  Sentinel
//
//  Created by Adam Mitha on 11-12-31.
//  Copyright (c) 2011 Sentinel Secondary School. All rights reserved.
//

#import "WebsiteDetailViewController.h"
#import "MBProgressHUD.h"

@implementation WebsiteDetailViewController
@synthesize webView = _webView;
@synthesize teacherName = _teacherName;
@synthesize siteLink = _siteLink;
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

#pragma mark - UIWebViewDelegate functions

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHUD.labelText = @"Loading...";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView 
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
#pragma mark - View lifecycle


- (void)viewDidLoad
{
    
    self.tabBarController.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    [super viewDidLoad];
    self.title = self.teacherName;
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(launchURL)];
    self.navigationItem.rightBarButtonItem = item;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.siteLink]]];
    // Do any additional setup after loading the view from its nib.
       self.trackedViewName = @"Website Detail View";
}

- (void)launchURL
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.siteLink]];
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
