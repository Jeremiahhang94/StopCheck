//
//  LocationManager.m
//  StopCheck
//
//  Created by Jeremiah on 2/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

static CLLocationManager *clLocationManager;

+ (NSString *)stringify:(NSArray *)array
{
    int ii, length = [array count];
    NSString *toReturn = @"";
    for( ii = 0; ii<length; ii++)
    {
        if(ii != length - 1)
            toReturn = [NSString stringWithFormat:@"%@%@, ", toReturn, [array objectAtIndex:ii]];
        else toReturn = [NSString stringWithFormat:@"%@%@", toReturn, [array objectAtIndex:ii]];
    }
    
    return toReturn;
}

/*
    create a location object with the given coordinate, name and street.
 */
- (Location *)locationOfCoordinate:(CLLocationCoordinate2D)coordinate
                              Name:(NSString *)name
                            Street:(NSString *)street
{
    Location *location = [[Location alloc] init];
    location.locationId = 0;
    location.name = name;
    location.street = street;
    location.coordinate = coordinate;
    
    return location;
}

/* 
    Gets a location's name and street with the given coordinate and creates an location object to be returned to the notification
 */
- (void)locationOfCoordinate:(CLLocationCoordinate2D)coordinate Notification:(NSString *)notification
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *touchLocation = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    [geocoder reverseGeocodeLocation:touchLocation
                   completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(!error)
         {
             CLPlacemark *placemark = (CLPlacemark *)[placemarks objectAtIndex:0];
             NSString *name = [(NSDictionary *)[placemark addressDictionary] objectForKey:@"Name"];
             NSString *street = [(NSDictionary *)[placemark addressDictionary] objectForKey:@"Street"];
             if( [name isEqualToString: street])
                 street = nil;
             
             Location *location = [self locationOfCoordinate:coordinate
                                                        Name:name
                                                      Street:street];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:notification
                                                                 object:location];
         }
         else
         {
             
             NSLog(@"Erroor: %@", error);
         }
         
     }];

}

/*
 
 Fetch locations of a given search query, around a certain region. 
 
 Upon successful search for the locations, a notification with the locations are posted.
 
 */
- (void)locationOfSearchQuery:(NSString *)search Region:(MKCoordinateRegion)region Notification:(NSString *)notification
{
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    [searchRequest setNaturalLanguageQuery:search];
    
    [searchRequest setRegion:region];
    
    MKLocalSearch *searchEngine = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [searchEngine startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
            if(!error)
            {
                NSArray *locations = [[self databaseFactory] queryLocationWithSearchQuery:search];
                
                NSDictionary *object = @{ @"database": locations,
                                          @"response": [response mapItems]};
                
                [[NSNotificationCenter defaultCenter] postNotificationName:notification object:object];
            }
        
    }];
}

- (Location *)locationOfId:(NSString *)locationId
{
    return [databaseFactory queryLocationOfId:[locationId intValue]];
}

#pragma mark - Start Stop Location

- (CLLocationManager *)clLocationManager
{
    if(clLocationManager == NULL)
    {
        clLocationManager = [[CLLocationManager alloc] init];
        [clLocationManager setDelegate:self];
    }
    
    return clLocationManager;
}

/*
    Check if a location should change its monitoring status.
 */
- (BOOL)shouldChangeMonitoringStatusOfLocation:(Location *)location
{
    if(location.isMonitored && location.reminderCount <= 0)
        return YES;
    else if(!location.isMonitored && location.reminderCount > 0)
        return YES;
    else return NO;
}

- (void)location:(Location *)location ShouldMonitor:(BOOL)shouldMonitor
{
    if(shouldMonitor)
    {
        NSLog(@"Start Monitoring");
        
        CLLocationCoordinate2D center = location.coordinate;
        NSUInteger radius = 1;
        NSString *identifier = [NSString stringWithFormat:@"%i", location.locationId];
        
        CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:center radius:radius identifier:identifier];
        [[self clLocationManager] startMonitoringForRegion:region];
    }
    else
    {
        NSLog(@"Stop Monitoring"); 
        
        CLCircularRegion *region = [[CLCircularRegion alloc] init];
        [[self clLocationManager] stopMonitoringForRegion:region];
    }
}

- (NSArray *)reminderNotesOfLocation:(NSString *)locationId UponEntering:(BOOL)uponEntering
{
    NSArray *reminders = [[self databaseFactory] queryRemindersOfLocation:[locationId intValue]];
    NSMutableArray *validReminders = [[NSMutableArray alloc] init];
    int ii, length = [reminders count];
    
    if(length < 1)
    {
        return NULL;
    }
    else
    {
        for( ii = 0; ii<length; ii++)
        {
            Reminder *currentReminder = [[Reminder alloc] initWithReminder:[reminders objectAtIndex:ii]];
            
            if(currentReminder.isTurnedOn)
            {
                NSArray *days = [currentReminder days];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC+08:00"]];
                [dateFormatter setDateFormat:@"e"];
                NSInteger today = [[dateFormatter stringFromDate:[NSDate date]] integerValue] - 1;
                
                if( [[days objectAtIndex:today] boolValue] )
                {
                    if((currentReminder.triggerType == kTriggerOnEnter && uponEntering) ||
                       (currentReminder.triggerType == kTriggerOnExit && !uponEntering) ||
                       currentReminder.triggerType == kTriggerOnBoth)
                        [validReminders addObjectsFromArray:[currentReminder notes]];
                }
            }
        }
        
        return validReminders;
    }
    
    

}

#pragma mark - CLLocationManagerDelegate Method

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLCircularRegion *)region
{
    NSString *locationId = region.identifier;
    NSArray *reminders = [self reminderNotesOfLocation:locationId UponEntering:YES];
    
    [LocationManager scheldueLocalNotificationWithReminders:reminders LocationId:locationId];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLCircularRegion *)region
{
    NSString *locationId = region.identifier;
    NSArray *reminders = [self reminderNotesOfLocation:locationId UponEntering:NO];
    
    [LocationManager scheldueLocalNotificationWithReminders:reminders LocationId:locationId];
}

+ (void) scheldueLocalNotificationWithReminders:(NSArray *)message
                                     LocationId:(NSString *)locationId
{
    NSString *notificationMessage;
    if(message != NULL)
    {
        if([message count] < 1)
            notificationMessage = @"No Notes";
        else notificationMessage = [LocationManager stringify:message];
        
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:10];
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        [notif setFireDate:date];
        [notif setTimeZone:[NSTimeZone timeZoneWithName:@"UTC+08:00"]];
        [notif setAlertBody:notificationMessage];
        [notif setAlertAction:NSLocalizedString(@"Open", nil)];
        [notif setSoundName:UILocalNotificationDefaultSoundName];
        [notif setUserInfo:@{ @"LocationId": locationId}];
        [notif setApplicationIconBadgeNumber:1];
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    }
    else
    {
        NSLog(@"Null");
    }
}

#pragma mark - LocationManager to DatabaseFactory
- (DatabaseFactory *)databaseFactory
{
    if(databaseFactory == NULL)
    {
        databaseFactory = [[DatabaseFactory alloc] init];
    }
    
    return databaseFactory;
}
/*
 
 Attach a reminder to a given location.
 
 */
- (void)addReminder:(Reminder *)reminder ToLocation:(Location *)location Notification:(NSString *)notification
{
    NSInteger locationId = location.locationId;
    
    if(location.locationId == 0)
        locationId = [[self databaseFactory] insertLocation:location];
    
    Location *toReturn;
    if(locationId)
    {
        reminder.locationId = locationId;
        [[self databaseFactory] insertReminder:reminder toLocation:&toReturn];
        
        NSLog(@"Add reminder: %@, To Location: %@", reminder, toReturn);
        
        if(location.isMonitored != toReturn.isMonitored)
            [self location:toReturn ShouldMonitor: YES];
        
        [self addReminderCompleteWithLocation:toReturn Notification:notification];
    }
}
- (void)addReminderCompleteWithLocation:(Location *)location Notification:(NSString *)notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:location];
}

/*
 
 Send request for the reminders of a location from the database to be displayed on the map.
 
 */
- (NSArray *)remindersOfLocation:(Location *)location
{
    return [[self databaseFactory] queryRemindersOfLocation:location.locationId];
}
- (void)remindersOfLocation:(Location *)location Notification:(NSString *)notification
{
    [[self databaseFactory] queryRemindersOfLocation:location.locationId Notification:notification];
}

- (void)monitoredRegionWithNotification:(NSString *)notification
{
    //start requesting for monitored region
    NSArray *monitoredRegion = [[self databaseFactory] queryAllMonitoredLocations];
    if(monitoredRegion)
        [self monitoredRegion:monitoredRegion CompleteWithNotification:notification];
    
}

- (void)monitoredRegion:(NSArray *)monitoredRegion CompleteWithNotification:(NSString *)notification
{
    //Finished requesting for monitored region
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:monitoredRegion];
}

- (BOOL)removeReminder:(Reminder *)reminder FromLocation:(Location *)location
{
    BOOL locationWasMonitored = location.isMonitored;
    if([[self databaseFactory] deleteReminder:reminder FromLocation:&location])
    {
        //Deleted
        //Update Location
        if(locationWasMonitored != location.isMonitored)
            [self location:location ShouldMonitor: NO];
        
        return YES;
        
    }
    else return NO;
}

- (BOOL)updateReminder:(Reminder *)reminder
{
    return [[self databaseFactory] updateReminder:reminder];
}
- (void)updateReminder:(Reminder *)reminder Notification:(NSString *)notification
{
    [[self databaseFactory] updateReminder:reminder Notification:notification];
}

- (BOOL)removeLocation:(Location *)location
{
    return [[self databaseFactory] deleteLocation:location];
}


@end
