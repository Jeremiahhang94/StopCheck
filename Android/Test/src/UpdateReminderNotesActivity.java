/*
 * Created: 24 Jan 2014
 * Author: Jeremiah
 * 
 * Purpose: The activity that would allow user to update
 * 			notes of an existing reminder
 */

public class UpdateReminderNotesActivity extends ReminderNotesActivity {

	public UpdateReminderNotesActivity() {

	}

	public void fetchAllNotesOfReminder() {
		// set all the notes this reminder have
		
		String[] notes = this.reminder.notes;
		this.setNotes(notes);
		
		
	}

	@Override
	public void startRepeatActivity() {
		// start UpdateReminderRepeatActivity activity with the
		// notesString, days array, shouldRepeatWeekly boolean, reminderId and
		// locationId
	}

}
