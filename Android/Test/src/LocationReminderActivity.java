public class LocationReminderActivity {

	protected int locationId;
	protected Location location;
	protected int reminderId;
	protected Reminder reminder;
	protected LocationManager locationManager;

	public LocationReminderActivity() {
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
