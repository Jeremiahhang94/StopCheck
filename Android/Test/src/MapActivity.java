/*
 * Created: 24 Jan 2014
 * Author: Jeremiah
 * 
 * Purpose: This activity would display the map
 * allows user to select/search a location
 * view their information and either
 * add a reminder or view the reminder of the location
 * they can also choose to view all location from here
 * 
 */
public class MapActivity extends LocationReminderActivity 
{
	//priave mapview
	private MonitoredPin[] monitoredPins;
	private Pin currentPin;
	//private View locationInformationView;
	//private Label name_lbl;
	//private Label street_lbl;
	//private Button location_button;
	
	public MapActivity()
	{
		System.out.println(this.monitoredPins[0] +" "+ currentPin);
	}
	
	public void mapDidTap()
	{
		/*
		 * Triggered When user taps on the map
		 * converts the touch point to coordinate
		 * drops a pin on the coordinate
		 * and fetch the location information of the coordinate
		 * from the location manager
		 */
	}
	
	public void pinDidTap()
	{
		/*
		 * Triggered when a pin is tapped,
		 * it get the location information of the location
		 * the pin in on from the 
		 * location manager and display it
		 */
	}
	
	public void dropPinOnCoordinate(Pin pin)
	{
		/*
		 * Given a coordinate, drops a "temporal" pin
		 * on the map
		 */
	}
	
	public void dropPinMonitored(MonitoredPin pin)
	{
		/*
		 * Given a MonitoredPin Object, drop it on the map
		 */
	}
	
	public void fetchMonitoredLocation()
	{
		/*
		 * From the location manager,
		 * fetch the list of location that are monitored
		 * and drop them as a monitored pin on the map
		 */
		
		Location[] monitoredLocation = this.locationManager().monitoredLocations();
		if(monitoredLocation != null)
		{
			int ii=0, length = monitoredLocation.length;
			Location currentLocation;
			
			for(ii=0; ii<length; ii++)
			{
				currentLocation = monitoredLocation[ii];
				MonitoredPin pin = new MonitoredPin(currentLocation);
				this.dropPinMonitored(pin);
			}
		}
		
	}
	
	public void displayLocationInformation(Location location)
	{
		/*
		 * Brings up the location information view
		 * if it have not already existed and
		 * show the name and street of the location
		 */
		
		//bring up information view
		
		//set name and street 
		
		
	}
	
	
	/**
	 * @category setter
	 * @return the monitoredPins
	 */
	public MonitoredPin[] getMonitoredPins() {
		return monitoredPins;
	}

	/**
	 * @category setter
	 * @param monitoredPins the monitoredPins to set
	 */
	public void setMonitoredPins(MonitoredPin[] monitoredPins) {
		this.monitoredPins = monitoredPins;
	}

	/**
	 * @category getter
	 * @return the currentPin
	 */
	public Pin getCurrentPin() {
		return currentPin;
	}

	/**
	 * @category setter
	 * @param currentPin the currentPin to set
	 */
	public void setCurrentPin(Pin currentPin) {
		this.currentPin = currentPin;
	}
}
