package com.stopcheck.databases;

import java.util.ArrayList;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;

import com.stopcheck.classes.Reminder;
import com.stopcheck.classes.TriggerType;

public class ReminderDataSource implements DataSource<Reminder>{

	private SQLiteDatabase database;
	private ReminderSQLiteHelper dbHelper;
	private String[] allColumn = { 
			ReminderSQLiteHelper.COLUMN_ID,
		    ReminderSQLiteHelper.COLUMN_LOCATION_ID,
		    ReminderSQLiteHelper.COLUMN_NOTES,
		    ReminderSQLiteHelper.COLUMN_DAYS,
		    ReminderSQLiteHelper.COLUMN_SHOULD_REPEAT_WEEKLY,
		    ReminderSQLiteHelper.COLUMN_TRIGGER_TYPE,
		    ReminderSQLiteHelper.COLUMN_IS_TURNED_ON,
		    ReminderSQLiteHelper.COLUMN_START_DATE
		    };
	
	public ReminderDataSource(Context context)
	{
		dbHelper = new ReminderSQLiteHelper(context);
	}
	
	public void open() throws SQLException
	{
		database = dbHelper.getReadableDatabase();
	}
	
	public void close()
	{
		dbHelper.close();
	}

	@Override
	public Reminder insert(Reminder object) {
		// TODO Auto-generated method stub
		
		ContentValues values = new ContentValues();
		values.put(ReminderSQLiteHelper.COLUMN_ID, object.reminderId);
		values.put(ReminderSQLiteHelper.COLUMN_LOCATION_ID, object.locationid);
		values.put(ReminderSQLiteHelper.COLUMN_NOTES, object.notesString());
		values.put(ReminderSQLiteHelper.COLUMN_DAYS, object.daysString());
		values.put(ReminderSQLiteHelper.COLUMN_SHOULD_REPEAT_WEEKLY, object.shouldRepeatWeekly);
		values.put(ReminderSQLiteHelper.COLUMN_TRIGGER_TYPE, object.triggerType.getNumericType());
		values.put(ReminderSQLiteHelper.COLUMN_IS_TURNED_ON, object.isTurnedOn);
		values.put(ReminderSQLiteHelper.COLUMN_START_DATE, object.startDate);
		
		int insertId = (int)database.insert(ReminderSQLiteHelper.TABLE_REMINDERS, null, values);
		
		Cursor cursor = database.query(ReminderSQLiteHelper.TABLE_REMINDERS, 
				this.allColumn, 
				LocationSQLiteHelper.COLUMN_ID + " = " + insertId, 
				null, null, null, null);
		
		cursor.moveToFirst();
		Reminder newReminder = cursorToObject(cursor);
		cursor.close();
		
		return newReminder;
	}

	@Override
	public List<Reminder> queryAll() {
		// TODO Auto-generated method stub
		List<Reminder> allReminder = new ArrayList<Reminder>();
		Cursor cursor = database.query(ReminderSQLiteHelper.TABLE_REMINDERS, 
				this.allColumn, 
				null, null, null, null, null);
		
		cursor.moveToFirst();
		while(!cursor.isAfterLast())
		{
			//not last row..
			
			Reminder reminder = cursorToObject(cursor);
			allReminder.add(reminder);
			cursor.moveToNext();
		}
		
		cursor.close();
		return allReminder;
	}

	@Override
	public Reminder queryById(int id) {
		// TODO Auto-generated method stub
		Reminder reminder = null;
		Cursor cursor = database.query(ReminderSQLiteHelper.TABLE_REMINDERS, 
				this.allColumn, 
				ReminderSQLiteHelper.COLUMN_ID + " = " + id, 
				null, null, null, null);
		
		cursor.moveToFirst();
		reminder = cursorToObject(cursor);
		
		cursor.close();
		return reminder;
	}

	@Override
	public boolean delete(Reminder object) {
		// TODO Auto-generated method stub
		long id = object.reminderId;
		int deleted = database.delete(ReminderSQLiteHelper.TABLE_REMINDERS, 
				ReminderSQLiteHelper.COLUMN_ID+" = "+id,
				null);
		
		if(deleted > 0)
			return true;
		else return false;
	}

	@Override
	public boolean update(Reminder object) {
		// TODO Auto-generated method stub
		int id = object.reminderId;

		ContentValues values = new ContentValues();
		values.put(ReminderSQLiteHelper.COLUMN_LOCATION_ID, object.locationid);
		values.put(ReminderSQLiteHelper.COLUMN_NOTES, object.notesString());
		values.put(ReminderSQLiteHelper.COLUMN_DAYS, object.daysString());
		values.put(ReminderSQLiteHelper.COLUMN_SHOULD_REPEAT_WEEKLY, object.shouldRepeatWeekly);
		values.put(ReminderSQLiteHelper.COLUMN_TRIGGER_TYPE, object.triggerType.getNumericType());
		values.put(ReminderSQLiteHelper.COLUMN_IS_TURNED_ON, object.isTurnedOn);
		values.put(ReminderSQLiteHelper.COLUMN_START_DATE, object.startDate);
		
		int updated = database.update(ReminderSQLiteHelper.TABLE_REMINDERS, 
				values, 
				ReminderSQLiteHelper.COLUMN_ID+" = "+id, 
				null);
		
		if(updated > 0)
			return true;
		else return false;
	}

	@Override
	public Reminder cursorToObject(Cursor cursor) {
		// TODO Auto-generated method stub
		
		Reminder reminder = new Reminder();
		reminder.reminderId = cursor.getInt(0);
		reminder.locationid = cursor.getInt(1);
		
		String notesString = cursor.getString(2);
		String[] notes = notesString.split(",");
		
		reminder.notes = notes;
		
		String daysString = cursor.getString(3);
		String[] daysStringArray = daysString.split(",");
		int[] days = new int[daysStringArray.length];
		int ii, length = days.length;
		for(ii=0;ii<length;ii++)
		{
			days[ii] = Integer.parseInt(daysStringArray[ii]);
		}
		
		reminder.days = days;
		reminder.shouldRepeatWeekly = cursor.getInt(4) == 1;
		
		TriggerType triggerType = TriggerType.getTriggerType(cursor.getInt(5));
		
		reminder.triggerType = triggerType;
		reminder.isTurnedOn = cursor.getInt(6) == 1;
		reminder.startDate = cursor.getString(7);
	    
	    return reminder;
		
	}

	
}
