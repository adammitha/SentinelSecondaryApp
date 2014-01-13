//
//  StaffEmailViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 12-02-16.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface StaffEmailViewController : UITableViewController <MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) NSArray *emailArray;
@end
