//
//  AddDaysCell.m
//  StopCheck
//
//  Created by Jeremiah on 10/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import "AddDaysCell.h"

@implementation AddDaysCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        daysArray = @[@"S",@"M",@"T",@"W",@"T",@"F",@"S"];
        [self printDays];
        
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSArray *)days
{
    NSMutableArray *toReturn = [[NSMutableArray alloc] init];
    int ii, length = [days count];
    UIButton *btn;
    
    for(ii = 0; ii<length; ii++)
    {
        btn = (UIButton *)[days objectAtIndex:ii];
        [toReturn addObject: [NSString stringWithFormat:@"%i", btn.tag]];
    }
    
    return toReturn;
}

- (IBAction)selectDay:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    UIColor *color;
    UIFont *font;
    NSUInteger tag;
    
    if(btn.tag == 0)
    {
        font = [UIFont fontWithName:@"HelveticaNeue" size:30];
        color =  [UIColor redColor];
        tag = 1;
    }
    else
    {
        font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
        color =  [UIColor blackColor];
        tag = 0;
    }
    
    [[btn titleLabel] setFont:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTag: tag];
}

- (void)printDays
{
    days = [[NSMutableArray alloc] init];
    
    int ii = 0, noOfDays = 7, xIncrement = 42;
    CGRect frame = CGRectMake(20, 7, 30, 30);
    for(ii = 0; ii<noOfDays; ii++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 0;
        [btn setTitle:[daysArray objectAtIndex:ii] forState:UIControlStateNormal];
        [btn setFrame:frame];
        [[btn titleLabel] setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:30]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectDay:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:btn];
        [days addObject:btn];
        
        frame.origin.x += xIncrement;
    }
}

- (void)setSelectedDays:(NSArray *)newSelectedDays
{
    
    selectedDays = newSelectedDays;
    
    int ii, noOfDays = 7;
    for( ii = 0; ii<noOfDays; ii++)
    {
        if( [[newSelectedDays objectAtIndex:ii] boolValue] )
        {
            UIButton *btn = [days objectAtIndex:ii];
            [btn sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }
    
}
@end
