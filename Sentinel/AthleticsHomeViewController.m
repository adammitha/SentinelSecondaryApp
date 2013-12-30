//
//  AthleticsHomeViewController.m
//  Sentinel
//
//  Created by Justin Wong on 13-01-13.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import "AthleticsHomeViewController.h"
#import "AthleticsTabBarViewController.h"
#import "AthleticsDetailViewController.h"
#import "StandingsViewController.h"
#import "ScheduleViewController.h"
#import "constants.h"
@interface AthleticsHomeViewController ()

@end

@implementation AthleticsHomeViewController
@synthesize imageView;
@synthesize athleticsTableView;
@synthesize athleticsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)buttonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)swipeDidOccur
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, self.view.frame.size.width, self.imageView.frame.size.height);
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDidOccur)];
    swipeRecognizer.direction= UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRecognizer];

    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.frame = CGRectMake(0, 20, 320, 44);
    [athleticsTableView setDelegate:self];
    [athleticsTableView setDataSource:self];
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *winter = [formatter dateFromString:kWinterStartDate];
    NSDate *spring = [formatter dateFromString:kSpringStartDate];
    NSData *data = [[NSData alloc] init];
    if ([today earlierDate:winter] == today) {
        data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Fall" ofType:@"txt"]];
    } else if ([today earlierDate:spring] == today && [today earlierDate:winter] == winter) {
        data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Winter" ofType:@"txt"]];
    } else if ([today earlierDate:spring] == spring) {
        data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Spring" ofType:@"txt"]];
    }
    NSError *error;
    athleticsArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    [athleticsTableView reloadData];
    self.trackedViewName = @"Athletics Home View";

    
     
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setAthleticsTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table View Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [athleticsArray count];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    NSDictionary *tempdict = [athleticsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [tempdict objectForKey:@"name"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StandingsViewController *stvc = [[StandingsViewController alloc] init];
    stvc.title = @"Standings";
    stvc.tabBarItem.image = [UIImage imageNamed:@"179-notepad.png"];
    ScheduleViewController *scvc = [[ScheduleViewController alloc] init];
    scvc.title = @"Schedule";
    scvc.tabBarItem.image = [UIImage imageNamed:@"83-calendar.png"];
    AthleticsTabBarViewController *vc = [[AthleticsTabBarViewController alloc] init];
    vc.codekey = [[athleticsArray objectAtIndex:indexPath.row] objectForKey:@"codekey"];
    vc.viewControllers = [NSArray arrayWithObjects:stvc,scvc,nil];
    //AthleticsDetailViewController *vc = [[AthleticsDetailViewController alloc] init];
    //vc.sportName = [[athleticsArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    //vc.codekey = [[athleticsArray objectAtIndex:indexPath.row] objectForKey:@"codekey"];
    //NSLog(@"%@",vc.codekey);
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
