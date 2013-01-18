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


@interface AthleticsDetailViewController ()

@end

@implementation AthleticsDetailViewController
@synthesize codekey;
@synthesize standingsTableView, scheduleTableView;
@synthesize toolbar,segmentedControl;
@synthesize url;
@synthesize standingsArray, scheduleArray;
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
    codekey = @"4AF26B37-50A6-475C-8305-4B837F5A0445";
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.frame = CGRectMake(0, 20, 320, 44);
    toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleBlack;
    toolbar.frame = CGRectMake(0, 436, self.view.frame.size.width, 44);
    segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Standings", @"Schedule",nil]];
    segmentedControl.frame = CGRectMake(self.view.bounds.size.width/5, 3, 200, 30);
    [toolbar addSubview:segmentedControl];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addObserver:self forKeyPath:@"selectedSegmentIndex" options:NSKeyValueObservingOptionNew context:NULL];
    [self.navigationController.view addSubview:toolbar];
	// Do any additional setup after loading the view.
    standingsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 110) style:UITableViewStylePlain];
    self.standingsTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Dotbackground.png"]];
    [standingsTableView setDelegate:self];
    [standingsTableView setDataSource:self];
    standingsTableView.hidden = NO;
    [self.view addSubview:standingsTableView];
    
    scheduleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 110) style:UITableViewStylePlain];
    self.scheduleTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Dotbackground.png"]];
    [scheduleTableView setDelegate:self];
    [scheduleTableView setDataSource:self];
    scheduleTableView.hidden = YES;
    [self.view addSubview:scheduleTableView];
        
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://sd45app.com/sentinel/athletics/standings.php?codekey=%@",codekey]]];
    [request setDelegate:self];
    [request startAsynchronous];
    //NSLog(@"%@", standingsArray);


    //NSLog(@"%@", standingsArray);
    //[scheduleTableView reloadData];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //NSLog(@"%@", [[change objectForKey:NSKeyValueChangeNewKey] class]);
    
    if ([[change objectForKey:NSKeyValueChangeNewKey] integerValue] == 0) {
        standingsTableView.hidden = NO;
        scheduleTableView.hidden = YES;
        [standingsTableView reloadData];
    } else if ([[change objectForKey:NSKeyValueChangeNewKey] integerValue] == 1) {
        standingsTableView.hidden = YES;
        scheduleTableView.hidden = NO;
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
    } else if(tableView == scheduleTableView) {
        //cell.textLabel.text = [[scheduleArray objectAtIndex:indexPath.row] objectAtIndex:6];
        //cell.textLabel.text = @"Hello2";
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *imageName;
    if (indexPath.row % 2) {
        imageName = @"Standings Cell White.png";
    }
    else {
        imageName = @"Standings Cell Dark White.png";
    }
    UIColor *cellColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
    cell.backgroundColor = cellColor;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
