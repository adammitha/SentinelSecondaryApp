//
//  SentinelAppDelegate.m
//  Sentinel
//
//  Created by Adam Mitha on 11-12-08.
//  Copyright (c) 2011 Sentinel Secondary School. All rights reserved.
//

#import "SentinelAppDelegate.h"
@implementation SentinelAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    NSData *blockRotation = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BlockRotation2013" ofType:@"txt"]];
    NSError *error;
    NSDictionary *rotationsDict = [NSJSONSerialization JSONObjectWithData:blockRotation options:kNilOptions error:&error];
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:today];
    NSDictionary *dateDict = [rotationsDict objectForKey:dateString];
    UILocalNotification *rotationNotification = [[UILocalNotification alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSUIntegerMax fromDate:today];
    [components setHour:7];
    [components setMinute:0];
    [components setSecond:0];
    rotationNotification.fireDate = [today dateByAddingTimeInterval:10];
    rotationNotification.timeZone = [NSTimeZone defaultTimeZone];
    rotationNotification.alertBody = @"Block Rotation:";
    [[UIApplication sharedApplication] scheduleLocalNotification:rotationNotification];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
