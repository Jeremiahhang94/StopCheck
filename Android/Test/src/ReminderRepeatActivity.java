/*
 * Created: 24 Jan 2014
 * Author: Jeremiah
 * 
 * Purpose: The activity that would display repeat options
 * such as the days that it would be triggered
 * whether it should be triggered every week and 
 * when it would be triggered of a new reminder
 * 
 */
public class ReminderRepeatActivity extends LocationReminderActivity {

	private String[] notes;
	private boolean shouldRepeatWeekly;
	private int[] days;

	// private Button[] daysButtons;
	public ReminderRepeatActivity() {
		System.out.println(notes[0] + shouldRepeatWeekly + days[0]);
	}

	public void saveReminder() {
		// sends the Reminder object to locationManager
		// to be saved newly into the database
	}

	public void printDays() {
		/*
		 * loads the selected days, highlight today
		 */
	}

	public void daysBtnPress() {
		/*
		 * Triggered when a day button is pressed, either "select or "deselect"
		 * a button, a "selected" button would be bolded and red while an
		 * "unselected" button is thin and black
		 */
	}

	public void updateDaysWithValue() {
		/*
		 * Receives the day and its value to be updated to
		 */
	}

}
