//
//  StandingsViewController.m
//  Sentinel
//
//  Created by Adam Mitha on 2013-12-29.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import "StandingsViewController.h"
#import "ASIHTTPRequest.h"
#import "StandingsCustomCell.h"
@interface StandingsViewController ()

@end

@implementation StandingsViewController

@synthesize progressHUD = _progressHUD;
@synthesize codekey = _codekey;
@synthesize standingsArray = _standingsArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.title = @"Standings";
    [self.tableView setDelegate:self];
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height - 150);
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kAthleticsStandingsURL,self.codekey]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHUD.labelText = @"Loading...";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)refresh
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kAthleticsStandingsURL,self.codekey]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ASIHTTPRequest delegate methods

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self.refreshControl endRefreshing];
    NSData *responseData = [request responseData];
    NSError* error;
    NSArray* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    self.standingsArray = json;
    [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.standingsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StandingsCell";
    StandingsCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StandingsCustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    // Configure the cell...
    NSDictionary *tempDict = [self.standingsArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.teamName.text = [tempDict objectForKey:@"teamName"];
    cell.wins.text = [NSString stringWithFormat: @"%i",[[tempDict objectForKey:@"wins"] integerValue]];
    cell.losses.text = [NSString stringWithFormat:@"%i",[[tempDict objectForKey:@"losses"] integerValue]];
    cell.ties.text = [NSString stringWithFormat:@"%i",[[tempDict objectForKey:@"ties"] integerValue]];
    cell.gamesPlayed.text = [NSString stringWithFormat:@"%i",[[tempDict objectForKey:@"gamesPlayed"] integerValue]];
    cell.points.text = [NSString stringWithFormat:@"%i",[[tempDict objectForKey:@"points"] integerValue]];
    return cell;
}

#pragma mark - Table view delegate

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //Header
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 28;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
