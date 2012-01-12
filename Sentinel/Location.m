//
//  Location.m
//  Sentinel
//
//  Created by Adam Mitha on 12-01-08.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import "Location.h"

@implementation Location
@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;

- (id)initWithName:(NSString *)name address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate
{
    if ((self = [super init])) {
        _name = name;
        _address = address;
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title
{
    return _name;
}

- (NSString *)subtitle
{
    return _address;
}
@end
