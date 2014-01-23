//
//  AllLocationViewController.h
//  StopCheck
//
//  Created by Jeremiah on 15/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonitoredLocationPin.h"

@interface AllLocationViewController : UITableViewController
{
    NSMutableArray *tableArray;
    LocationManager *locationManager;
}

- (void)setTableArray:(NSArray *)newTableArray;

- (void)setLocationManager:(LocationManager *)newLocationManager;
- (LocationManager *)locationManager;
@end
