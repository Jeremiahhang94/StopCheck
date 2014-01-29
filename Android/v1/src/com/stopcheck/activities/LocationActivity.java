package com.stopcheck.activities;

/*
 * Created: 24 Jan 2014
 * Author: Jeremiah
 * 
 * Purpose: The activity that would display all the reminder of a given location
 */

import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import com.example.stopcheck.R;
import com.stopcheck.classes.Reminder;

public class LocationActivity extends LocationReminderActivity {

	public static final String KEY_LOCATION = "keyLocation";
	
	private Reminder[] allReminders;
	private ListView listView;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_location);
		
		//get and set location id
		Intent intent = this.getIntent();
		retrieveLocationid(intent);
		
		//set up listview
		this.initListView();
		
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
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item)
	{
		switch(item.getItemId())
		{
		case R.id.action_add:
			this.addReminderBtnPressed();
			return true;
		default:
			return super.onOptionsItemSelected(item);
		}
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
		this.reloadList();
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

	public void addReminderBtnPressed() {
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
	
	public void reloadList()
	{
		
	}
	
	public void retrieveLocationid(Intent intent)
	{
		int id = intent.getIntExtra(KEY_LOCATION, 0);
		this.locationId = id;
	}

	public void initListView()
	{
		listView = (ListView)findViewById(R.id.location_listView);
		//set up listview adapter
		//List<String> values = this.locationManager().remindersOfLocationId(this.locationId);
		String[] values = {"Hello", "Byebye", "Goodnight"};
		ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, 
				android.R.layout.simple_list_item_1, 
				values);
		
		listView.setAdapter(adapter);
	}
}
