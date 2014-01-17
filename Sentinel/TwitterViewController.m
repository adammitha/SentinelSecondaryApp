//
//  TwitterViewController.m
//  Sentinel
//
//  Created by Adam Mitha on 12-02-16.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import "TwitterViewController.h"
#import "MBProgressHUD.h"
@implementation TwitterViewController
@synthesize webView;
@synthesize progressHUD;

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

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (IBAction)buttonPressed:(UIBarButtonItem *)sender
{
    if (sender.tag == 0) {
        [self.webView reload];
    }
    if (sender.tag == 1) {
        [self.webView goBack];
    }
    if (sender.tag == 2) {
        [self.webView goForward];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Principal's Tweets";
    self.webView.delegate = self;
    self.trackedViewName = @"Twitter View";
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mobile.twitter.com/MFinchVP"]]];
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
