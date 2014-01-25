/*
 * Created: 24 Jan 2014
 * Author: Jeremiah
 * 
 * Purpose: A pin object, but this is of a monitored location
 * the image would be different
 */
public class MonitoredPin extends Pin {

	public MonitoredPin(Location location)
	{
		this.location = location;
		this.longitude = location.longitude;
		this.latitude = location.latitude;
	}
}
