/*
 * Created: 24 Jan 2014
 * Author: Jeremiah
 * 
 * Purpose: The Object that would handle any 
 * communications between activities and the database 
 * or any other server side communications
 */

public class LocationManager 
{
	public LocationManager()
	{
		
	}
	
	public boolean createReminder(Reminder reminder)
	{
		return true;
	}
	
	public Reminder reminderOfId(int id)
	{
		return new Reminder();
	}
	
	public Reminder[] remindersOfLocationId(int id)
	{
		return new Reminder[8];
	}
	
	public boolean updateReminder(Reminder reminder)
	{
		return true;
	}
	public boolean deleteReminder(Reminder reminder)
	{
		return true;
	}
	public boolean toggleReminder(Reminder reminder)
	{
		return true;
	}
	public boolean createLocation(Location location)
	{
		return true;
	}
	public Location locationOfId(int id)
	{
		return new Location();
	}
	public boolean updateLocation(Location location)
	{
		return true;
	}
	public boolean deleteLocation(Location location)
	{
		return true;
	}
	public boolean shouldChangeMonitoringStatusOfLocation(Location location)
	{
		return true;
	}
	public void changeMonitoringStatusOfLocation(Location location)
	{
		
	}
}
