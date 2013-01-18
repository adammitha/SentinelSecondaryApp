//
//  AthleticsTabBarViewController.m
//  Sentinel
//
//  Created by Justin Wong on 13-01-17.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import "AthleticsTabBarViewController.h"
#import "StandingsViewController.h"

@interface AthleticsTabBarViewController ()

@end

@implementation AthleticsTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    StandingsViewController *svc = [[StandingsViewController alloc] init];
    [self setViewControllers:[NSArray arrayWithObjects:svc, nil]];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
