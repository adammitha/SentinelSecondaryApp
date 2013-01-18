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
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://g.co/maps/75nh6"]]];
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHUD.labelText = @"Loading...";
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad
{    
    /*[super viewDidLoad];
    self.title = @"Map";
    MKCoordinateRegion region;
    region.center.latitude = 49.3462955;
    region.center.longitude = -123.1493511;
    region.span.latitudeDelta = .01;
    region.span.longitudeDelta = .01;
    [self.mapView setRegion:region];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 49.3462955;
    coordinate.longitude = -123.1493511;
    Location *annotation = [[Location alloc] initWithName:@"Sentinel" address:@"1250 Chartwell Dr, West Vancouver" coordinate:coordinate];
    [self.mapView addAnnotation:annotation];
   */
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Unable to connect to Google Maps." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    NSLog(@"Error: %@", [error localizedDescription]);
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
