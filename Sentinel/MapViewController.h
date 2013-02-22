//
//  MapViewController.h
//  Sentinel
//
//  Created by Adam Mitha on 12-01-07.
//  Copyright (c) 2012 Sentinel Secondary School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/Mapkit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "MBProgressHUD.h"
@interface MapViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, strong) GMSMapView *mapView;
- (IBAction)buttonPressed:(UIBarButtonItem *)sender;
- (void)launchMaps;
@end
