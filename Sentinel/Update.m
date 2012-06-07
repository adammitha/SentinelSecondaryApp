//
//  Update.m
//  Sentinel
//
//  Created by Adam Mitha on 12-04-14.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#import "Update.h"

@implementation Update
@synthesize updateURL = _updateURL;
@synthesize progressHUD = _progressHUD;
@synthesize data = _data;
@synthesize updateData = _updateData;
- (id)initWithURL:(NSURL *)url
{
    if (self = [super init]) {
        self.updateURL = url;
    }
    return self;
}

- (void)checkForUpdate
{
    dispatch_async(kBgQueue, ^{
        self.data = [NSData dataWithContentsOfURL:_updateURL];
        if (self.data) {
            [self performSelectorOnMainThread:@selector(updateData) withObject:self.data waitUntilDone:YES];
        }
    });

}

- (void)logData
{
    NSError *error;
    NSDictionary *tempdict = [NSJSONSerialization JSONObjectWithData:self.data options:kNilOptions error:&error];
    NSLog(@"%@", tempdict);
}

- (NSData *)updateData
{
    dispatch_async(kBgQueue, ^{
        //get update data from here
    });
    return self.updateData;
}
@end
