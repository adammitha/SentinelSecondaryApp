//
//  DocumentsViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 12-01-19.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface DocumentsViewController : GAITrackedViewController
{
    IBOutlet UIScrollView *scroller;
}

- (IBAction)buttonPressed:(id)sender;
- (void)goHome;
- (void)swipeDidOccur;
@end
