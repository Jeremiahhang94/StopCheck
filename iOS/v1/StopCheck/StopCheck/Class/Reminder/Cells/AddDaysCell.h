//
//  AddDaysCell.h
//  StopCheck
//
//  Created by Jeremiah on 10/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddDaysCell : UITableViewCell
{
    NSMutableArray *days;
    NSArray *selectedDays;
    NSArray *daysArray;
}

- (NSArray *)days;
- (IBAction)selectDay:(id)sender;

- (void)printDays;
- (void)setSelectedDays:(NSArray *)newSelectedDays;
@end
