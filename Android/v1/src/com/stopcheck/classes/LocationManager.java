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
	
	public List<Reminder> remindersOfLocationId(int id)
	{
		//TODO update method to return reminders of selected location id
		return null;
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
	public List<Location> monitoredLocations()
	{
		//TODO update method to return monitored locations
		return null;
	}
	public List<Location> allLocation()
	{
		List<Location> allLocation = this.getLocationDataSource().queryAll();
		return allLocation;
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
		//TODO update method to check if a location should change its monitoring status
		return true;
	}
	public void changeMonitoringStatusOfLocation(Location location)
	{
		//TODO update method to change the monitoring status
	}

	/**
	 * @category getter
	 * @return the locationDataSource
	 */
	public LocationDataSource getLocationDataSource() {
		if(locationDataSource == null)
		{
			locationDataSource = new LocationDataSource(this.context);
			locationDataSource.open();
		}
		
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
		{
			reminderDataSource = new ReminderDataSource(this.context);
			reminderDataSource.open();
		}
			
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
