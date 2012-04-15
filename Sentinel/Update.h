//
//  Update.h
//  Sentinel
//
//  Created by Adam Mitha on 12-04-14.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"
@interface Update : NSObject

@property (nonatomic, strong) NSURL *updateURL;
@property (nonatomic, strong) NSData *responseData;
@property (nonatomic, strong) MBProgressHUD *progressHUD;

- (id)initWithURL:(NSURL *)url;
- (void)checkForUpdate;
- (NSData *)update;
@end
