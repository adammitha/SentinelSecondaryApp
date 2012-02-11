//
//  HomePageViewController.m
//  Sentinel
//
//  Created by Adam Mitha on 12-01-19.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import "HomePageViewController.h"
#import "MapViewController.h"
#import "ASIHTTPRequest.h"
@implementation HomePageViewController
@synthesize dayLabel = _dayLabel;
@synthesize rotationsDict = _rotationsDict;
@synthesize rotationLabel = _rotationLabel;
@synthesize dateLabel = _dateLabel;
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

- (IBAction)eventsAndInfo:(id)sender {
    MapViewController *mvc = [[MapViewController alloc] init];
    [self.navigationController pushViewController:mvc animated:YES];
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
    NSURL *url = [NSURL URLWithString:@"http://events.sd45app.com/events/blockRotationXml"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    NSError *error;
    self.rotationsDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    NSDictionary *tempDict = [self.rotationsDict objectForKey:dateString];
    NSLog(@"%@", tempDict);
    if (tempDict) {
        NSString *rotation = @"Block: ";
        NSString *day = @"Day: ";
        self.rotationLabel.text = [rotation stringByAppendingString:[tempDict objectForKey:@"rotation"]];
        self.dayLabel.text = [day stringByAppendingString:[tempDict objectForKey:@"day"]];
        self.dateLabel.text = [tempDict objectForKey:@"date"];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
}
- (void)viewDidUnload
{
    [self setRotationLabel:nil];
    [self setDayLabel:nil];
    [self setDayLabel:nil];
    [self setDateLabel:nil];
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
