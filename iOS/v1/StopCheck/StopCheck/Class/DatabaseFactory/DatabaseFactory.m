//
//  DatabaseFactory.m
//  StopCheck
//
//  Created by Jeremiah on 7/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import "DatabaseFactory.h"

@implementation DatabaseFactory

@synthesize

managedObjectContext = _managedObjectContext,
managedObjectModel = _managedObjectModel,
persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Reminders

/*
 
    Creates a new Reminder_CoreData entity from a managedObjectContext according to the given Reminder Object
 
    Upon completion, the notification is then passed on back to LocationManager to handle the completition task.
 
 */
- (void)insertReminder:(Reminder *)reminder
            toLocation:(Location **)location
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC+08:00"]];
    [dateFormatter setDateFormat:@"hhmmss"];
    NSInteger date = [[dateFormatter stringFromDate:[NSDate date]] integerValue];
    
    Reminder_CD *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Reminder_CoreData" inManagedObjectContext:[self managedObjectContext]];
    newEntry.reminderId = [NSNumber numberWithInteger:date];
    newEntry.locationId = [NSNumber numberWithInteger:reminder.locationId];
    newEntry.notes = [reminder noteString];
    newEntry.days = [reminder daysString];
    newEntry.shouldRepeatWeekly = [NSNumber numberWithBool:reminder.shouldRepeatWeekly];
    newEntry.triggerType = [NSNumber numberWithInt:reminder.triggerType];
    newEntry.startDate = [reminder startDate];
    newEntry.isTurnedOn = [NSNumber numberWithBool:YES];
    
    NSError *error;
    if([[self managedObjectContext] save:&error]) //[managedObjectContext save:&error]
    {
        
        //fetch location
        Location *newLocation = [self queryLocationOfId:reminder.locationId];
        
        //update location reminder count
        if([self reminderCountOfLocation:newLocation ShouldIncerement:YES])
        {
            *location = newLocation;
        }
        
    }
    else
    {
        NSLog(@"Save Failed");
    }
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:notification object:addSuccessful];
    
}

/*
    
    Retrieves Reminders object of given locationId.
 
    Upon completition, a notification of given notifcation name will be posted.
 
 */
- (NSArray *)queryRemindersOfLocation:(int)locationId
{
    
    NSString *predicate = [NSString stringWithFormat:@"locationId == %i", locationId];
    NSArray *reminders = [self performFetchRequestForEntityForName:@"Reminder_CoreData" Predicate:predicate];
    
    return reminders;
}

- (void)queryRemindersOfLocation:(int)locationId Notification:(NSString *)notification
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:[self queryRemindersOfLocation:locationId]];
}

/*
    
    Retrieves a single reminder of given reminderId.
 
    the Reminder_CD object is then retured.
 
 */
- (Reminder_CD *)queryReminder:(int)reminderId
{
    NSString *predicate = [NSString stringWithFormat:@"reminderId == %i", reminderId];
    NSArray *result = [self performFetchRequestForEntityForName:@"Reminder_CoreData" Predicate:predicate];
    Reminder_CD *reminderCd = (Reminder_CD *)[result objectAtIndex:0];
    
    return reminderCd;
}

/*
 
    Removes a single reminder from the database
 
    Returns true if it is successfully removed, else returns false.
 
 */
- (BOOL)deleteReminder:(Reminder *)reminder FromLocation:(Location **)location
{
    Reminder_CD *reminderCd = [self queryReminder:reminder.reminderId];
    NSManagedObjectContext *context = [self managedObjectContext];
    
    [context deleteObject:reminderCd];
    NSError *error = nil;
    
    if([context save:&error])
    {
        
        if([self reminderCountOfLocation:*location ShouldIncerement:NO])
        {
            Location *toReturn = [self queryLocationOfId:[*location locationId]];
            *location = toReturn;
            
            return YES;
        }
        else return NO;
    }
    else return NO;
}

/*
 
    update a single reminder of given Reminder Object
    It first fetch the Reminder_CD object from the database, match the values with given Reminder Object and then saved. 
    If update was successful, returns true, else returns false.
 
 */
- (BOOL)updateReminder:(Reminder *)reminder
{
    NSError *error;
    NSArray *array = [self performFetchRequestForEntityForName:@"Reminder_CoreData" Predicate:[NSString stringWithFormat:@"reminderId == %i", reminder.reminderId]];
    
    Reminder_CD *reminderCD = (Reminder_CD *)[array objectAtIndex:0];
    
    reminderCD.notes = reminder.noteString;
    reminderCD.days = reminder.daysString;
    reminderCD.shouldRepeatWeekly = [NSNumber numberWithBool:reminder.shouldRepeatWeekly];
    reminderCD.triggerType = [NSNumber numberWithInt:reminder.triggerType];
    reminderCD.isTurnedOn = [NSNumber numberWithBool:reminder.isTurnedOn];
    
    if([[self managedObjectContext] save:&error])
        return YES;
    else
        return NO;
}
- (void)updateReminder:(Reminder *)reminder Notification:(NSString *)notification
{
    
    NSNumber *success = [NSNumber numberWithBool:[self updateReminder:reminder]];
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:success];
    
}

#pragma mark - Locations

/*
    
    Fetch all the location that are currently being monitored. 
 
    A notification with the monitored locations is then posted to be handled.
 
 */
- (NSArray *)queryAllMonitoredLocations
{
    
    NSArray *monitoredRegion = [self
                                performFetchRequestForEntityForName:@"Location_CoreData"
                                Predicate:@"isMonitored == YES"];
    
    return monitoredRegion;
}

/*
    Fetch a list of location such that their title contains the search query. 
 
    An array of the list is then returned.
 */
- (NSArray *)queryLocationWithSearchQuery:(NSString *)search
{
    NSArray *locations = [[NSArray alloc] init];
    
    NSString *predicate = [NSString stringWithFormat:@"(name CONTAINS '%@' || street CONTAINS '%@') && isMonitored == YES", search, search];
    locations = [self performFetchRequestForEntityForName:@"Location_CoreData" Predicate:predicate];
    
    return locations;
}

/*
    
    Insert a new Location_CD object based on the given Location object.
 
    if successfully inserted into the database, it's locationID is then being returned.
 
 */
- (NSInteger)insertLocation:(Location *)location
{
    
    Location_CD *newEntry = (Location_CD *)[NSEntityDescription insertNewObjectForEntityForName:@"Location_CoreData" inManagedObjectContext:[self managedObjectContext]];
    
    NSInteger newId = ceil(location.coordinate.longitude * 10000 + location.coordinate.latitude * 10000);
    
    newEntry.locationId = [NSNumber numberWithInteger:newId];
    newEntry.name = location.name;
    newEntry.street = location.street;
    newEntry.startDate = location.startDate;
    newEntry.reminderCount = 0;
    newEntry.isMonitored = [NSNumber numberWithBool:NO];
    newEntry.latitude = [NSNumber numberWithDouble:location.coordinate.latitude];
    newEntry.longitude = [NSNumber numberWithDouble:location.coordinate.longitude];
    
    NSError *error = [[NSError alloc] init];
    if([[self managedObjectContext] save:&error])
        return newId;
    else
    {
        NSLog(@"error: %@", error);
        return 0;
    }
    
}

/*
 
    Insertion of location with a Completion handler. 
 
    Used for Multi-processing steps
 
 */
- (void)insertLocation:(Location *)location Complete:(Completion)complete
{
    if([self insertLocation:location])
        complete(location);
}

/*
 
    Fetches a Location object based on the given locationId
 
 */
- (Location *)queryLocationOfId:(int)locationId
{
    
    NSString *predicate = [NSString stringWithFormat:@"locationId == %i", locationId];
    NSArray *result = [self
                       performFetchRequestForEntityForName:@"Location_CoreData"
                       Predicate:predicate];
    
    Location_CD *locationCD = (Location_CD *)[result objectAtIndex:0];
    
    Location *location = [[Location alloc] initWithLocation:locationCD];
    
    return location;
}

/*
 
    Updates location and if successful post a notification with update result.
 
    Used for multi-processing
 
 */
- (void)updateLocation:(Location *)location Notification:(NSString *)notification
{
    NSNumber *success = [NSNumber numberWithBool:[self updateLocation:location]];
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:success];
}

/*
 
    Updates a location based on the given Location object.
 
    The Location_CoreData object is fetched based on the locationId and the values are matched with the Location object
 
    Returns true if it is successfully updated, else returns false.
 
 */
- (BOOL)updateLocation:(Location *)location
{
    NSError *error;
    NSArray *array = [self performFetchRequestForEntityForName:@"Location_CoreData" Predicate:[NSString stringWithFormat:@"locationId == %i", location.locationId]];
    
    Location_CD *locationCD = (Location_CD *)[array objectAtIndex:0];
    
    locationCD.reminderCount = [NSNumber numberWithInteger:location.reminderCount];
    locationCD.isMonitored = [NSNumber numberWithBool:location.isMonitored];
    
    NSLog(@"Is Monitored: %@, Reminder Count: %@", locationCD.isMonitored, locationCD.reminderCount);
    
    if([[self managedObjectContext] save:&error])
        return YES;
    else
        return NO;
}

/*
 
    Increments or Decrements a location's reminder count.
 
    Increments if shouldIncrement else Decrement
 
    if the reminderCount started with zero and is now more than zero, the location will begin being monitored. 
    Or if the location became zero, it will cease to be monitored. 
 
    if updating is successful, return true, else return false.
 
 */
- (BOOL)reminderCountOfLocation:(Location *)location ShouldIncerement:(BOOL)shouldIncrement
{
    BOOL startWithZero = location.reminderCount == 0;
    
    if(shouldIncrement)
        location.reminderCount += 1;
    else
        location.reminderCount -= 1;
    
    if(location.reminderCount <= 0)
        //stop monitoring
        return [self location:location ShouldMonitor:NO];
    else if(location.reminderCount == 1 && startWithZero)
        //start monitoring
        return [self location:location ShouldMonitor:YES];
    else return [self updateLocation:location];
}

/*
 
    Start or stop monitoring a location
 
    Returns true if it is successfully updated, else returns false.
 
 */
- (BOOL)location:(Location *)location ShouldMonitor:(BOOL)shouldMonitor
{
    if(shouldMonitor)
        location.isMonitored = YES;
    else
        location.isMonitored = NO;
    
    if([self updateLocation:location])
        return YES;
    else return NO;
}

/*

    Deletes all reminders of location based on the given location If successfully deleted all reminders, continue to delete the location
 
    returns true if successfully removed, else return false
 
 */
- (BOOL)deleteLocation:(Location *)location
{
    //fetch all reminders of location
    NSArray *allReminders = [self queryRemindersOfLocation:location.locationId];
    
    //delete them one by one
    int ii, length = allReminders.count;
    Reminder_CD *reminder;
    for(ii = 0; ii<length; ii++)
    {
        reminder = (Reminder_CD *)[allReminders objectAtIndex:ii];
        [[self managedObjectContext] deleteObject:reminder];
    }

    //request for locationCD object
    NSArray *array = [self performFetchRequestForEntityForName:@"Location_CoreData" Predicate:[NSString stringWithFormat:@"locationId == %i", location.locationId]];
    Location_CD *locationCD = (Location_CD *)[array objectAtIndex:0];
    
    //delete locationCD
    [[self managedObjectContext] deleteObject:locationCD];
    
    NSError *error = nil;
    if([[self managedObjectContext] save:&error])
    {
        return YES;
    }
    else return NO;
    
}

#pragma mark - General Functions


/*
 
    Executes the "SQL Statement" of given EntityName and Predicates.
 
 */
- (NSArray *)performFetchRequestForEntityForName:(NSString *)entityName Predicate:(NSString *)predicate
{
    NSEntityDescription *newEntry = [NSEntityDescription
                                     entityForName:entityName
                                     inManagedObjectContext:[self managedObjectContext]];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:(NSEntityDescription *)newEntry];
    
    // predicate
    NSPredicate *p = [NSPredicate predicateWithFormat:predicate];
    
    [request setPredicate:p];
    
    NSError *error;
    NSArray *array = [[self managedObjectContext] executeFetchRequest:request error:&error];
    if (array == nil)
    {
        // Deal with error...
        NSLog(@"Empty");
        return nil;
    }
    else return array;
}


#pragma mark - Core Data Methods

// 1
- (NSManagedObjectContext *) managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return _managedObjectContext;
}

//2
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

//3
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"StopCheck.sqlite"]];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil URL:storeUrl options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


@end
