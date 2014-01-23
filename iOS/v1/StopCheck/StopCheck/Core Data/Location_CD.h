//
//  Location_CD.h
//  StopCheck
//
//  Created by Jeremiah on 7/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Location_CD : NSManagedObject

@property (nonatomic, retain) NSNumber * locationId;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * reminderCount;
@property (nonatomic, retain) NSNumber * isMonitored;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * street;

@end
