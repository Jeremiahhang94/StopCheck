//
//  LocationAddRepeatViewController.h
//  StopCheck
//
//  Created by Jeremiah on 6/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddDaysCell.h"
#import "AddRepeatWeeklyCell.h"

@protocol ReminderRepeatViewControllerDelegate <NSObject>

- (void)reminderDidSave;

@end


@interface ReminderRepeatViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *reminderNotes;
    AddDaysCell *addDaysCell;
    AddRepeatWeeklyCell *addRepeatWeeklyCell;
    
    Reminder *reminder;
    
}

@property (weak, nonatomic) id<ReminderRepeatViewControllerDelegate> delegate;

//save button
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveBtn;

//table view
@property (strong, nonatomic) IBOutlet UITableView *tableView;

//Receive the reminder notes from Location Add Notes View Controller
- (void)setReminderNotes:(NSArray *)newReminderNotes;

//IBActions
- (IBAction)saveBtnClicked:(id)sender;

//Reminder's properties
- (NSArray *) days;
- (BOOL) repeatWeekly;
- (TriggerType) triggerType;

- (void)setReminder:(Reminder *)newReminder;
- (void)setCellValues;

@end
