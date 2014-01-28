package com.stopcheck.databases;

import java.util.ArrayList;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;

import com.stopcheck.classes.Location;

public class LocationDataSource implements DataSource<Location>{

	private SQLiteDatabase database;
	private LocationSQLiteHelper dbHelper;
	private String[] allColumn = { 
			LocationSQLiteHelper.COLUMN_ID,
			LocationSQLiteHelper.COLUMN_NAME,
			LocationSQLiteHelper.COLUMN_STREET,
			LocationSQLiteHelper.COLUMN_LONGITUDE,
			LocationSQLiteHelper.COLUMN_LATITUDE,
			LocationSQLiteHelper.COLUMN_REMINDER_COUNT,
			LocationSQLiteHelper.COLUMN_IS_MONITORED,
			LocationSQLiteHelper.COLUMN_START_DATE
		    };
	
	public LocationDataSource(Context context)
	{
		dbHelper = new LocationSQLiteHelper(context);
	}
	
	@Override
	public void open() throws SQLException {
		// TODO Auto-generated method stub
		database = dbHelper.getReadableDatabase();
	}

	@Override
	public void close() {
		// TODO Auto-generated method stub
		dbHelper.close();
	}

	@Override
	public Location insert(Location object) {
		// TODO Auto-generated method stub
		
		ContentValues values = new ContentValues();
		values.put(LocationSQLiteHelper.COLUMN_ID, object.locationId);
		values.put(LocationSQLiteHelper.COLUMN_NAME, object.name);
		values.put(LocationSQLiteHelper.COLUMN_STREET, object.street);
		values.put(LocationSQLiteHelper.COLUMN_LONGITUDE, object.longitude);
		values.put(LocationSQLiteHelper.COLUMN_LATITUDE, object.latitude);
		values.put(LocationSQLiteHelper.COLUMN_REMINDER_COUNT, object.reminderCount);
		values.put(LocationSQLiteHelper.COLUMN_IS_MONITORED, object.isMonitored);
		values.put(LocationSQLiteHelper.COLUMN_START_DATE, object.date);
		
		int insertId = (int)database.insert(LocationSQLiteHelper.TABLE_LOCATIONS, null, values);
		
		Cursor cursor = database.query(LocationSQLiteHelper.TABLE_LOCATIONS, 
				this.allColumn, 
				LocationSQLiteHelper.COLUMN_ID + " = " + insertId, 
				null, null, null, null);
		
		cursor.moveToFirst();
		Location newLocation = cursorToObject(cursor);
		cursor.close();
		
		return newLocation;
	
	}

	@Override
	public List<Location> queryAll() {
		// TODO Auto-generated method stub

		List<Location> allLocation = new ArrayList<Location>();
		Cursor cursor = database.query(LocationSQLiteHelper.TABLE_LOCATIONS, 
				this.allColumn, 
				null, null, null, null, null);
		
		cursor.moveToFirst();
		while(!cursor.isAfterLast())
		{
			//not last row..
			
			Location location = cursorToObject(cursor);
			allLocation.add(location);
			cursor.moveToNext();
		}
		
		cursor.close();
		return allLocation;
	}

	@Override
	public Location queryById(int id) {
		// TODO Auto-generated method stub
		Location location = null;
		Cursor cursor = database.query(LocationSQLiteHelper.TABLE_LOCATIONS, 
				this.allColumn, 
				LocationSQLiteHelper.COLUMN_ID + " = " + id, 
				null, null, null, null);
		
		cursor.moveToFirst();
		location = cursorToObject(cursor);
		
		cursor.close();
		return location;
	}

	@Override
	public boolean delete(Location object) {
		// TODO Auto-generated method stub
		
		long id = object.locationId;
		int deleted = database.delete(LocationSQLiteHelper.TABLE_LOCATIONS, LocationSQLiteHelper.COLUMN_ID+" = "+id, null);
		
		if(deleted > 0)
			return true;
		else return false;
	}

	@Override
	public boolean update(Location object) {
		// TODO Auto-generated method stub
		
		int id = object.locationId;
		
		ContentValues values = new ContentValues();
		values.put(LocationSQLiteHelper.COLUMN_NAME, object.name);
		values.put(LocationSQLiteHelper.COLUMN_STREET, object.street);
		values.put(LocationSQLiteHelper.COLUMN_LONGITUDE, object.longitude);
		values.put(LocationSQLiteHelper.COLUMN_LATITUDE, object.latitude);
		values.put(LocationSQLiteHelper.COLUMN_REMINDER_COUNT, object.reminderCount);
		values.put(LocationSQLiteHelper.COLUMN_IS_MONITORED, object.isMonitored);
		values.put(LocationSQLiteHelper.COLUMN_START_DATE, object.date);
		
		int updated = database.update(LocationSQLiteHelper.TABLE_LOCATIONS, 
				values, 
				LocationSQLiteHelper.COLUMN_ID+" = "+id, 
				null);
		
		if(updated > 0)
			return true;
		else return false;
	}

	@Override
	public Location cursorToObject(Cursor cursor) {
		// TODO Auto-generated method stub
		
		Location location = new Location();
		location.locationId = cursor.getInt(0);
		location.name = cursor.getString(1);
		location.street = cursor.getString(2);
		location.longitude = cursor.getFloat(3);
		location.latitude = cursor.getFloat(4);
		location.reminderCount = cursor.getInt(5);
		location.isMonitored = cursor.getInt(6) == 1;
		location.date = cursor.getString(7);
		
		return location;
	}

}
