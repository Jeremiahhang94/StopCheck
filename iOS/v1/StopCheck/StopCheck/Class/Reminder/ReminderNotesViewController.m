//
//  LocationAddNotesViewController.m
//  StopCheck
//
//  Created by Jeremiah on 6/1/14.
//  Copyright (c) 2014 Jeremiah. All rights reserved.
//

#import "ReminderNotesViewController.h"

@interface ReminderNotesViewController ()

@end

#pragma mark - Helper Categories

@interface UITextField (ChangeReturnKey)
- (void)changeReturnKey:(UIReturnKeyType)returnKeyType;
@end

@implementation UITextField (ChangeReturnKey)
- (void)changeReturnKey:(UIReturnKeyType)returnKeyType
{
    self.returnKeyType = returnKeyType;
    [self reloadInputViews];
}

@end


@implementation ReminderNotesViewController

//Hinting of text field
static NSString *inactiveTextFieldHint = @"Tap to add item";
static NSString *activeTextFieldHint = @"";
static NSString *returnTappedTextFieldHint = @"~"; // HACK to mark when return was tapped

#pragma mark - Shermann's Code

//Contents assigning

- (NSArray *)contents
{
    return rowsContent;
}

- (void)setContents:(NSArray *)contents
{
    rowsContent = [NSMutableArray arrayWithArray:contents];
    [self.tableView reloadData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//Changes in Table

- (void)deleteRow:(NSIndexPath *)indexPath ///Delete of cell
{
    [rowsContent removeObjectAtIndex:indexPath.row];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    [self contentsDidChange];
}

- (void)addRow:(NSIndexPath *)indexPath text:(NSString *)text //Adding of New Cell
{
    if (rowsContent == nil) {
        rowsContent = [[NSMutableArray alloc] initWithCapacity:1];
    }
    [rowsContent addObject:text];
    NSIndexPath *nextRow = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:nextRow] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    [self contentsDidChange];
}

- (void)contentsDidChange
{
}

//Setting text field details for cell
- (UITextField *)createTextFieldForCell:(UITableViewCell *)cell
{
    CGFloat padding = 20.0f;
    CGRect frame = CGRectInset(cell.contentView.bounds, padding, padding / 2);
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    CGFloat spareHeight = cell.contentView.bounds.size.height - textField.font.pointSize;
    frame.origin.y = self.tableView.style == UITableViewStyleGrouped ? spareHeight / 2 : spareHeight - padding/2;
    textField.frame = frame;
    textField.tag = TAG_TEXT_FIELD;
    textField.borderStyle = UITextBorderStyleNone;
    textField.returnKeyType = UIReturnKeyDone;
    textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    textField.tintColor = [UIColor blueColor];
    return textField;
}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return rowsContent.count + 1; // extra one for inserting new row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.tableView.editing =YES;
    static NSString *reuseIdentifier = CELL_REUSE_IDENTIFIER;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    UITextField *textField = (UITextField *)[cell viewWithTag:TAG_TEXT_FIELD];
    if (textField == nil) {
        textField = [self createTextFieldForCell:cell];
        [cell.contentView addSubview:textField];
    }
    
    textField.delegate = self;
    if (indexPath.row < rowsContent.count) {
        textField.text = [rowsContent objectAtIndex:indexPath.row];
        textField.placeholder = nil;
    } else {
        textField.text = nil;
        textField.placeholder = NSLocalizedString(inactiveTextFieldHint, nil);
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (editingStyle) {
            
        case UITableViewCellEditingStyleDelete: {
            [self deleteRow:indexPath];
            break;
        }
            
        case UITableViewCellEditingStyleInsert: {
            UITableViewCell *sourceCell = [tableView cellForRowAtIndexPath:indexPath];
            UIView *textField = [sourceCell viewWithTag:TAG_TEXT_FIELD];
            [textField becomeFirstResponder];
            break;
        }
            
        case UITableViewCellEditingStyleNone:
            break;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section == 0);
}

#pragma mark - UITableViewDelegate Method

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) return UITableViewCellEditingStyleNone;
    return indexPath.row < rowsContent.count ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleInsert;
}


- (NSIndexPath *)tableView:(UITableView *)tableView
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    return proposedDestinationIndexPath.section == 0 && proposedDestinationIndexPath.row < rowsContent.count
    ? proposedDestinationIndexPath
    : [NSIndexPath indexPathForRow:rowsContent.count-1 inSection:0];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITextFieldDelegate

- (NSIndexPath *)cellIndexPathForField:(UITextField *)textField
{
    UIView *view = textField;
    while (![view isKindOfClass:[UITableViewCell class]]) {
        view = [view superview];
    }
    return [self.tableView indexPathForCell:(UITableViewCell *)view];
}

- (NSUInteger)rowIndexForField:(UITextField *)textField
{
    return [self cellIndexPathForField:textField].row;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField.text length] == 0) {
        textField.placeholder = NSLocalizedString(activeTextFieldHint, nil);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    textField.placeholder = returnTappedTextFieldHint;
	[textField resignFirstResponder];
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length == 0) {
        // if it's the last field, change the return key to "Next"
        if ([self rowIndexForField:textField] == rowsContent.count) {
            [textField changeReturnKey:UIReturnKeyNext];
        }
    }
    else {
        // if return button is "Next" and field is about to be empty, change to "Done"
        if (textField.returnKeyType == UIReturnKeyNext && string.length == 0 && range.length == textField.text.length) {
            [textField changeReturnKey:UIReturnKeyDone];
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyNext) {
        [textField changeReturnKey:UIReturnKeyDone];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSIndexPath *currRow = [self cellIndexPathForField:textField];
    NSUInteger cellIndex = currRow.row;
    if (cellIndex < rowsContent.count) {
        if ([textField.text length]) {
            if (![textField.text isEqualToString:[rowsContent objectAtIndex:cellIndex]]) {
                [rowsContent replaceObjectAtIndex:cellIndex withObject:textField.text];
                [self contentsDidChange];
            }
        }
        else {
            [self deleteRow:currRow];
        }
    }
    else { // new row
        if ([textField.text length]) {
            [self addRow:currRow text:textField.text];
            [textField changeReturnKey:UIReturnKeyDone];
            if ([textField.placeholder isEqual:returnTappedTextFieldHint]) {
                // if tapped return, go to the next field
                UITableViewCell *nextCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:cellIndex+1 inSection:currRow.section]];
                UIView *nextTextField = [nextCell viewWithTag:TAG_TEXT_FIELD];
                [nextTextField becomeFirstResponder];
            }
        }
        else {
            textField.placeholder = NSLocalizedString(inactiveTextFieldHint, nil);
        }
    }
}



//View's Life cycle

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddRepeatSegue"])
    {
        [self.view endEditing:YES];
        [segue.destinationViewController setDelegate:self.delegate];
        [segue.destinationViewController setReminderNotes:rowsContent];
        self.repeatViewController = segue.destinationViewController;
        
        if(reminder != NULL)
        {
            [self.repeatViewController setReminder:reminder];
        }
        
    }
}

- (NSArray *)notes
{
    return [self contents];
}

- (void)setReminder:(Reminder *)newReminder
{
    reminder = newReminder;
    NSMutableArray *notes = [NSMutableArray arrayWithArray:reminder.notes];
    [notes removeLastObject];
    
    [self setContents:notes];
}
@end
