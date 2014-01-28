package com.stopcheck.databases;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class LocationSQLiteHelper extends SQLiteOpenHelper {

	public static final String TABLE_LOCATIONS = "locations";
	public static final String COLUMN_ID = "_id";
	public static final String COLUMN_NAME = "name";
	public static final String COLUMN_STREET = "name";
	public static final String COLUMN_LONGITUDE = "longitude";
	public static final String COLUMN_LATITUDE= "latitude";
	public static final String COLUMN_REMINDER_COUNT = "reminderCount";
	public static final String COLUMN_IS_MONITORED = "isMonitored";
	public static final String COLUMN_START_DATE = "startDate";

	private static final String DATABASE_NAME = "reminders.db";
	private static final int DATABASE_VERSION = 1;
	
	//create table sql statement
		private static final String DATABASE_CREATE = "create table "
				      + TABLE_LOCATIONS 
				      + "(" 
				      + COLUMN_ID + " integer primary key autoincrement, " 
				      + COLUMN_NAME + " text not null, " 
				      + COLUMN_STREET + " text not null, " 
				      + COLUMN_LONGITUDE + " real not null, " 
				      + COLUMN_LATITUDE + " real not null, " 
				      + COLUMN_REMINDER_COUNT + " integer not null, " 
				      + COLUMN_IS_MONITORED + " integer not null, " 
				      + COLUMN_START_DATE + " text not null " 
				      + ");";
	
	public LocationSQLiteHelper(Context context) {
		super(context, DATABASE_NAME, null, DATABASE_VERSION);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		// TODO Auto-generated method stub
		db.execSQL(DATABASE_CREATE);	
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		// TODO Auto-generated method stub
		Log.w(ReminderSQLiteHelper.class.getName(),
		        "Upgrading database from version " + oldVersion + " to "
		            + newVersion + ", which will destroy all old data");
		    db.execSQL("DROP TABLE IF EXISTS " + TABLE_LOCATIONS);
		    onCreate(db);

	}

}
