package com.stopcheck.activities;

/*
 * Created: 24 Jan 2014
 * Author: Jeremiah
 * 
 * Purpose: The activity that would display all the reminder of a given location
 */

import android.os.Bundle;
import android.view.Menu;
import android.view.View;

import com.example.stopcheck.R;
import com.stopcheck.classes.Reminder;

public class LocationActivity extends LocationReminderActivity {

	private Reminder[] allReminders;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_location);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.location, menu);
		return true;
	}
	
	@Override
	public void onBackPressed()
	{
		super.onBackPressed();
		this.startActivityOfClass(MapActivity.class);
		finish();
	}
	
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

	public void reminderSelected(View v) {
		// present UpdateReminderNotesActivity activity,
		// with reminderId and locationid
		// for the user to edit the selected reminder
		
		this.startActivityOfClass(UpdateReminderNotesActivity.class);
		
	}

	public void addReminderBtnPressed(View v) {
		// Button listener for addReminderBtn
		// presents ReminderNotesActivity with reminderId of 0 and
		// the locationId, for the user to add a reminder
		
		this.startActivityOfClass(ReminderNotesActivity.class);
		
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
