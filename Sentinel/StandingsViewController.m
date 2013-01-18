//
//  StandingsViewController.m
//  Sentinel
//
//  Created by Justin Wong on 13-01-13.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import "StandingsViewController.h"
#import "StandingsCustomCell.h"
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"
@interface StandingsViewController ()

@end

@implementation StandingsViewController
@synthesize testArray;
@synthesize codekey;
@synthesize progressHUD;
@synthesize toolbar;
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height-30);
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Dotbackground.png"]];
    toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleBlack;
    toolbar.frame = CGRectMake(0, 436, self.view.frame.size.width, 44);
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Standings", @"Schedule",nil]];
    segmentedControl.frame = CGRectMake(self.tableView.bounds.size.width/5, 3, 200, 30);
    [toolbar addSubview:segmentedControl];
    [self.navigationController.view addSubview:toolbar];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://sd45app.com/sentinel/athletics/standings.php?codekey=%@",codekey]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHUD.labelText = @"Loading...";
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    NSError *error;
    testArray = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    //NSLog(@"%@",testArray);
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Request Failed: %@", [error localizedDescription]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Unable to connect to the events feed. Please check your internet connection, then restart the app." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [alert show];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    toolbar.hidden = YES;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    if ([testArray count]*30 > (tableView.bounds.size.height - 44)) {
        return [testArray count] + 2;
    }
    else {
        return [testArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StandingsCell";
    StandingsCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StandingsCustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the cell...
    if (indexPath.row < [testArray count]) {
        NSDictionary *tempdict = [testArray objectAtIndex:indexPath.row];
        //NSString *wins = [tempdict objectForKey:@"wins"];
        //NSInteger winsInt = [wins integerValue];
        //NSLog(@"%i", winsInt);
        cell.teamName.text = [tempdict objectForKey:@"teamName"];
        cell.wins.text = [NSString stringWithFormat: @"%i",[[tempdict objectForKey:@"wins"] integerValue]];
        cell.losses.text = [NSString stringWithFormat:@"%i",[[tempdict objectForKey:@"losses"] integerValue]];
        cell.ties.text = [NSString stringWithFormat:@"%i",[[tempdict objectForKey:@"ties"] integerValue]];
        cell.gamesPlayed.text = [NSString stringWithFormat:@"%i",[[tempdict objectForKey:@"gamesPlayed"] integerValue]];
        cell.points.text = [NSString stringWithFormat:@"%i",[[tempdict objectForKey:@"points"] integerValue]];
    }
    else {
        cell.teamName.text = nil;
        cell.wins.text = nil;
        cell.losses.text = nil;
        cell.ties.text = nil;
        cell.gamesPlayed.text = nil;
        cell.points.text = nil;
    }
    return cell;
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
    teamName.text = @"Team Name               W      L      T      GP      P";
    [headerView addSubview:teamName];
    [headerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Standings Cell Blue.png"]]];
    return headerView;
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
