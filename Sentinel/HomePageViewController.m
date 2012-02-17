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
@synthesize statusLabel;
//Swipe

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

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    //NSURL *url = [NSURL URLWithString:@"http://events.sd45app.com/events/blockRotationXml"];
    //ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    //[request setDelegate:self];
    //[request startAsynchronous];
    NSData *responseData = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rotations" ofType:@"txt"]];
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
    UITapGestureRecognizer *doubleTap = 
    [[UITapGestureRecognizer alloc]
     initWithTarget:self 
     action:@selector(tapDetected:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    UIPinchGestureRecognizer *pinchRecognizer = 
    [[UIPinchGestureRecognizer alloc]
     initWithTarget:self 
     action:@selector(pinchDetected:)];
    [self.view addGestureRecognizer:pinchRecognizer];
    
    UIRotationGestureRecognizer *rotationRecognizer =
    [[UIRotationGestureRecognizer alloc]
     initWithTarget:self 
     action:@selector(rotationDetected:)];
    [self.view addGestureRecognizer:rotationRecognizer];
    
    UISwipeGestureRecognizer *swipeRecognizer = 
    [[UISwipeGestureRecognizer alloc]
     initWithTarget:self 
     action:@selector(swipeDetected:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRecognizer];
    
    UILongPressGestureRecognizer *longPressRecognizer = 
    [[UILongPressGestureRecognizer alloc]
     initWithTarget:self 
     action:@selector(longPressDetected:)];
    longPressRecognizer.minimumPressDuration = 3;
    longPressRecognizer.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:longPressRecognizer];
    [super viewDidLoad];
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
    //Swipe
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.statusLabel = nil;
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
