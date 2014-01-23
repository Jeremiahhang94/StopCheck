//
//  Reminder.h
//  StopCheck
//
//  Created by Jeremiah on 7/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reminder_CD.h"

typedef enum TriggerType {
    kTriggerOnNone = -1,
    kTriggerOnEnter = 0,
    kTriggerOnExit = 1,
    kTriggerOnBoth = 2
} TriggerType;

@interface Reminder : NSObject
{
    
    NSDate *startDate;
    NSDate *endDate; 
    
}

@property (nonatomic) NSInteger reminderId;
@property (nonatomic) NSInteger locationId;

@property (strong, nonatomic) NSArray *notes;
@property (strong, nonatomic) NSArray *days;
@property (nonatomic) BOOL shouldRepeatWeekly;
@property (nonatomic) TriggerType triggerType;

@property (nonatomic) BOOL isTurnedOn;

- (NSDate *)startDate;

- (void)getEndDate;
- (void)setStartDate:(NSDate *)newStartDate;
- (id) initWithReminder:(Reminder_CD *)reminder_cd;

- (NSString *)noteString;
- (NSString *)daysString;
- (NSString *)stringify:(NSArray *)array;

@end
