//
//  LocationAddViewController.h
//  StopCheck
//
//  Created by Jeremiah on 2/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationManager.h"
#import "ReminderNotesViewController.h"

@interface LocationAddViewController : NSObject<ReminderRepeatViewControllerDelegate>
{
    Location *location;
    ReminderNotesViewController *reminderNotesViewController;
    LocationManager *locationManager;
}

@property (strong, nonatomic) IBOutlet UILabel *add_name_lbl;
@property (strong, nonatomic) IBOutlet UILabel *add_street_lbl;
@property (strong, nonatomic) IBOutlet UIButton *add_btn;

- (void)setLocation:(Location *)newLocation;

- (void)setReminderNotesViewController:(ReminderNotesViewController *)vc;
- (Reminder *) reminder;
- (void)addReminderToLocation;
- (void)addReminderToLocationComplete:(NSNotification *)notification;

- (void)setLocationManager:(LocationManager *)newlocationManager;
- (LocationManager *)locationManager;
@end
