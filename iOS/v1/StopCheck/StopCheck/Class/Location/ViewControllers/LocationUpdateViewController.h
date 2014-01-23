//
//  LocationUpdateViewController.h
//  StopCheck
//
//  Created by Jeremiah on 2/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "ReminderNotesViewController.h"

#define REMINDER_UPDATE_NOTIFICATION @"reminderUpdateNotification"

@interface LocationUpdateViewController : NSObject<ReminderRepeatViewControllerDelegate>
{
    Reminder *reminder;
    Location *location;
    LocationManager *locationManager;
    
    ReminderNotesViewController *reminderNotesViewController;
}

- (void)setReminderNotesViewController:(ReminderNotesViewController *)vc;
- (void)setReminder:(Reminder *)newReminder;
- (Reminder *)reminder;
- (void)setLocation:(Location *)newLocation;

- (void)updateReminder;
- (void)updateReminderComplete:(NSNotification *)notification;

- (void)setLocationManager:(LocationManager *)newlocationManager;
- (LocationManager *)locationManager;
@end
