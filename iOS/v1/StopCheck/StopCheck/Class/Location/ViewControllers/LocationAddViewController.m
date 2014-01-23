//
//  LocationAddViewController.m
//  StopCheck
//
//  Created by Jeremiah on 2/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import "LocationAddViewController.h"

#define ADD_REMINDER_NOTIFICATION @"AddReminderNotif"

@interface LocationAddViewController ()

@end

@implementation LocationAddViewController

@synthesize
add_name_lbl,
add_street_lbl;


#pragma mark - LocationAddRepeatViewControllerDelegate Method

- (void)reminderDidSave
{
    [self addReminderToLocation];
}

#pragma mark - Add Reminder Methods

- (Reminder *)reminder
{
    Reminder *reminder = [Reminder new];
    reminder.reminderId = 0;
    reminder.notes = [reminderNotesViewController notes];
    reminder.locationId = location.locationId;
    reminder.days = [[reminderNotesViewController repeatViewController] days];
    reminder.shouldRepeatWeekly = [[reminderNotesViewController repeatViewController] repeatWeekly];
    reminder.triggerType = [[reminderNotesViewController repeatViewController] triggerType];
    NSLog(@"Trigger Type: %i", reminder.triggerType);
    return reminder;
}

- (void)addReminderToLocation
{
    Reminder *reminder = [self reminder];
    NSLog(@"Add Reminder");
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addReminderToLocationComplete:) name:ADD_REMINDER_NOTIFICATION object:nil];
    [[self locationManager] addReminder:reminder ToLocation:location Notification:ADD_REMINDER_NOTIFICATION];
}

- (void)addReminderToLocationComplete:(NSNotification *)notification
{
    
    NSLog(@"Add Reminder Complete");
    location = (Location *)notification.object;
    [NotificationCenter requestForLocationViewControllerWithLocation:location];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ADD_REMINDER_NOTIFICATION object:nil];
}

- (void)setLocation:(Location *)newLocation
{
    location = newLocation;
}

- (void)setReminderNotesViewController:(ReminderNotesViewController *)vc
{
    reminderNotesViewController = vc;
}

#pragma mark - Location Manager

- (void)setLocationManager:(LocationManager *)newlocationManager
{
    locationManager = newlocationManager;
}

- (LocationManager *)locationManager
{
    if(locationManager == NULL)
        locationManager = [[LocationManager alloc] init];
    
    return locationManager;
}


@end
