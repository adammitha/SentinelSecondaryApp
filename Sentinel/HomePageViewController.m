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
//Swipe
//Swipe

@synthesize about = _about;
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


#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [[[self navigationController] view] setFrame:[[UIScreen mainScreen] bounds]];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController setNavigationBarHidden:YES];
    //NSURL *url = [NSURL URLWithString:@"http://events.sd45app.com/events/blockRotationXml"];
    //ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    //[request setDelegate:self];
    //[request startAsynchronous];
    NSData *responseData = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BlockRotation2013" ofType:@"txt"]];
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.about.backgroundColor = [UIColor clearColor];
    //ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://www.sd45app.com/test/test.json"]];
    //[request setDelegate:self];
    //[request startAsynchronous];
}

/*- (void)requestFinished:(ASIHTTPRequest *)request
{
    //NSLog(@"%@", [request responseData]);
    NSDictionary *tempdict = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:nil];
    NSLog(@"%@", tempdict);
    if ([[tempdict objectForKey:@"Update needed"] isEqualToString:@"YES"]) {
        NSLog(@"Update needed.");
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[tempdict objectForKey:@"Update URL"]]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update URL:" message:[tempdict objectForKey:@"Update URL"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"Error: %@", [[request error] localizedDescription]);
}*/
- (void)viewDidUnload
{
    [self setRotationLabel:nil];
    [self setDayLabel:nil];
    [self setDayLabel:nil];
    [self setDateLabel:nil];
    [self setAbout:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    //Swipe
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    //Swipe end
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//Swipe Action
- (IBAction)longPressDetected:(UIGestureRecognizer *)sender {
    statusLabel.text = @"Long Press";
}

- (IBAction)swipeDetected:(UIGestureRecognizer *)sender {
    statusLabel.text = @"Right Swipe";
}

- (IBAction)tapDetected:(UIGestureRecognizer *)sender {
    statusLabel.text = @"Double Tap";
}

- (IBAction)pinchDetected:(UIGestureRecognizer *)sender {
    
    CGFloat scale = 
    [(UIPinchGestureRecognizer *)sender scale];
    CGFloat velocity = 
    [(UIPinchGestureRecognizer *)sender velocity];
    
    NSString *resultString = [[NSString alloc] initWithFormat:
                              @"Pinch - scale = %f, velocity = %f",
                              scale, velocity];
    statusLabel.text = resultString;
}

- (IBAction)rotationDetected:(UIGestureRecognizer *)sender {
    CGFloat radians = 
    [(UIRotationGestureRecognizer *)sender rotation];
    CGFloat velocity = 
    [(UIRotationGestureRecognizer *)sender velocity];
    
    NSString *resultString = [[NSString alloc] initWithFormat:
                              @"Rotation - Radians = %f, velocity = %f",
                              radians, velocity];
    statusLabel.text = resultString;
}


@end
