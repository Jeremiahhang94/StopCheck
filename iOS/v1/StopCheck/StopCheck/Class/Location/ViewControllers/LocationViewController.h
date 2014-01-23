//
//  LocationViewController.h
//  StopCheck
//
//  Created by Jeremiah on 9/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationManager.h"
#import "ReminderCell.h"

#define REQUEST_REMINDER_NOTIFICATION @"requestReminderNotification"

@interface LocationViewController : UITableViewController
{
    NSMutableArray *tableArray;
    Location *location;
    
    UIView *noReminder_view;
    UILabel *noReminder_label;
    
    LocationManager *locationManager;
}

@property (strong, nonatomic) IBOutlet UIBarButtonItem *addNewReminderBtn;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *mapBtn;


- (Location *) location;
- (void) setLocation:(Location *)newLocation;
- (void) requestReminderComplete:(NSNotification *)notification;
- (void) toggleOnOffReminder:(Reminder *)reminder;

- (IBAction)addNewReminderBtnPressed:(id)sender;
- (IBAction)rightBarBtnPressed:(id)sender;
- (IBAction)mapBtnPressed:(id)sender;
- (IBAction)reminderSwitchChanged:(id)sender;

- (void)showNoReminderView;
- (void)hideNoReminderView;

- (void)setLocationManager:(LocationManager *)newlocationManager;
- (LocationManager *)locationManager;

@end
