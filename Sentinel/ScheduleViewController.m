//
//  ScheduleViewController.m
//  Sentinel
//
//  Created by Adam Mitha on 2013-12-29.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import "ScheduleViewController.h"
#import "ScheduleCustomCell.h"
#import "ASIHTTPRequest.h"
#import "constants.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

@synthesize scheduleTableView = _scheduleTableView;
@synthesize scheduleArray = _scheduleArray;
@synthesize codekey = _codekey;
@synthesize progressHUD = _progressHUD;
@synthesize detailView = _detailView;
@synthesize address;
@synthesize homeTeamLabel,awayTeamLabel,locationLabel,dateTimeLabel;
@synthesize refreshControl = _refreshControl;

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
    self.tabBarController.title = @"Schedule";
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    //ios6
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        
        // Load resources for iOS 6.1 or earlier
         self.scheduleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height-45, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height-133)];
    } else {
        
        // Load resources for iOS 7 or later
         self.scheduleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height-156)];
    }
    



    [_scheduleTableView setDataSource:self];
    [_scheduleTableView setDelegate:self];
    [self.view addSubview:self.scheduleTableView];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.scheduleTableView addSubview:self.refreshControl];
    
    self.detailView = [[UIView alloc] initWithFrame:CGRectMake(0, self.scheduleTableView.frame.origin.y+self.scheduleTableView.frame.size.height, self.view.frame.size.width, 100)];
    self.detailView.backgroundColor = [UIColor clearColor];
    homeTeamLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 10, 128, 21)];
    homeTeamLabel.textAlignment = NSTextAlignmentCenter;
    homeTeamLabel.adjustsFontSizeToFitWidth = YES;
    homeTeamLabel.text = @"Home Team";
    [self.detailView addSubview:homeTeamLabel];
    awayTeamLabel = [[UILabel alloc] initWithFrame:CGRectMake(175, 10, 128, 21)];
    awayTeamLabel.textAlignment = NSTextAlignmentCenter;
    awayTeamLabel.adjustsFontSizeToFitWidth = YES;
    awayTeamLabel.text = @"AwayTeam";
    [self.detailView addSubview:awayTeamLabel];
    dateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(97, 34, 128, 21)];
    dateTimeLabel.textAlignment = NSTextAlignmentCenter;
    dateTimeLabel.text = @"Date/Time";
    [self.detailView addSubview:dateTimeLabel];
    locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 58, 250, 21)];
    locationLabel.textAlignment = NSTextAlignmentCenter;
    locationLabel.text = @"Location";
    [self.detailView addSubview:locationLabel];
    UILabel *vsLabel = [[UILabel alloc] initWithFrame:CGRectMake(149, 10, 22, 21)];
    [self.detailView addSubview:vsLabel];
    vsLabel.text = @"vs.";
    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mapButton.titleLabel.text = @"Map";
    [mapButton setBackgroundImage:[UIImage imageNamed:@"mapicon.png"] forState:UIControlStateNormal];
    [mapButton addTarget:self action:@selector(launchMaps) forControlEvents:UIControlEventTouchUpInside];
    mapButton.frame = CGRectMake(260, 55, 55, 27);
    [self.detailView addSubview:mapButton];
    [self.view addSubview:self.detailView];
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:kAthleticsScheduleURL,_codekey]]];
    NSLog(kAthleticsScheduleURL,_codekey);
    [request setDelegate:self];
    [request startAsynchronous];
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHUD.labelText = @"Loading...";
	// Do any additional setup after loading the view.
}

- (void)launchMaps
{
    //stuff
    NSString *theaddress = [self.address stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?q=%@",theaddress]]];
    } else {
        NSString *theurl = [NSString stringWithFormat:@"http://maps.apple.com?q=%@",theaddress];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:theurl]];
    }
}

- (void)refresh
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kAthleticsScheduleURL,self.codekey]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}

#pragma mark - ASIHTTPRequest methods

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self.refreshControl endRefreshing];
    NSData *responseData = [request responseData];
    NSError* error;
    NSArray* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    self.scheduleArray = json;
    [self.scheduleTableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self.refreshControl endRefreshing];
    NSError *error = [request error];
    NSLog(@"Request Failed: %@", [error localizedDescription]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Unable to connect to the events feed. Please check your internet connection, then restart the app." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [alert show];
}

#pragma mark - Table view delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //Header
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    UILabel *teamName = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, tableView.bounds.size.width, 18)];
    teamName.backgroundColor = [UIColor clearColor];
    teamName.textColor = [UIColor whiteColor];
    teamName.font = [UIFont boldSystemFontOfSize:14];
    teamName.text = @"Home Team vs. Away Team      Date";
    [headerView addSubview:teamName];
    [headerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Standings Cell Blue.png"]]];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tempDict = [self.scheduleArray objectAtIndex:indexPath.row];
    self.homeTeamLabel.text = [tempDict objectForKey:@"homeTeam"];
    self.awayTeamLabel.text = [tempDict objectForKey:@"awayTeam"];
    self.locationLabel.text = [NSString stringWithFormat:@"@ %@",[tempDict objectForKey:@"location"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *gameDate = [dateFormatter dateFromString:[tempDict objectForKey:@"date"]];
    [dateFormatter setDateFormat:@"MMM d, yyyy"];
    self.dateTimeLabel.text = [dateFormatter stringFromDate:gameDate];
    self.address = [tempDict objectForKey:@"address"];
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.scheduleArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ScheduleCell";
    ScheduleCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ScheduleCustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSDictionary *tempDict = [self.scheduleArray objectAtIndex:indexPath.row];
    NSLog(@"%@",tempDict);
    cell.homeTeam.adjustsFontSizeToFitWidth = YES;
    cell.homeTeam.text = [NSString stringWithFormat:@"%@ vs. %@",[tempDict objectForKey:@"homeTeam"],[tempDict objectForKey:@"awayTeam"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *gameDate = [dateFormatter dateFromString:[tempDict objectForKey:@"date"]];
    [dateFormatter setDateFormat:@"MMM d, yyyy"];
    cell.theDate.text = [dateFormatter stringFromDate:gameDate];
    [dateFormatter setDateFormat:@"HH:mm:ss:SSS"];
    NSDate *gameTime = [dateFormatter dateFromString:[tempDict objectForKey:@"gameTime"]];
    [dateFormatter setDateFormat:@"hh:mm a"];
    cell.gameTime.text = [dateFormatter stringFromDate:gameTime];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
