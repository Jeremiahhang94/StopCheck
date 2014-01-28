package com.stopcheck.classes;

import java.util.List;

import android.content.Context;

import com.stopcheck.databases.LocationDataSource;
import com.stopcheck.databases.ReminderDataSource;

/*
 * Created: 24 Jan 2014
 * Author: Jeremiah
 * 
 * Purpose: The Object that would handle any 
 * communications between activities and the database 
 * or any other server side communications
 */


public class LocationManager {

	private LocationDataSource locationDataSource;
	private ReminderDataSource reminderDataSource;
	private Context context;
	
	public LocationManager()
	{
		
	}
	
	public boolean createReminder(Reminder reminder)
	{
		Reminder newReminder = this.getReminderDataSource().insert(reminder);
		if(newReminder != null)
			return true;
		else return false;
	}
	
	public Reminder reminderOfId(int id)
	{
		Reminder newReminder = this.getReminderDataSource().queryById(id);
		return newReminder;
	}
	
	public Reminder[] remindersOfLocationId(int id)
	{
		return new Reminder[8];
	}
	
	public boolean updateReminder(Reminder reminder)
	{
		boolean updated = this.getReminderDataSource().update(reminder);
		return updated;
	}
	public boolean deleteReminder(Reminder reminder)
	{
		boolean deleted = this.getReminderDataSource().delete(reminder);
		return deleted;
	}
	public boolean toggleReminder(Reminder reminder)
	{
		reminder.isTurnedOn = !reminder.isTurnedOn;
		boolean updated = this.updateReminder(reminder);
		return updated;
	}
	public boolean createLocation(Location location)
	{
		Location newLocation = this.getLocationDataSource().insert(location);
		if(newLocation != null)
			return true;
		else return false;
	}
	public Location locationOfId(int id)
	{
		Location newLocation = this.getLocationDataSource().queryById(id);
		return newLocation;
	}
	public Location[] monitoredLocations()
	{
		Location[] monitoredLocation = new Location[4];
		return monitoredLocation;
	}
	public Location[] allLocation()
	{
		List<Location> allLocation = this.getLocationDataSource().queryAll();
		Location[] locations = new Location[allLocation.size()];
		
		int ii, length = locations.length;
		for(ii=0;ii<length;ii++)
		{
			locations[ii] = allLocation.get(ii);
		}
	
		return locations;
	}
	
	public boolean updateLocation(Location location)
	{
		boolean updated = this.getLocationDataSource().update(location);
		return updated;
	}
	public boolean deleteLocation(Location location)
	{
		boolean deleted = this.getLocationDataSource().delete(location);
		return deleted;
	}
	public boolean shouldChangeMonitoringStatusOfLocation(Location location)
	{
		return true;
	}
	public void changeMonitoringStatusOfLocation(Location location)
	{
		
	}

	/**
	 * @category getter
	 * @return the locationDataSource
	 */
	public LocationDataSource getLocationDataSource() {
		if(locationDataSource == null)
			locationDataSource = new LocationDataSource(this.context);
		return locationDataSource;
	}

	/**
	 * @category setter
	 * @param locationDataSource the locationDataSource to set
	 */
	public void setLocationDataSource(LocationDataSource locationDataSource) {
		this.locationDataSource = locationDataSource;
	}

	/**
	 * @category getter
	 * @return the reminderDataSource
	 */
	public ReminderDataSource getReminderDataSource() {
		if(reminderDataSource == null)
			reminderDataSource = new ReminderDataSource(this.context);
		return reminderDataSource;
	}

	/**
	 * @category setter
	 * @param reminderDataSource the reminderDataSource to set
	 */
	public void setReminderDataSource(ReminderDataSource reminderDataSource) {
		this.reminderDataSource = reminderDataSource;
	}
	
	/**
	 * @category setter
	 * @param context the context to set
	 */
	public void setContext(Context context)
	{
		this.context = context;
	}
}
