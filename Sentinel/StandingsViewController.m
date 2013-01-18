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
@interface StandingsViewController ()

@end

@implementation StandingsViewController
@synthesize testArray;
@synthesize codekey;
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Dotbackground.png"]];
    self.tableView.backgroundView = nil;
    NSError *error;
    testArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"standings" ofType:@"txt"]] options:kNilOptions error:&error];
    NSLog(@"%@",testArray);
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
    return [testArray count];
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
