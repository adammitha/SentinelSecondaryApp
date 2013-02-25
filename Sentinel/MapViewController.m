//
//  MapViewController.m
//  Sentinel
//
//  Created by Adam Mitha on 12-01-07.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController
@synthesize webView;
@synthesize progressHUD;
@synthesize mapView;
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
- (IBAction)buttonPressed:(UIBarButtonItem *)sender
{
    if (sender.tag == 0) {
        [self.webView goBack];
    }
    if (sender.tag == 1) {
        [self.webView goForward];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:49.346296 longitude:-123.149351 zoom:16];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, 320, 475) camera:camera];
    } else {
        mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, 320, 387) camera:camera];
    }
    mapView.myLocationEnabled = YES;
    [self.view addSubview:mapView];
    GMSMarkerOptions *options = [[GMSMarkerOptions alloc] init];
    options.position = CLLocationCoordinate2DMake(49.346296, -123.149351);
    options.title = @"Sentinel Secondary School";
    options.snippet = @"West Vancouver, BC";
    [mapView addMarkerWithOptions:options];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.


- (void)launchMaps
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"comgooglemaps://?q=1250+Charwell+Drive,+West+Vancouver+BC"]];
    } else {
        NSString *theurl = [NSString stringWithFormat:@"http://maps.apple.com?q=1250+Chartwell+Drive,+West+Vancouver+BC"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:theurl]];
    }
}

- (void)viewDidLoad
{
    self.title = @"Maps";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(launchMaps)];
    self.trackedViewName = @"Map View";
    self.navigationItem.rightBarButtonItem = item;
    self.trackedViewName = @"Map View";

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
