//
//  ReminderCell.m
//  StopCheck
//
//  Created by Jeremiah on 13/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import "ReminderCell.h"

@implementation ReminderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectDay:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    UIFont *font;
    UIColor *color;
    NSUInteger tag;
    
    if(btn.tag == 0)
    {
        font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        color = [UIColor redColor];
        tag = 1;
    }
    else
    {
        font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:12];
        color = [UIColor blackColor];
        tag = 0;
    }
    
    [[btn titleLabel] setFont:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTag:tag];
}

- (void) setNotes:(NSString *)notes
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 14, 212, 21)];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:17]];
    [label setTextColor:[UIColor blackColor]];
    
    if(notes.length >= 4)
        notes = [notes substringToIndex:(notes.length - 4)];
    else
        notes = @"No Notes";
    
    [label setText:notes];
    [self.contentView addSubview: label];
    
}

- (void) setDays:(NSArray *)days
{
    //draw the days that are activated
    int ii = 0, noOfDays = 7, xIncrement = 25;
    daysArray = @[@"S",@"M",@"T",@"W",@"T",@"F",@"S"];
    
    CGRect frame = CGRectMake(20, 37, 17, 21);
    for(ii = 0; ii<noOfDays; ii++)
    {
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:frame];
        [dayLabel setText:[daysArray objectAtIndex:ii]];
        
        UIFont *font;
        UIColor *fontColor;
        if([[days objectAtIndex:ii] boolValue])
        {
            fontColor = [UIColor redColor];
            font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        }
        else
        {
            fontColor = [UIColor blackColor];
            font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:12];
        }
        
        
        
        [dayLabel setFont:font];
        [dayLabel setTextColor:fontColor];
        [self.contentView addSubview:dayLabel];
        
        frame.origin.x += xIncrement;
    }
}

- (void)setIsTurnedOn:(BOOL)turnOn
{
    isTurnedOn = turnOn;
    self.turnedOn_switch = [[UISwitch alloc] init];
    [self.turnedOn_switch setOn:isTurnedOn];
    [self setAccessoryView:self.turnedOn_switch];
}
@end
