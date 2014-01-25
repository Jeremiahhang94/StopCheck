/*
 * Created: 24 Jan 2014
 * Author: Jeremiah
 * 
 * Purpose: The activity that would display an editable table for users
 * 			to add or remove notes to a new reminder
 */
public class ReminderNotesActivity extends LocationReminderActivity {

	private String[] notes;

	public ReminderNotesActivity() {

	}

	public void addNote() {
		// Add a note onto the notes array
		// and draws a new cell for user to add the next note

	}

	public void drawCell() {
		// draws a new cell onto the view
	}

	public void removeNote() {
		// Remove a note from the notes array
		// and delete the cell
	}

	public void destroyCell() {
		// remove a cell from the view
	}

	public String notesString() {
		// return all the notes in a string
		// return "No Notes" if there is no notes
		return notes[0];
	}

	public void startRepeatActivity() {
		// start ReminderRepeatActivity activity with the notesString
		// reminderId = 0 and locationId;
	}

}
