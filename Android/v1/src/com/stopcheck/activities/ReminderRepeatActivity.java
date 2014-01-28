package com.stopcheck.activities;

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

import java.util.Calendar;
import java.util.Date;

import android.os.Bundle;
import android.view.Menu;

import com.example.stopcheck.R;
import com.stopcheck.classes.Reminder;
import com.stopcheck.classes.TriggerType;

public class ReminderRepeatActivity extends LocationReminderActivity {
	
	private String[] notes;
	private boolean shouldRepeatWeekly;
	protected int[] days;
	private TriggerType triggerType;
	// protected Button[] daysButtons;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_reminder_repeat);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.reminder_repeat, menu);
		return true;
	}

	public Reminder createReminder()
	{
		//create and return a reminder object 
		//with respective values
	
		Reminder reminder = new Reminder();
		reminder.days = this.days;
		reminder.notes = this.notes;
		reminder.shouldRepeatWeekly = this.shouldRepeatWeekly;
		
		Date today = new Date();
		reminder.startDate = today.toString();
		
		reminder.isTurnedOn = true;
		reminder.triggerType = this.triggerType;
		reminder.locationid = this.locationId;
		reminder.reminderId = this.reminderId;
		
		return reminder;
	}
	
	
	public void saveReminder() {
		// sends the Reminder object to locationManager
		// to be saved newly into the database
		// once saved show LocationViewActivity
	
		boolean created = this.locationManager.createReminder(this.createReminder());
		if(created)
		{
			//show LocationViewActivity
		}
		
	}

	/**
	 * @category getter
	 * @return the triggerType
	 */
	public TriggerType getTriggerType() {
		return triggerType;
	}

	/**
	 * @category setter
	 * @param triggerType the triggerType to set
	 */
	public void setTriggerType(TriggerType triggerType) {
		this.triggerType = triggerType;
	}

	public void printDays() {
		/*
		 * loads the selected days, highlight today
		 */
		
		int ii = 0, length = 7;
		Calendar c = Calendar.getInstance();
		int today = c.get(Calendar.DAY_OF_WEEK) - 1;
		//0->Sunday, 1->Monday, 2->Tuesday....... 6->Saturday
		
		for(ii=0; ii<length; ii++)
		{
			if(ii == today)
			{
				
			}
		}
		
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

	/**
	 * @category getter
	 * @return the notes
	 */
	public String[] getNotes() {
		return notes;
	}

	/**
	 * @category setter
	 * @param notes the notes to set
	 */
	public void setNotes(String[] notes) {
		this.notes = notes;
	}

	/**
	 * @category getter
	 * @return the shouldRepeatWeekly
	 */
	public boolean isShouldRepeatWeekly() {
		return shouldRepeatWeekly;
	}

	/**
	 * @category setter
	 * @param shouldRepeatWeekly the shouldRepeatWeekly to set
	 */
	public void setShouldRepeatWeekly(boolean shouldRepeatWeekly) {
		this.shouldRepeatWeekly = shouldRepeatWeekly;
	}

	/**
	 * @category getter
	 * @return the days
	 */
	public int[] getDays() {
		return days;
	}

	/**
	 * @category setter
	 * @param days the days to set
	 */
	public void setDays(int[] days) {
		this.days = days;
	}

}
