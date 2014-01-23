//
//  ReminderActiveViewController.m
//  StopCheck
//
//  Created by Jeremiah on 21/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import "ReminderActiveViewController.h"

@interface ReminderActiveViewController ()

@end

@implementation ReminderActiveViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeBtnClicked:(id)sender
{
    UILocalNotification *notif = [[UILocalNotification alloc] init];
    [notif setAlertAction:NSLocalizedString(@"Open", nil)];
    [notif setUserInfo:@{ @"LocationId": @"0"}];
    [notif setApplicationIconBadgeNumber:0];
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notif];
}

- (LocationManager *)locationManager
{
    if(locationManager == NULL)
        locationManager = [[LocationManager alloc] init];
    
    return locationManager;
}

- (void)setLocationId:(NSString *)newLocationId
{
    locationId = newLocationId;
    [self fetchLocation];
    [self fetchReminders];
    [self loadTableArray];
}

- (void)fetchLocation
{
    location = [[self locationManager] locationOfId:locationId];
}

- (void)fetchReminders
{
    reminders = [NSMutableArray arrayWithArray:[[self locationManager]
                                                remindersOfLocation:location]];
}

- (void)setReminders:(NSMutableArray *)newReminders
{
    reminders = newReminders;
}

- (void)addReminder:(Reminder *)reminder
{
    [reminders addObject:reminder];
}

- (void)loadTableArray
{
    int ii, length = [reminders count];
    for( ii = 0; ii<length; ii++)
    {
        Reminder *currentReminder = [reminders objectAtIndex:ii];
        if(currentReminder.isTurnedOn)
        {
            NSArray *days = [currentReminder days];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC+08:00"]];
            [dateFormatter setDateFormat:@"e"];
            NSInteger today = [[dateFormatter stringFromDate:[NSDate date]] integerValue] - 1;
            
            if( [[days objectAtIndex:today] boolValue] )
               [tableArray addObjectsFromArray:[currentReminder notes]];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActiveReminderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if(cell == NULL)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    [[cell textLabel] setText:[tableArray objectAtIndex:indexPath.row]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
