//
//  MonitoredLocationPin.h
//  StopCheck
//
//  Created by Jeremiah on 9/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Location.h"

@interface MonitoredLocationPin : MKPointAnnotation

@property (strong, nonatomic) Location* location;

@end
