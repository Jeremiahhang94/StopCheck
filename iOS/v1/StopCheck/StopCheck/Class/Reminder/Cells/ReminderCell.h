//
//  ReminderCell.h
//  StopCheck
//
//  Created by Jeremiah on 13/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReminderCell : UITableViewCell
{
    NSArray *daysArray;
    BOOL isTurnedOn;
}

@property (strong, nonatomic) UISwitch *turnedOn_switch;

- (void)setNotes:(NSString *)notes;
- (void)setDays:(NSArray *)days;
- (void)setIsTurnedOn:(BOOL)turnOn;

@end
