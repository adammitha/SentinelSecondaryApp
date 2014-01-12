//
//  EventsViewController.m
//  Sentinel
//
//  Created by Adam Mitha on 11-12-08.
//  Copyright (c) 2011 Sentinel Secondary School. All rights reserved.
//

#import "EventsViewController.h"
#import "ASIHTTPRequest.h"
#import "EventsDetailViewController.h"
#import "MBProgressHUD.h"
#import "HomePageViewController.h"
#import "constants.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
@implementation EventsViewController
@synthesize eventsArray = _eventsArray;
@synthesize progressHUD = _progressHUD;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setEventsArray:(NSArray *)eventsArray 
{
    _eventsArray = [[NSArray alloc] initWithArray:eventsArray];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)goHome
{
    //HomePageViewController *homePageViewController = [[HomePageViewController alloc] init];
    [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
    //[self presentViewController:homePageViewController animated:YES completion:^(){NSLog(@"Testing...");}];
}

- (void)swipeDidOccur
{
    [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
}



#pragma mark - View lifecycle
- (void)viewDidLoad
{
    self.tabBarController.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDidOccur)];
    swipeRecognizer.direction= UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRecognizer];
    self.tabBarController.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
      //swipe
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(goHome)];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    self.navigationItem.leftBarButtonItem = item;
    NSURL *url = [NSURL URLWithString:kEventsURL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.progressHUD.labelText = @"Loading...";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.

    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}


- (void)refresh
{
    NSURL *url = [NSURL URLWithString:kEventsURL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];

}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self.refreshControl endRefreshing];
    NSData *responseData = [request responseData];
    NSError* error;
    NSArray* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    //NSLog(@"%@", json);
    self.eventsArray = json;
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
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
    return [self.eventsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSDictionary *tempdict = [[NSDictionary alloc] initWithDictionary:[self.eventsArray objectAtIndex:indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    cell.textLabel.text = [tempdict objectForKey:@"title"];
    return cell;
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
    EventsDetailViewController *eventsDetailViewController = [[EventsDetailViewController alloc] initWithNibName:@"EventsDetailViewController" bundle:nil];
    NSDictionary *tempdict = [[NSDictionary alloc] initWithDictionary:[self.eventsArray objectAtIndex:indexPath.row]];
    eventsDetailViewController.eventTitle = [tempdict objectForKey:@"title"];
    eventsDetailViewController.eventLink = [tempdict objectForKey:@"link"];
    eventsDetailViewController.eventDescription = [tempdict objectForKey:@"description"];
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:eventsDetailViewController animated:YES];
}

@end
