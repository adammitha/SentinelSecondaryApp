//
//  EventsDetailViewController.m
//  Sentinel
//
//  Created by Adam Mitha on 11-12-22.
//  Copyright (c) 2011 Sentinel Secondary School. All rights reserved.
//

#import "EventsDetailViewController.h"

@implementation EventsDetailViewController
@synthesize eventTitle = _eventTitle;
@synthesize eventDescription = _eventDescription;
@synthesize eventLink = _eventLink;
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
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.eventLink]];
}
#pragma mark - View lifecycle

- (void)swipeDidOccur
{
    [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDidOccur)];
    swipeRecognizer.direction= UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRecognizer];
    self.tabBarController.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    //swipe 

    [super viewDidLoad];
    NSLog(@"%@", self.eventTitle);
    self.webView.scalesPageToFit = NO;
  //zoom
    CGRect webFrame = CGRectMake(0.0, 0.0, 320.0, 460.0);
    UIWebView *webView = [[UIWebView alloc] initWithFrame:webFrame];
    [webView setBackgroundColor:[UIColor whiteColor]];
    NSURL *url = [NSURL URLWithString:self.eventLink];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
    [self.webView addSubview:webView]; 

    //zoom
    
  //  self.webView.delegate = self;
   //[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.eventLink]]];
   // self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHUD.labelText = @"Loading...";
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
