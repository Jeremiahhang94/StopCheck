//
//  LocationUpdateViewController.m
//  StopCheck
//
//  Created by Jeremiah on 2/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import "LocationUpdateViewController.h"

@interface LocationUpdateViewController ()

@end

@implementation LocationUpdateViewController

- (void)setReminderNotesViewController:(ReminderNotesViewController *)vc
{
    reminderNotesViewController = vc;
}

- (void)setReminder:(Reminder *)newReminder
{
    reminder = newReminder;
    NSLog(@"Trigger type: %i", reminder.triggerType);
}

- (Reminder *)reminder
{
    return reminder;
}

- (void)setLocation:(Location *)newLocation
{
    NSLog(@"Set Location: %@", newLocation.name);
    location = newLocation;
}

- (void)reminderDidSave
{
    reminder.notes = [reminderNotesViewController notes];
    reminder.days = [[reminderNotesViewController repeatViewController] days];
    reminder.shouldRepeatWeekly = [[reminderNotesViewController repeatViewController] repeatWeekly];
    reminder.triggerType = [[reminderNotesViewController repeatViewController] triggerType];
    
    [self updateReminder];
}

- (void)updateReminder
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateReminderComplete:) name:REMINDER_UPDATE_NOTIFICATION object:nil];
    [[self locationManager] updateReminder:reminder Notification:REMINDER_UPDATE_NOTIFICATION];
}

- (void)updateReminderComplete:(NSNotification *)notification
{
    NSLog(@"Update Reminder Complete: %@", notification.object);
    [NotificationCenter requestForLocationViewControllerWithLocation:location];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:REMINDER_UPDATE_NOTIFICATION object:nil];
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
