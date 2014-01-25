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
	
	public void dropPinOnCoordinate()
	{
		/*
		 * Given a coordinate, drops a "temporal" pin
		 * on the map
		 */
	}
	
	public void dropPinMonitored()
	{
		/*
		 * Given a MonitoredPin Object, drop it on the map
		 */
	}
	
	public void fetchMonitoredLocation()
	{
		/*
		 * Brings up the location information view
		 * if it have not already existed and
		 * show the name and street of the location
		 */
	}
	
}
