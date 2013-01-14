//
//  AthleticsHomeViewController.h
//  Sentinel
//
//  Created by Justin Wong on 13-01-13.
//  Copyright (c) 2013 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface AthleticsHomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
- (IBAction)feedback:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *athleticsTableView;
@property (nonatomic, strong)
    NSArray *athleticsArray;
-(void)swipeDidOccur;
@end
