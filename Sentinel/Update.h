//
//  Update.h
//  Sentinel
//
//  Created by Adam Mitha on 12-04-14.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface Update : NSObject

@property (nonatomic, strong) NSURL *updateURL;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSData *updateData;

- (id)initWithURL:(NSURL *)url;
- (void)checkForUpdate;
- (void)logData;
- (NSData *)updateData;
@end
