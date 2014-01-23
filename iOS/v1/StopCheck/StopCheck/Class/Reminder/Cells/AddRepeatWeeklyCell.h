//
//  AddRepeatWeeklyCell.h
//  StopCheck
//
//  Created by Jeremiah on 10/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddRepeatWeeklyCell : UITableViewCell
{
    BOOL shouldRepeatWeekly;
    UILabel *repeatWeekly_label;
}

- (BOOL)shouldRepeatWeekly;

- (IBAction)changeShouldRepeatWeekly:(id)sender;

@property (strong, nonatomic) IBOutlet UISwitch *repeatWeekly_switch;

@end
