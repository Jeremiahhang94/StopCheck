//
//  LocationAddRepeatViewController.m
//  StopCheck
//
//  Created by Jeremiah on 6/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import "ReminderRepeatViewController.h"

@interface ReminderRepeatViewController ()

@end

@implementation ReminderRepeatViewController


- (IBAction)saveBtnClicked:(id)sender
{
    NSLog(@"%@", self.delegate);
    [self.delegate reminderDidSave];
}

#pragma mark - reminder's Property method

- (NSArray *) days
{
    return [addDaysCell days];
}
- (BOOL) repeatWeekly
{
    return addRepeatWeeklyCell.shouldRepeatWeekly;
}
- (TriggerType) triggerType
{
    
    NSIndexPath *enterIndexPath = [NSIndexPath indexPathForItem:0 inSection:1];
    NSIndexPath *exitIndexPath = [NSIndexPath indexPathForItem:1 inSection:1];
    
    UITableViewCell *enterCell = [self.tableView cellForRowAtIndexPath:enterIndexPath];
    UITableViewCell *exitCell = [self.tableView cellForRowAtIndexPath:exitIndexPath];
    
    BOOL enterSelected = enterCell.accessoryType == UITableViewCellAccessoryCheckmark;
    BOOL exitSelected = exitCell.accessoryType == UITableViewCellAccessoryCheckmark;
    
    if(enterSelected && exitSelected)
        return kTriggerOnBoth;
    else if(enterSelected && !exitSelected)
        return kTriggerOnEnter;
    else if(exitSelected && !enterSelected)
        return kTriggerOnExit;
    else return kTriggerOnNone;
}

- (void)setReminder:(Reminder *)newReminder
{
    reminder = newReminder;
}

- (void)setCellValues
{
    [addDaysCell setSelectedDays:reminder.days];
    [[addRepeatWeeklyCell repeatWeekly_switch] sendActionsForControlEvents:UIControlEventValueChanged];
    
    
    if(reminder.triggerType != -1)
    {
        NSLog(@"Trigger Type != -1");
        int cellRow = reminder.triggerType;
        if(cellRow == 2)
        {
            NSIndexPath *enterIndexPath = [NSIndexPath indexPathForItem:0 inSection:1];
            NSIndexPath *exitIndexPath = [NSIndexPath indexPathForItem:1 inSection:1];
            
            UITableViewCell *enterCell = [self.tableView cellForRowAtIndexPath:enterIndexPath];
            UITableViewCell *exitCell = [self.tableView cellForRowAtIndexPath:exitIndexPath];
            
            enterCell.accessoryType = UITableViewCellAccessoryCheckmark;
            exitCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            NSIndexPath *enterIndexPath = [NSIndexPath indexPathForItem:cellRow inSection:1];
            UITableViewCell *enterCell = [self.tableView cellForRowAtIndexPath:enterIndexPath];
            enterCell.accessoryType = UITableViewCellAccessoryCheckmark;
            NSLog(@"%@", enterCell);
        }
        

    }
        
    
    
}

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setReminderNotes:(NSArray *)newReminderNotes
{
    reminderNotes = newReminderNotes;
}

#pragma mark - UITableViewDataSource Method

- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( section < 2)
        // section 1, days & repeat weekly
        // section 2, entering & exiting
        return 2;
    
    else return 0;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = (section == 0) ? @"Set Days" : @"Notify";
    return sectionTitle;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 36;
}

#pragma mark - UITableViewDelegate Method

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            if(addDaysCell == NULL)
                addDaysCell = [[AddDaysCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddDaysCell"];
            
            if(reminder != NULL)
                [addDaysCell setSelectedDays:reminder.days];
            else if(reminder == NULL)
            {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC+08:00"]];
                [dateFormatter setDateFormat:@"e"];
                NSInteger today = [[dateFormatter stringFromDate:[NSDate date]] integerValue] - 1;
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                int ii, length = 7;
                for(ii = 0; ii<length; ii++)
                {
                    int isToday = (today == ii) ? 1 : 0;
                    NSString *object = [NSString stringWithFormat:@"%i", isToday];
                    [array addObject:object];
                }
                
                [addDaysCell setSelectedDays:array];
            }
            
            return addDaysCell;
        }
        else if(indexPath.row == 1)
        {
            if(addRepeatWeeklyCell == NULL)
                addRepeatWeeklyCell = [[AddRepeatWeeklyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RepeatWeeklyCell"];
            
            if(reminder != NULL)
                [[addRepeatWeeklyCell repeatWeekly_switch] setOn:reminder.shouldRepeatWeekly];
            
            return addRepeatWeeklyCell;
        }
        else return nil;
    }
    else if(indexPath.section == 1)
    {
        static NSString *CellIdentifier = @"AddEnterExitCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if(cell == NULL)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        if(reminder != NULL)
        {
            if(indexPath.row == reminder.triggerType || reminder.triggerType == 2)
               [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            
        }
        
        NSString *cellTitle;
        if(indexPath.row == 0)
            cellTitle = @"Upon Entering";
        else
        {
            cellTitle = @"Upon Leaving";
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        
        [[cell textLabel] setText:cellTitle];
        
        
        return cell;
    }
    else return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if([cell accessoryType] == UITableViewCellAccessoryNone)
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        else
            [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
