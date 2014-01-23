//
//  AddRepeatWeeklyCell.m
//  StopCheck
//
//  Created by Jeremiah on 10/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import "AddRepeatWeeklyCell.h"

@implementation AddRepeatWeeklyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        repeatWeekly_label = [[UILabel alloc] initWithFrame:CGRectMake(20, 11, 126, 21)];
        [repeatWeekly_label setTextColor:[UIColor blackColor]];
        [repeatWeekly_label setText:@"Repeat Weekly"];
        [repeatWeekly_label setFont:[UIFont fontWithName:@"HelveticaNeue-light" size:18]];
        [self.contentView addSubview:repeatWeekly_label];
        
        self.repeatWeekly_switch = [UISwitch new];
        [self.repeatWeekly_switch addTarget:self action:@selector(changeShouldRepeatWeekly:) forControlEvents:UIControlEventValueChanged];
        [self.repeatWeekly_switch setOn:YES];
        [self setAccessoryView:self.repeatWeekly_switch];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)shouldRepeatWeekly
{
    return shouldRepeatWeekly;
}

- (IBAction)changeShouldRepeatWeekly:(id)sender
{
    UISwitch *s = (UISwitch *)sender;
    shouldRepeatWeekly = s.on;
}
@end
