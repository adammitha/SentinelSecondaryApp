//
//  CouncilDetailViewController.m
//  Sentinel
//
//  Created by Adam Mitha on 12-01-07.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import "CouncilDetailViewController.h"

@implementation CouncilDetailViewController
@synthesize councilTitle = _councilTitle;
@synthesize councilDescription = _councilDescription;
@synthesize councilDate = _councilDate;
@synthesize titleLabel = _titleLabel;
@synthesize dateLabel = _dateLabel;
@synthesize descriptionLabel = _descriptionLabel;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Title: %@", self.councilTitle);
    NSLog(@"Description: %@", self.councilDescription);
    NSLog(@"Date: %@", self.councilDate);
    self.titleLabel.text = self.councilTitle;
    self.descriptionLabel.text = self.councilDescription;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:self.councilDate];
    NSLog(@"%@", date);
    NSDateFormatter *readableFormatter = [[NSDateFormatter alloc] init];
    
    [readableFormatter setDateFormat:@"EEEE MMMM d, yyyy"];
    self.dateLabel.text = [readableFormatter stringFromDate:date];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setDateLabel:nil];
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
