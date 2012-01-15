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

- (IBAction)menutab2:(id)sender{
    NSLog(@"Transfer to second menu");
    
}
- (IBAction)playsound:(id)sender{
    NSLog(@"play sound");
    SystemSoundID adam;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Adam's Rendition of Bach" ofType:@"wav"];
    NSURL* url = [NSURL fileURLWithPath:path];
    
    AudioServicesCreateSystemSoundID( (CFURLRef)objc_unretainedPointer(url), &adam);
    AudioServicesPlaySystemSound(adam);
    
    /*path = [[NSBundle mainBundle] pathForResource:@"crunch" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((CFURLRef)objc_unretainedPointer([NSURL fileURLWithPath:path]), &crunchSoundID);    
    */
}


@synthesize rotationsDict = _rotationsDict;
@synthesize rotationLabel = _rotationLabel;
@synthesize dayLabel = _dayLabel;
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
    UIColor *color = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Home-Background-Textrured.png"]];
    self.view.backgroundColor = color;
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
    //NSLog(@"%@", self.rotationsDict);
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    //NSLog(@"%@",dateString);
    NSDictionary *tempDict = [self.rotationsDict objectForKey:dateString];
    NSLog(@"%@", tempDict);
    if (tempDict) {
        NSString *block  = @"Block: ";
        NSString *day = @"Day: ";
        self.rotationLabel.text = [block stringByAppendingString:[tempDict objectForKey:@"rotation"]];
        self.dayLabel.text = [day stringByAppendingString:[tempDict objectForKey:@"day"]];
    }
}
- (void)viewDidUnload
{
    [self setRotationLabel:nil];
    [self setDayLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)feedback:(id)sender {
    [TestFlight openFeedbackView];
}
@end
