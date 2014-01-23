//
//  Location.m
//  StopCheck
//
//  Created by Jeremiah on 2/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import "Location.h"

@implementation Location

- (id) initWithLocation:(Location_CD *)location_cd
{
    self = [self init];
    
    self.locationId = location_cd.locationId.integerValue;
    self.name = location_cd.name;
    self.street = location_cd.street;
    self.startDate = location_cd.startDate;
    self.coordinate = CLLocationCoordinate2DMake(location_cd.latitude.doubleValue, location_cd.longitude.doubleValue);
    self.reminderCount = location_cd.reminderCount.integerValue;
    self.isMonitored = location_cd.isMonitored.boolValue;
    
    return self;
}

@end
