//
//  LocationAddNotesViewController.h
//  StopCheck
//
//  Created by Jeremiah on 6/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReminderRepeatViewController.h"

@interface ReminderNotesViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NSArray *tableArray;
    NSMutableArray *rowsContent;
    Reminder *reminder;
    
}

// delegate
@property (weak, nonatomic) id<ReminderRepeatViewControllerDelegate> delegate;
@property (strong, nonatomic) ReminderRepeatViewController *repeatViewController;

// for use in xib/storyboard:
#define TAG_TEXT_FIELD 10000
#define CELL_REUSE_IDENTIFIER @"EditableTextCell"

@property (strong, nonatomic) IBOutlet UITableView *tableView;

// list data:
@property (nonatomic, copy) NSArray *contents;

// methods for possible overriding:
- (void)contentsDidChange;
- (UITextField *)createTextFieldForCell:(UITableViewCell *)cell;
- (NSArray *)notes;

// methods to set data
- (void)setReminder:(Reminder *)newReminder;


@end
