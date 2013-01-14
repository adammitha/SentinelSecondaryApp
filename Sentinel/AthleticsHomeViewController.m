//
//  AthleticsHomeViewController.m
//  Sentinel
//
//  Created by Justin Wong on 13-01-13.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import "AthleticsHomeViewController.h"
#import "StandingsViewController.h"
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

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [athleticsTableView setDelegate:self];
    [athleticsTableView setDataSource:self];
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sports" ofType:@"txt"]];
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
    NSDictionary *tempdict = [athleticsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [tempdict objectForKey:@"name"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StandingsViewController *vc = [[StandingsViewController alloc] init];
    NSDictionary *tempdict2 = [athleticsArray objectAtIndex:indexPath.row];
    vc.codekey = [tempdict2 objectForKey:@"codekey"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
