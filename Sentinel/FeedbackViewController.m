//
//  FeedbackViewController.m
//  Sentinel
//
//  Created by Adam Mitha on 11-12-31.
//  Copyright (c) 2011 Sentinel Secondary School. All rights reserved.
//

#import "FeedbackViewController.h"
#import "ASIHTTPRequest.h"

@implementation FeedbackViewController
@synthesize webView = _webView;
@synthesize sentinelImage = _sentinelImage;

- (IBAction)feedback:(id)sender {
}

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
- (IBAction)buttonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)goHome
{
    [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];

}

- (void)swipeDidOccur
{
    [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    self.title = @"Home";
    //ios6
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDidOccur)];
    [self.view addGestureRecognizer:swipeRecognizer];
    swipeRecognizer.direction= UISwipeGestureRecognizerDirectionRight;
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    //iOS 6 vs. 7 Graphics placement
    NSString *version = [[UIDevice currentDevice] systemVersion];
    int ver = [version intValue];
    if (ver < 7){
        //iOS 6 work
        if (bounds.size.height == 568) {
            self.webView.frame = CGRectMake(0, 114, self.view.frame.size.width, 342);
            self.sentinelImage.frame = CGRectMake(0, 0, 320, 130);
            
        } else {
            self.webView.frame = CGRectMake(0, 114, self.view.frame.size.width, 254);
            self.sentinelImage.frame = CGRectMake(0, 0, 320, 130);
        }

        
    } else {
        //iOS 7 work
        if (bounds.size.height == 568) {
            self.webView.frame = CGRectMake(0, 187, self.view.frame.size.width, 332);
            
        } else {
            
            self.webView.frame = CGRectMake(0, 180, self.view.frame.size.width, 250);
        }

    }
    
     NSString *tempString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"description" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:tempString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    self.tabBarController.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.tabBarController.customizableViewControllers = nil;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(goHome)];
    self.navigationItem.leftBarButtonItem = item;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSString *string = [[request URL] absoluteString];
        if ([string isEqualToString:@"http://sd45.bc.ca/sentinel"]) {
            [[UIApplication sharedApplication] openURL:[request URL]];
            return NO;
        }
        return YES;
    }
    return YES;
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
