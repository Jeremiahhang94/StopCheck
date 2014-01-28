package com.stopcheck.databases;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

public class ReminderSQLiteHelper extends SQLiteOpenHelper {

	public static final String TABLE_REMINDERS = "reminders";
	public static final String COLUMN_ID = "_id";
	public static final String COLUMN_LOCATION_ID = "locationId";
	public static final String COLUMN_NOTES = "notes";
	public static final String COLUMN_DAYS = "days";
	public static final String COLUMN_SHOULD_REPEAT_WEEKLY= "shouldRepeatWeekly";
	public static final String COLUMN_TRIGGER_TYPE = "triggerType";
	public static final String COLUMN_IS_TURNED_ON = "isTurnedOn";
	public static final String COLUMN_START_DATE = "startDate";

	private static final String DATABASE_NAME = "reminders.db";
	private static final int DATABASE_VERSION = 1;
	
	//create table sql statement
	private static final String DATABASE_CREATE = "create table "
			      + TABLE_REMINDERS 
			      + "(" 
			      + COLUMN_ID + " integer primary key autoincrement, " 
			      + COLUMN_LOCATION_ID + " integer not null, " 
			      + COLUMN_NOTES + " text not null, " 
			      + COLUMN_DAYS + " text not null, " 
			      + COLUMN_SHOULD_REPEAT_WEEKLY + " integer not null, " 
			      + COLUMN_TRIGGER_TYPE + " integer not null, " 
			      + COLUMN_IS_TURNED_ON + " integer not null, " 
			      + COLUMN_START_DATE + " text not null " 
			      + ");";
	
	public ReminderSQLiteHelper(Context context) {
		super(context, DATABASE_NAME, null, DATABASE_VERSION);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void onCreate(SQLiteDatabase database) {
		// TODO Auto-generated method stub
		database.execSQL(DATABASE_CREATE);	

	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		// TODO Auto-generated method stub
		Log.w(ReminderSQLiteHelper.class.getName(),
		        "Upgrading database from version " + oldVersion + " to "
		            + newVersion + ", which will destroy all old data");
		    db.execSQL("DROP TABLE IF EXISTS " + TABLE_REMINDERS);
		    onCreate(db);
	}

}
