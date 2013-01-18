//
//  Update.m
//  Sentinel
//
//  Created by Adam Mitha on 12-06-21.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import "Update.h"

@implementation Update
@synthesize updateURL = _updateURL;
- (id)initWithURL:(NSURL *)url
{
    if (self = [super init]) {
        _updateURL = url;
    }
    return self;
}
@end
