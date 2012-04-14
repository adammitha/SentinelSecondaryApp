//
//  Update.m
//  Sentinel
//
//  Created by Adam Mitha on 12-04-14.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import "Update.h"

@implementation Update
@synthesize updateURL = _updateURL;
@synthesize responseData = _responseData;
@synthesize progressHUD = _progressHUD;

- (id)initWithURL:(NSURL *)url
{
    if (self = [super init]) {
        self.updateURL = url;
    }
    return self;
}

- (NSData *)update
{
    return self.responseData;
}
@end
