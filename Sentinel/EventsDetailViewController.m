//
//  EventsDetailViewController.m
//  Sentinel
//
//  Created by Adam Mitha on 11-12-22.
//  Copyright (c) 2011 Sentinel Secondary School. All rights reserved.
//

#import "EventsDetailViewController.h"

@implementation EventsDetailViewController
@synthesize titleView;
@synthesize descriptionLabel;
@synthesize eventTitle = _eventTitle;
@synthesize eventDescription = _eventDescription;
@synthesize eventLink = _eventLink;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", self.eventTitle);
    self.titleView.text = self.eventTitle;
    self.descriptionLabel.text = self.eventDescription;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(launchURL)];
    self.navigationItem.rightBarButtonItem = item;
    // Do any additional setup after loading the view from its nib.
    //self.titleLabel.text = self.eventTitle;
    //self.titleView.text = self.eventTitle;
}

- (void)viewDidUnload
{
    [self setTitleView:nil];
    [self setDescriptionLabel:nil];
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
