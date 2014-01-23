//
//  DatabaseFactory.h
//  StopCheck
//
//  Created by Jeremiah on 7/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

typedef void (^Completion)(id object);

@interface DatabaseFactory : NSObject
{
    NSManagedObjectContext *managedObjectContext;
}


@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (NSManagedObjectContext *) managedObjectContext;

#pragma mark - Reminders
- (void)insertReminder:(Reminder *)reminder toLocation:(Location **)location;

- (NSArray *)queryRemindersOfLocation:(int)locationId;
- (void)queryRemindersOfLocation:(int)locationId Notification:(NSString *)notification;

- (Reminder_CD *)queryReminder:(int)reminderId;
- (BOOL)deleteReminder:(Reminder *)reminder FromLocation:(Location **)location;
- (BOOL)updateReminder:(Reminder *)reminder;
- (void)updateReminder:(Reminder *)reminder Notification:(NSString *)notification;

#pragma mark - Locations
- (NSArray *)queryAllMonitoredLocations;
- (Location *)queryLocationOfId:(int)locationId;
- (NSArray *)queryLocationWithSearchQuery:(NSString *)search;

- (NSInteger)insertLocation:(Location *)location;
- (void)insertLocation:(Location *)location Complete:( Completion )complete;

- (void)updateLocation:(Location *)location Notification:(NSString *)notification;
- (BOOL)updateLocation:(Location *)location;

- (BOOL)reminderCountOfLocation:(Location *)location ShouldIncerement:(BOOL)shouldIncrement;
- (BOOL)location:(Location *)location ShouldMonitor:(BOOL)shouldMonitor;

- (BOOL)deleteLocation:(Location *)location;

#pragma mark - General Functions
- (NSArray *)performFetchRequestForEntityForName:(NSString *)entityName Predicate:(NSString *)predicate;

@end
