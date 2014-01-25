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
    [super viewDidLoad];
    self.tabBarController.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.webView.frame.origin.y+self.webView.frame.size.height+39, self.view.frame.size.width, 44)];
    toolbar.translucent = NO;
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self.webView action:@selector(reload)];
    refresh.title = @"refresh";
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"◄" style:UIBarButtonItemStylePlain target:self.webView action:@selector(goBack)];
    UIBarButtonItem *forward = [[UIBarButtonItem alloc] initWithTitle:@"►" style:UIBarButtonItemStylePlain target:self.webView action:@selector(goForward)];
    UIBarButtonItem *space1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:NULL];
    space1.width = 30.0;
    UIBarButtonItem *space2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:NULL];
    space2.width = 85.0;
    [toolbar setItems:[NSArray arrayWithObjects:refresh,space2,back,space1,forward,nil]];
    [self.view addSubview:toolbar];
    self.title = self.teacherName;
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(launchURL)];
    self.navigationItem.rightBarButtonItem = item;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.siteLink]]];
    // Do any additional setup after loading the view from its nib.
    self.trackedViewName = @"Website Detail View";
}

- (IBAction)refresh:(id)sender
{
    [self.webView reload];
}

- (IBAction)goBack:(id)sender
{
    [self.webView goBack];
}

- (IBAction)goForward:(id)sender
{
    [self.webView goForward];
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
