//
//  AthleticsDetailViewController.m
//  Sentinel
//
//  Created by Adam Mitha on 2013-01-18.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import "AthleticsDetailViewController.h"
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"
#import "StandingsCustomCell.h"
#import "ScheduleCustomCell.h"
@interface AthleticsDetailViewController ()

@end

@implementation AthleticsDetailViewController
@synthesize codekey;
@synthesize standingsTableView, scheduleTableView;
@synthesize toolbar,segmentedControl;
@synthesize url;
@synthesize standingsArray, scheduleArray;
@synthesize sportName;
@synthesize detailView;
@synthesize homeTeamLabel,awayTeamLabel,dateTimeLabel,locationLabel;
@synthesize address;
@synthesize request;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)oneFingerTwoTaps
{
    //implement
    NSLog(@"Action: One finger, two taps");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.esportsdeskpro.com"]];
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
    //codekey = @"4AF26B37-50A6-475C-8305-4B837F5A0445";
    NSLog(@"%@",codekey);
    self.title = sportName;
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont:[UIFont boldSystemFontOfSize:17],UITextAttributeTextColor:[UIColor whiteColor]};
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.frame = CGRectMake(0, 20, 320, 44);
    toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleBlack;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568) {
        toolbar.frame = CGRectMake(0, 524, self.view.frame.size.width, 44);
    } else {
        toolbar.frame = CGRectMake(0, 436, self.view.frame.size.width, 44);
    }
    segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Standings", @"Schedule",nil]];
    segmentedControl.frame = CGRectMake(self.view.bounds.size.width/5, 3, 200, 30);
    [toolbar addSubview:segmentedControl];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addObserver:self forKeyPath:@"selectedSegmentIndex" options:NSKeyValueObservingOptionNew context:NULL];
    [self.navigationController.view addSubview:toolbar];
	// Do any additional setup after loading the view.
    standingsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 88) style:UITableViewStylePlain];
    self.standingsTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Dotbackground2.png"]];
    [standingsTableView setDelegate:self];
    [standingsTableView setDataSource:self];
    standingsTableView.hidden = NO;
    [self.view addSubview:standingsTableView];
    
    scheduleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 160) style:UITableViewStylePlain];
    self.scheduleTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Dotbackground2.png"]];
    [scheduleTableView setDelegate:self];
    [scheduleTableView setDataSource:self];
    scheduleTableView.hidden = YES;
    [self.view addSubview:scheduleTableView];
    
    detailView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-160, self.view.bounds.size.width, 156)];
    detailView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Scheduledetailimage.png"]];
    homeTeamLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 128, 21)];
    homeTeamLabel.text = @"Home Team";
    [homeTeamLabel setFont:[UIFont systemFontOfSize: 16.0]];
    [homeTeamLabel setBackgroundColor:[UIColor clearColor]];
    homeTeamLabel.textAlignment = NSTextAlignmentLeft;
    [detailView addSubview:homeTeamLabel];
    awayTeamLabel = [[UILabel alloc] initWithFrame:CGRectMake(175, 10, 128, 21)];
    awayTeamLabel.text = @"Away Team";
    [awayTeamLabel setFont:[UIFont systemFontOfSize: 16.0]];
    [awayTeamLabel setBackgroundColor:[UIColor clearColor]];
    awayTeamLabel.textAlignment = NSTextAlignmentRight;
    [detailView addSubview:awayTeamLabel];
    dateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(97, 30, 128, 21)];
    dateTimeLabel.text = @"Date/Time";
    [dateTimeLabel setBackgroundColor:[UIColor clearColor]];
    dateTimeLabel.textAlignment = NSTextAlignmentCenter;
    [detailView addSubview:dateTimeLabel];
    locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 50, 250, 21)];
    locationLabel.text = @"Location";
    [locationLabel setBackgroundColor:[UIColor clearColor]];
    locationLabel.textAlignment = NSTextAlignmentCenter;
    [locationLabel setFont:[UIFont systemFontOfSize: 14.0]];
    [detailView addSubview:locationLabel];
     UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mapButton.titleLabel.text = @"Map";
    [mapButton setBackgroundImage:[UIImage imageNamed:@"mapicon.png"] forState:UIControlStateNormal];
    [mapButton addTarget:self action:@selector(launchMaps) forControlEvents:UIControlEventTouchUpInside];
    mapButton.frame = CGRectMake(263, 44, 55, 27);
    [detailView addSubview:mapButton];
    UILabel *vsLabel = [[UILabel alloc] initWithFrame:CGRectMake(149, 10, 22, 21)];
    vsLabel.text = @"vs.";
    [vsLabel setFont:[UIFont systemFontOfSize: 14.0]];
    [vsLabel setBackgroundColor:[UIColor clearColor]];
    [detailView addSubview:vsLabel];
    
    detailView.hidden = YES;
    [self.view addSubview:detailView];
    //NSLog(@"%@", standingsArray);

    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://sd45app.com/sentinel/athletics/standings.php?codekey=%@",codekey]]];
    [request setDelegate:self];
    [request startAsynchronous];
    //NSLog(@"%@", standingsArray);
    //[scheduleTableView reloadData];
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [request cancel];
    toolbar.hidden = YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //NSLog(@"%@", [[change objectForKey:NSKeyValueChangeNewKey] class]);
    
    if ([[change objectForKey:NSKeyValueChangeNewKey] integerValue] == 0) {
        standingsTableView.hidden = NO;
        scheduleTableView.hidden = YES;
        detailView.hidden = YES;
        [standingsTableView reloadData];
    } else if ([[change objectForKey:NSKeyValueChangeNewKey] integerValue] == 1) {
        standingsTableView.hidden = YES;
        scheduleTableView.hidden = NO;
        detailView.hidden = NO;
        ASIHTTPRequest *request1 = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://sd45app.com/sentinel/athletics/schedule.php?codekey=%@",codekey]]];
        [request1 setDelegate:self];
        [request1 startAsynchronous];
        [scheduleTableView reloadData];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSError *error;
    //NSLog(@"%@",request.responseData);
    NSArray *data = [NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:&error];
    NSLog(@"%@",data);
    NSURL *requesturl = request.url;
    NSString *standingsURL = [NSString stringWithFormat:@"http://sd45app.com/sentinel/athletics/standings.php?codekey=%@",codekey];
    NSString *scheduleURL = [NSString stringWithFormat:@"http://sd45app.com/sentinel/athletics/schedule.php?codekey=%@",codekey];
    if ([requesturl isEqual:[NSURL URLWithString:standingsURL]]) {
        standingsArray = data;
    } else if ([requesturl isEqual:[NSURL URLWithString:scheduleURL]]) {
        scheduleArray = data;
    }
    //NSLog(@"%c",[requesturl isEqual:[NSURL URLWithString:standingsURL]]);
    //NSLog(@"%@, %@",standingsURL,scheduleURL);
    //NSLog(@"%@",requesturl);
    NSLog(@"%@", standingsArray);
    NSLog(@"%@", scheduleArray);
    [standingsTableView reloadData];
    [scheduleTableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Request Failed: %@", [error localizedDescription]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Unable to connect to the athletics feed. Please check your internet connection, then restart the app." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [alert show];
}

#pragma mark - Table View Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == standingsTableView) {
        return [standingsArray count];
    } else if (tableView == scheduleTableView) {
        return [scheduleArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == standingsTableView) {
        static NSString *CellIdentifier = @"StandingsCell";
        StandingsCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StandingsCustomCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *tempdict = [standingsArray objectAtIndex:indexPath.row];
        //NSString *wins = [tempdict objectForKey:@"wins"];
        //NSInteger winsInt = [wins integerValue];
        //NSLog(@"%i", winsInt);
        cell.teamName.text = [tempdict objectForKey:@"teamName"];
        cell.wins.text = [NSString stringWithFormat: @"%i",[[tempdict objectForKey:@"wins"] integerValue]];
        cell.losses.text = [NSString stringWithFormat:@"%i",[[tempdict objectForKey:@"losses"] integerValue]];
        cell.ties.text = [NSString stringWithFormat:@"%i",[[tempdict objectForKey:@"ties"] integerValue]];
        cell.gamesPlayed.text = [NSString stringWithFormat:@"%i",[[tempdict objectForKey:@"gamesPlayed"] integerValue]];
        cell.points.text = [NSString stringWithFormat:@"%i",[[tempdict objectForKey:@"points"] integerValue]];

        return cell;
        //cell.textLabel.text = @"Hello1";
    }    else if(tableView == scheduleTableView) {
        NSDictionary *tempdict = [scheduleArray objectAtIndex:indexPath.row];
        NSLog(@"%@",tempdict);
        static NSString *CellIdentifier = @"ScheduleCell";
        ScheduleCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
           NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ScheduleCustomCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.homeTeam.text = [NSString stringWithFormat:@"%@ vs. %@",[tempdict objectForKey:@"homeTeam"],[tempdict objectForKey:@"awayTeam"]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        NSDate *gameDate = [dateFormatter dateFromString:[tempdict objectForKey:@"date"]];
        [dateFormatter setDateFormat:@"MMM d, yyyy"];
        cell.theDate.text = [dateFormatter stringFromDate:gameDate];
        [dateFormatter setDateFormat:@"HH:mm:ss:SSS"];
        NSDate *gameTime = [dateFormatter dateFromString:[tempdict objectForKey:@"gameTime"]];
        [dateFormatter setDateFormat:@"hh:mm a"];
        cell.gameTime.text = [dateFormatter stringFromDate:gameTime];
            
        return cell;
        //cell.textLabel.text = [[scheduleArray objectAtIndex:indexPath.row] objectAtIndex:6];
        //cell.textLabel.text = @"Hello2";

    }
    return 0; //fail-safe
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *imageName;
    if (indexPath.row % 2) {
        imageName = @"Standings Cell White2.png";
    }
    else {
        imageName = @"Standings Cell Dark White2.png";
    }
    UIColor *cellColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
    cell.backgroundColor = cellColor;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == standingsTableView) {
        return  30;
    } else if (tableView == scheduleTableView) {
        return 50;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{ if (tableView==standingsTableView){
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    UILabel *teamName = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, tableView.bounds.size.width, 18)];
    teamName.backgroundColor = [UIColor clearColor];
    teamName.textColor = [UIColor whiteColor];
    teamName.font = [UIFont boldSystemFontOfSize:14];
    teamName.text = @"Team Name                  W       L     T      GP     P";
    [headerView addSubview:teamName];
    [headerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Standings Cell Blue.png"]]];
    return headerView;
}
else if(tableView==scheduleTableView){
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    UILabel *teamName = [[UILabel alloc] initWithFrame:CGRectMake(6, 5, tableView.bounds.size.width, 18)];
    teamName.backgroundColor = [UIColor clearColor];
    teamName.textColor = [UIColor whiteColor];
    teamName.font = [UIFont boldSystemFontOfSize:14];
    teamName.text = @"Home Team vs. Away Team      Date";
    [headerView addSubview:teamName];
    [headerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Standings Cell Blue.png"]]];
    return headerView;
} return 0;
}
//footer

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{ if (tableView==standingsTableView){
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [footerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"esportsdeskpro.png"]]];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerTwoTaps)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
[footerView addGestureRecognizer:recognizer];
    

    return footerView;
}
else if(tableView==scheduleTableView){
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [footerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"esportsdeskpro.png"]]];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerTwoTaps)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [footerView addGestureRecognizer:recognizer];
    return footerView;
} return 0;
}

//footer



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == scheduleTableView) {
        NSDictionary *tempdict = [scheduleArray objectAtIndex:indexPath.row];
        self.homeTeamLabel.text = [tempdict objectForKey:@"homeTeam"];
        self.awayTeamLabel.text = [tempdict objectForKey:@"awayTeam"];
        self.locationLabel.text = [NSString stringWithFormat:@"@ %@",[tempdict objectForKey:@"location"]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        NSDate *gameDate = [dateFormatter dateFromString:[tempdict objectForKey:@"date"]];
        [dateFormatter setDateFormat:@"MMM d, yyyy"];
        self.dateTimeLabel.text = [dateFormatter stringFromDate:gameDate];
        self.address = [tempdict objectForKey:@"address"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}@end