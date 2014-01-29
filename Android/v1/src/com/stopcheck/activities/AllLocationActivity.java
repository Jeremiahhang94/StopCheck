package com.stopcheck.activities;

/*
 * Created: 24 Jan 2014
 * Author: Jeremiah
 * 
 * Purpose: The activity that would display
 * all the location that is stored in the database
 * and allow the users to delete location
 * while in edit mode
 * 
 */

import com.stopcheck.classes.*;
import com.example.stopcheck.R;
import android.os.Bundle;
import android.view.Menu;

public class AllLocationActivity extends LocationReminderActivity {
	
	private Location[] allLocations;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_all_location);
		
		this.activityDidLoad();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.all_location, menu);
		return true;
	}
	
	public void requestAllLocations()
	{
		/*
		 * Request from location manager
		 * all the location in the database
		 */
		
		Location[] allLocation = (Location[]) this.locationManager().allLocation().toArray();
		this.allLocations = allLocation;
		
	}
	
	public void presentAllLocation()
	{
		/*
		 * print out all the location
		 */
		
		int ii=0, length = this.allLocations.length;
		Location currentLocation;
		for(ii=0; ii<length; ii++)
		{
			currentLocation = (Location)allLocations[ii];
			System.out.println(currentLocation);
		}
	}
	
	public void editBtnPressed()
	{
		/*
		 * triggered when the edit button is pressed, 
		 * brings the view into an edit mode where user 
		 * can select Locations to be deleted.
		 */
		
		
		
	}
	
	public void deleteBtnPressed()
	{
		/*
		 * Triggered when user select the "-" button beside a location
		 * in edit mode. This would trigger the location manager
		 * to delete the location from the database
		 */
	}

}
