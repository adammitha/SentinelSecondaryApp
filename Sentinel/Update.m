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

- (void)checkForUpdate
{
    NSLog(@"checkForUpdate");
    //ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:self.updateURL];
    //[request setDelegate:self];
    //[request startAsynchronous];
    /*NSError *error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:&error];
    if ([[json objectForKey:@"Update needed"] isEqualToString:@"YES"]) {
        [self update];
    }*/
}

- (NSData *)update
{
    NSLog(@"%@", self.responseData);
    return self.responseData;
}

- (void)requestFinished:(ASIHTTPRequest *)request 
{
    self.responseData = [request responseData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Unable to retrieve updates: %@", [error localizedDescription]);
}
@end
