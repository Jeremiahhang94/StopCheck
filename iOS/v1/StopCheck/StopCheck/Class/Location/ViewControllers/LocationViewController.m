//
//  LocationViewController.m
//  StopCheck
//
//  Created by Jeremiah on 9/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

- (Location *) location
{
    return location;
}
- (void) setLocation:(Location *)newLocation
{
    location = newLocation;
}

- (void) requestReminderComplete:(NSNotification *)notification
{
    [self hideNoReminderView];
    
    NSArray *reminders = notification.object;
    Reminder_CD *reminder_cd;
    Reminder *reminder;
    
    int ii, length = [reminders count];
    for(ii = 0; ii<length; ii++)
    {
        reminder_cd = (Reminder_CD *)[reminders objectAtIndex:ii];
        reminder = [[Reminder alloc] initWithReminder:reminder_cd];
        
        [tableArray addObject:reminder];
    }
    
    if([tableArray count] > 0)
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:Nil waitUntilDone:NO];
    else
        [self showNoReminderView];
    
}

- (void) toggleOnOffReminder:(Reminder *)reminder
{
    reminder.isTurnedOn = !reminder.isTurnedOn;
    [[self locationManager] updateReminder:reminder];
}

- (void)showNoReminderView
{
    if(noReminder_view == NULL)
    {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewReminderBtnPressed:)];
        
        noReminder_view = [[UIView alloc] initWithFrame:self.view.bounds];
        [noReminder_view setBackgroundColor:[UIColor whiteColor]];
        [noReminder_view addGestureRecognizer:tapGesture];
        
        CGFloat center = (noReminder_view.frame.size.height - 200) * 0.5;
        
        noReminder_label = [[UILabel alloc] initWithFrame:CGRectMake(0, center, self.view.bounds.size.width, 100)];
        [noReminder_label setBackgroundColor:[UIColor clearColor]];
        [noReminder_label setText:@"No Reminder \n \n Tap to add Reminder"];
        [noReminder_label setTextAlignment:NSTextAlignmentCenter];
        [noReminder_label setNumberOfLines:0];
        [noReminder_label setLineBreakMode:NSLineBreakByWordWrapping];
        [noReminder_label setTextColor:[UIColor blackColor]];
        [noReminder_label setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:22]];
    
        [noReminder_view addSubview:noReminder_label];

    }
    
    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationItem setLeftBarButtonItem:self.mapBtn animated:YES];
    [self.view addSubview:noReminder_view];

}
- (void)hideNoReminderView
{
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if(noReminder_view != NULL)
        [noReminder_view removeFromSuperview];
}

#pragma mark - IBActions



- (IBAction)addNewReminderBtnPressed:(id)sender
{
    [NotificationCenter requestForLocationAddViewControllerWithLocation:location];
}

- (IBAction)rightBarBtnPressed:(id)sender
{
    /*
     if(YES)
    {
        NSArray *reminders = [[self locationManager] reminderNotesOfLocation:[NSString stringWithFormat:@"%i", location.locationId] UponEntering:YES];
        
        NSLog(@"%@", reminders);
        
        [LocationManager scheldueLocalNotificationWithReminders:reminders LocationId:[NSString stringWithFormat:@"%i", location.locationId]];
    }
    else
     */
    if([self.tableView isEditing])
    {
        NSLog(@"Is Editing");
        [self.tableView setEditing:NO animated:YES];
        [self.navigationItem setLeftBarButtonItem:self.mapBtn animated:YES];
        [self setEditing:NO];
    }
    else
    {
        if(self.addNewReminderBtn == NULL)
        {
            self.addNewReminderBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewReminderBtnPressed:)];
        }
        
        [self.tableView setEditing:YES animated:YES];
        [self.navigationItem setLeftBarButtonItem:self.addNewReminderBtn animated:YES];
        [self setEditing:YES];
    }
}

- (IBAction)mapBtnPressed:(id)sender
{
    [NotificationCenter requestForMapViewControllerWithLocation:location];
}

- (IBAction)reminderSwitchChanged:(id)sender
{
    UISwitch *reminderSwitch = (UISwitch *)sender;
    Reminder *reminder = [tableArray objectAtIndex:reminderSwitch.tag];
    
    [self toggleOnOffReminder:reminder];
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
    static NSString *CellIdentifier = @"Cell";
    ReminderCell *cell = (ReminderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Reminder *reminder = [tableArray objectAtIndex:indexPath.row];
    
    
    // Configure the cell...
    if(cell == NULL)
    {
        cell = [[ReminderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    [cell setNotes:[reminder noteString]];
    [cell setDays:[reminder days]];
    [cell setIsTurnedOn:[reminder isTurnedOn]];
    
    [[cell turnedOn_switch] setTag:indexPath.row];
    [[cell turnedOn_switch] addTarget:self action:@selector(reminderSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    
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

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        Reminder *reminder = [tableArray objectAtIndex:indexPath.row];
        if([[self locationManager] removeReminder:reminder FromLocation:location])
        {
            NSLog(@"Deleted");
            
            [tableArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            if([tableArray count] <= 0)
                [self showNoReminderView];
        }
        
        
        
        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.editing)
    {
        Reminder *reminder = [tableArray objectAtIndex:indexPath.row];
        NSDictionary *object = @{ @"Location":location, @"Reminder":reminder };
        [NotificationCenter requestForLocationUpdateViewControllerWithLocation:object];
    }
    
}


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

#pragma mark - View lifecycle

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
    self.navigationItem.RightBarButtonItem = self.editButtonItem;
    [self.editButtonItem setTarget:self];
    [self.editButtonItem setAction:@selector(rightBarBtnPressed:)];
    
    tableArray = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestReminderComplete:) name:REQUEST_REMINDER_NOTIFICATION object:nil];
    [[self locationManager] remindersOfLocation:location Notification:REQUEST_REMINDER_NOTIFICATION];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Location Manager

- (void)setLocationManager:(LocationManager *)newlocationManager
{
    locationManager = newlocationManager;
}

- (LocationManager *)locationManager
{
    if(locationManager == NULL)
        locationManager = [[LocationManager alloc] init];
    
    return locationManager;
}

@end
