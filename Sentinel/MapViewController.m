//
//  MapViewController.m
//  Sentinel
//
//  Created by Adam Mitha on 12-01-07.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import "MapViewController.h"
#import "Location.h"

@implementation MapViewController
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
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
}


- (void)viewDidUnload
{
    [self setMapView:nil];
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
