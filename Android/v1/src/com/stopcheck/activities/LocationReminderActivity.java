package com.stopcheck.activities;

import android.app.Activity;
import android.content.Intent;

import com.stopcheck.classes.Location;
import com.stopcheck.classes.LocationManager;
import com.stopcheck.classes.Reminder;


public class LocationReminderActivity extends Activity {

	protected int locationId;
	protected Location location;
	protected int reminderId;
	protected Reminder reminder;
	protected LocationManager locationManager;
	
	public LocationReminderActivity() {
	}
	
	public void activityDidLoad()
	{
		this.setLocation(null);
		this.setReminder(null);
		this.setLocationManager(null);
		System.out.println("Created");
	}
	
	public LocationManager locationManager() {
		
		if(this.locationManager == null)
		{
			this.locationManager = new LocationManager();
		}
		
		return this.locationManager;
	}
	
	public void startActivityOfClass(Class<?> nextClass)
	{
		Intent intent = new Intent(this, nextClass);
		this.startActivity(intent);
	}
	
	/**
	 * @category getter
	 * @return Location location
	 */
	public Location getLocation() {
		return location;
	}

	/**
	 * @category getter
	 * @return Reminder reminder
	 */
	public Reminder getReminder() {
		return reminder;
	}
	
	/**
	 * @category getter
	 * @return LocationManager locationManager
	 */
	public LocationManager getLocationManager() {
		return locationManager;
	}

	/**
	 * @category setter
	 * @param location
	 */
	public void setLocation(Location location) {
		this.location = location;
	}
	
	/**
	 * @category setter
	 * @param reminder
	 */
	public void setReminder(Reminder reminder) {
		this.reminder = reminder;
	}

	/**
	 * @category setter
	 * @param locationManager
	 */
	public void setLocationManager(LocationManager locationManager) {
		this.locationManager = locationManager;
	}

}
