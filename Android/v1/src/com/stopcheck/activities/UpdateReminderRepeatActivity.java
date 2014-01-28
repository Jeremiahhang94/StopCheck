package com.stopcheck.activities;

/*
 * Created: 24 Jan 2014
 * Author: Jeremiah
 * 
 * Purpose: The activity that would allow user to 
 * update the repeat option of an existing reminder
 * 
 */


public class UpdateReminderRepeatActivity extends ReminderRepeatActivity {

	public void loadDays() {
		/*
		 * loads the selectable days, highgliting the days that are already
		 * selected
		 */
		
		int ii, length = 4; //this.buttons.length;
		for(ii=0; ii<length; ii++)
		{
			if(this.days[ii] == 1)
			{
				//press button
			}
		}
	}

	@Override
	public void saveReminder() {
		/*
		 * Sends the reminder object to be updated in the database
		 */
	}

}
