package com.stopcheck.classes;

public class MonitoredPin extends Pin {

	public MonitoredPin(Location location)
	{
		this.location = location;
		this.longitude = location.longitude;
		this.latitude = location.latitude;
	}
	
}
