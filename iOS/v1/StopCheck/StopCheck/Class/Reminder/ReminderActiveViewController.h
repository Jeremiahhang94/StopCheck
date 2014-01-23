//
//  ReminderActiveViewController.h
//  StopCheck
//
//  Created by Jeremiah on 21/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface ReminderActiveViewController : UITableViewController
{
    NSString *locationId;
    Location *location;
    NSMutableArray *reminders;
    NSMutableArray *tableArray;
    LocationManager *locationManager;
}

- (IBAction)closeBtnClicked:(id)sender;
- (LocationManager *)locationManager;

- (void)setLocationId:(NSString *)newLocationId;
- (void)fetchLocation;

- (void)fetchReminders;
- (void)setReminders:(NSMutableArray *)newReminders;
- (void)addReminder:(Reminder *)reminder;

- (void)loadTableArray;

@end
