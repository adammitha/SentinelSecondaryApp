//
//  DocumentsViewController.m
//  Sentinel
//
//  Created by Adam Mitha on 12-01-19.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import "DocumentsViewController.h"
#import "DocumentsDetailViewController.h"
@implementation DocumentsViewController

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
- (void)goHome
{
    //HomePageViewController *homePageViewController = [[HomePageViewController alloc] init];
    [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
    //[self presentViewController:homePageViewController animated:YES completion:^(){NSLog(@"Testing...");}];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)swipeDidOccur
{
    [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDidOccur)];
    swipeRecognizer.direction= UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRecognizer];
    self.tabBarController.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    //swipe 
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"53-house.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goHome)];
    self.navigationItem.leftBarButtonItem = item;
    [super viewDidLoad];
 UIColor *color = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Document Background.png"]];
  self.view.backgroundColor = color;
    //UIScrollView *scrollView = [[UIScrollView alloc] init];
    //[self.view addSubview:scrollView];
    
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 450)];
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)buttonPressed:(UIButton*)sender {
    NSLog(@"%@", sender.titleLabel.text);
    DocumentsDetailViewController *detailViewController = [[DocumentsDetailViewController alloc] init];
    detailViewController.fileName = sender.titleLabel.text;
    detailViewController.filePath = [[NSBundle mainBundle] pathForResource:sender.titleLabel.text ofType:@"pdf"];
    [self.navigationController pushViewController:detailViewController animated:YES];
}
@end
