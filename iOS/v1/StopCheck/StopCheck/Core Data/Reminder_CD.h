//
//  Reminder_CD.h
//  StopCheck
//
//  Created by Jeremiah on 7/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Reminder_CD : NSManagedObject

@property (nonatomic, retain) NSString * days;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSNumber * locationId;
@property (nonatomic, retain) NSNumber * reminderId;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * shouldRepeatWeekly;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSNumber * triggerType;
@property (nonatomic, retain) NSNumber * isTurnedOn;

@end
