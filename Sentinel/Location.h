//
//  Location.h
//  Sentinel
//
//  Created by Adam Mitha on 12-01-08.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface Location : NSObject <MKAnnotation>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString *)name address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate;
@end
