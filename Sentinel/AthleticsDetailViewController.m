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
    standingsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 88) style:UITableViewStylePlain];
    [standingsTableView setDelegate:self];
    [standingsTableView setDataSource:self];
    standingsTableView.hidden = NO;
    [self.view addSubview:standingsTableView];
    
    scheduleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 88) style:UITableViewStylePlain];
    [scheduleTableView setDelegate:self];
    [scheduleTableView setDataSource:self];
    scheduleTableView.hidden = YES;
    [self.view addSubview:scheduleTableView];
    
    NSError *error;
    
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
        [scheduleTableView reloadData];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSError *error;
    NSURL *requesturl = request.url;
    NSLog(@"%@",requesturl);
    if (requesturl == [NSURL URLWithString:[NSString stringWithFormat:@"http://sd45app.com/sentinel/athletics/standings.php?codekey=%@",codekey]]) {
        standingsArray = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:&error];
        [standingsTableView reloadData];
    } else if (requesturl == [NSURL URLWithString:[NSString stringWithFormat:@"http://sd45app.com/sentinel/athletics/schedule.php?codekey=%@",codekey]]) {
        scheduleArray = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:&error];
    }
    NSLog(@"%@", standingsArray);
    NSLog(@"%@", scheduleArray);
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    if (tableView == standingsTableView) {
        cell.textLabel.text = [[standingsArray objectAtIndex:indexPath.row] objectForKey:@"teamName"];
        //cell.textLabel.text = @"Hello1";
    } else if(tableView == scheduleTableView) {
        cell.textLabel.text = [[scheduleArray objectAtIndex:indexPath.row] objectAtIndex:6];
        //cell.textLabel.text = @"Hello2";
    }
    return cell;
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
