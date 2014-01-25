public class LocationReminderActivity {

	private int locationId;
	private Location location;
	private int reminderId;
	private Reminder reminder;
	private LocationManager locationManager;

	public LocationReminderActivity() {
		this.setLocation(null);
		this.setReminder(null);
		this.setLocationManager(null);
		System.out.println("Created");
	}
	
	public String locationManager() {
		return "Hello Babe! LocationId: " + this.locationId + " ReminderId: "
				+ this.reminderId;
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
