//
//  Reminder.m
//  StopCheck
//
//  Created by Jeremiah on 7/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder

- (id)init
{
    self = [super init];
    if(self)
    {
        startDate = [NSDate date];
        [self getEndDate];
    }
    return self;
}

- (id) initWithReminder:(Reminder_CD *)reminder_cd
{
    self = [self init];
    
    self.reminderId = reminder_cd.reminderId.integerValue;
    self.locationId = reminder_cd.locationId.integerValue;
    self.notes = [reminder_cd.notes componentsSeparatedByString:@", "];
    self.days = [reminder_cd.days componentsSeparatedByString:@", "];
    [self setStartDate:reminder_cd.startDate];
    self.shouldRepeatWeekly = reminder_cd.shouldRepeatWeekly.boolValue;
    self.isTurnedOn = reminder_cd.isTurnedOn.boolValue;
    
    int triggerType = reminder_cd.triggerType.intValue;
    switch (triggerType) {
        case -1:
            self.triggerType = kTriggerOnNone;
            break;
        case 0:
            self.triggerType = kTriggerOnEnter;
            break;
        case 1:
            self.triggerType = kTriggerOnExit;
            break;
        case 2:
            self.triggerType = kTriggerOnBoth;
            break;
            
        default:
            self.triggerType = kTriggerOnNone;
            break;
    }
    
    return self;
}

- (void)getEndDate
{
    endDate = [startDate dateByAddingTimeInterval:60*60*24*7];
}

- (void)setStartDate:(NSDate *)newStartDate
{
    startDate = newStartDate;
}

- (NSDate *)startDate
{
    return startDate;
}

- (NSString *)noteString
{
    return [self stringify:self.notes];
}
- (NSString *)daysString
{
    return [self stringify:self.days];
}
- (NSString *)stringify:(NSArray *)array
{
    int ii, length = [array count];
    NSString *toReturn = @"";
    for( ii = 0; ii<length; ii++)
        toReturn = [NSString stringWithFormat:@"%@%@, ", toReturn, [array objectAtIndex:ii]];
    
    return toReturn;
}

@end
