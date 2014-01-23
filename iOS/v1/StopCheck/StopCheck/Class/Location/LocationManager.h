//
//  LocationManager.h
//  StopCheck
//
//  Created by Jeremiah on 2/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "Location.h"
#import "NotificationCenter.h"
#import "DatabaseFactory.h"

@interface LocationManager : NSObject<CLLocationManagerDelegate>
{
    DatabaseFactory *databaseFactory;
    CLLocationManager *clLocationManager;
}

+ (NSString *)stringify:(NSArray *)array;

/*
 
 Fetch Location Method
 
 */
- (Location *)locationOfCoordinate:(CLLocationCoordinate2D)coordinate Name:(NSString *)name Street:(NSString *)street;
- (void)locationOfCoordinate:(CLLocationCoordinate2D)coordinate Notification:(NSString *)notification;
- (void)locationOfSearchQuery:(NSString *)search Region:(MKCoordinateRegion)region Notification:(NSString *)notification;
- (Location *)locationOfId:(NSString *)locationId;

/*
    Check if Location should start monitoring or stop monitoring
 */
- (CLLocationManager *)clLocationManager;
- (BOOL)shouldChangeMonitoringStatusOfLocation:(Location *)location;
- (void)location:(Location *)location ShouldMonitor:(BOOL)shouldMonitor;
- (NSArray *)reminderNotesOfLocation:(NSString *)locationId UponEntering:(BOOL)uponEntering;

//Post a notification
+ (void) scheldueLocalNotificationWithReminders:(NSArray *)message
                                     LocationId:(NSString *)locationId;


#pragma mark - LocationManager to DatabaseFactory

- (DatabaseFactory *)databaseFactory;

//Add Reminder to Location Methods
- (void)addReminder:(Reminder *)reminder ToLocation:(Location *)location Notification:(NSString *)notification;
- (void)addReminderCompleteWithLocation:(Location *)location Notification:(NSString *)notification;

//Fetch Monitored Region Methods
- (void)monitoredRegionWithNotification:(NSString *)notification;
- (void)monitoredRegion:(NSArray *)monitoredRegion CompleteWithNotification:(NSString *)notification;

//Fetch Reminder Of Location
- (NSArray *)remindersOfLocation:(Location *)location;
- (void)remindersOfLocation:(Location *)location Notification:(NSString *)notification;

//Delete reminder from location methods
- (BOOL)removeReminder:(Reminder *)reminder FromLocation:(Location *)location;

//Update reminder
- (BOOL)updateReminder:(Reminder *)reminder;
- (void)updateReminder:(Reminder *)reminder Notification:(NSString *)notification;

//Delete Location methods
- (BOOL)removeLocation:(Location *)location;


@end
