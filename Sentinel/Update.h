//
//  Update.h
//  Sentinel
//
//  Created by Adam Mitha on 12-06-21.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Update : NSObject

@property (nonatomic, strong) NSURL *updateURL;

- (id)initWithURL:(NSURL *)url;

@end
