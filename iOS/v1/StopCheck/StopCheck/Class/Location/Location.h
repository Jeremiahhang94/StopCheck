//
//  Location.h
//  StopCheck
//
//  Created by Jeremiah on 2/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Location_CD.h"
#import "Reminder.h"

#define SHOW_LOCATION_ADD_NOTIFICATION @"showLocationAddNotification"
#define SHOW_LOCATION_UPDATE_NOTIFICATION @"showLocationUpdateNotification"
#define SHOW_LOCATION_NOTIFICATION @"showLocationNotification"
#define SHOW_MAP_NOTIFICATION @"showMapNotification"
#define SHOW_ACTIVE_VIEW_CONTROLLER @"showActiveViewController"

@interface Location : NSObject

- (id) initWithLocation:(Location_CD *)location_cd;

//Variables
@property (nonatomic) int locationId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *street;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) int reminderCount;
@property (nonatomic) BOOL isMonitored;
@property (strong, nonatomic) NSDate *startDate;

@end
