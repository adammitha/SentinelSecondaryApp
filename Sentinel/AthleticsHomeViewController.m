//
//  AthleticsHomeViewController.m
//  Sentinel
//
//  Created by Justin Wong on 13-01-13.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import "AthleticsHomeViewController.h"
#import "StandingsViewController.h"
#import "AthleticsTabBarViewController.h"
#import "AthleticsDetailViewController.h"
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
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDidOccur)];
    swipeRecognizer.direction= UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRecognizer];

    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.frame = CGRectMake(0, 20, 320, 44);
    [athleticsTableView setDelegate:self];
    [athleticsTableView setDataSource:self];
    NSDate *today = [NSDate date];
    NSDateFormatter *spring = [[NSDateFormatter alloc] init];
    [spring setDateFormat:@"dd/MM/yyyy"];
    NSDate *april = [spring dateFromString:@"01/04/2013"];
    NSData *data = [[NSData alloc] init];
    if ([today earlierDate:april] == today) {
        data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Winter" ofType:@"txt"]];
    } else if ([today earlierDate:april] == april) {
        data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Spring" ofType:@"txt"]];
    }
    NSError *error;
    athleticsArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    [athleticsTableView reloadData];   

    
     
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
    //AthleticsTabBarViewController *vc = [[AthleticsTabBarViewController alloc] init];
    //vc.codekey = [[athleticsArray objectAtIndex:indexPath.row] objectForKey:@"codekey"];
    AthleticsDetailViewController *vc = [[AthleticsDetailViewController alloc] init];
    vc.sportName = [[athleticsArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    vc.codekey = [[athleticsArray objectAtIndex:indexPath.row] objectForKey:@"codekey"];
    //NSLog(@"%@",vc.codekey);
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
