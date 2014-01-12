//
//  ScheduleViewController.m
//  Sentinel
//
//  Created by Adam Mitha on 2013-12-29.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import "ScheduleViewController.h"
#import "ScheduleCustomCell.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

@synthesize scheduleTableView = _scheduleTableView;
@synthesize scheduleArray = _scheduleArray;
@synthesize codekey = _codekey;

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
    self.title = @"Schedule";
    self.view.backgroundColor = [UIColor whiteColor];
    _scheduleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height-156)];
    [_scheduleTableView setDataSource:self];
    [self.view addSubview:_scheduleTableView];
	// Do any additional setup after loading the view.
}

#pragma mark - Table view delegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ScheduleCell";
    ScheduleCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ScheduleCustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
