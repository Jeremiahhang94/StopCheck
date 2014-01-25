/*
 * Created: 24 Jan 2014
 * Author: Jeremiah
 * 
 * Purpose: The activity that would display all the reminder of a given location
 */
public class LocationActivity extends LocationReminderActivity {

	private Reminder[] allReminders;
	
	
	/**
	 * @category getter
	 * @return the allReminders
	 */
	public Reminder[] getAllReminders() {
		return allReminders;
	}

	/**
	 * @category setter
	 * @param allReminders the allReminders to set
	 */
	public void setAllReminders(Reminder[] allReminders) {
		this.allReminders = allReminders;
	}

	public LocationActivity() {
		System.out.println("Lets go!");
	}

	public void setAllReminder() {
		// Request from location manager all the reminders
		// attached to this location,
		// upon completion, prints out all the reminder
		
		Reminder[] reminders = this.locationManager.remindersOfLocationId(this.locationId); 
		this.allReminders = reminders;
		this.presentAllReminder();
		
	}

	public void presentAllReminder() {
		// Prints out all the reminder
		// that this location have
		// prints "No reminder" if there isnt any.
		
		System.out.println(this.allReminders);
		
	}

	public void reminderSelected() {
		// present UpdateReminderNotesActivity activity,
		// with reminderId and locationid
		// for the user to edit the selected reminder
	}

	public void addReminderBtnPressed() {
		// Button listener for addReminderBtn
		// presents ReminderNotesActivity with reminderId of 0 and
		// the locationId, for the user to add a reminder
	}

	public void editBtnPressed() {
		// Button listener for editBtn
		// Brings the view into edit mode
	}

	public void reminderDeleteBtnPress() {
		// Button listener for deleteBtn
		// deletes the reminder from the database
		// if deleted successfully, remove the cell
		// from the view.

	}

	public void enterEditMode() {
		// display red "-" sign on the left
		// and ">" sign on the right
	}

	public void sendReminderToDelete(Reminder reminder) {
		// sends the reminder to the database to be
		// deleted.
		
		boolean deleted = this.locationManager.deleteReminder(reminder);
		if(deleted)
			this.removeReminderCell();
		
	}

	public void removeReminderCell() {
		// remove the cell from the view
	}

}
