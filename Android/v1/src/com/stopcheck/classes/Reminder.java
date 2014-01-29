package com.stopcheck.classes;

/*
 * Created: 24 Jan 2014
 * Author: Jeremiah
 * 
 * Purpose: A Reminder Class, this would contain information of a reminder
 */

public class Reminder {

	public int reminderId;
	public int locationid;
	public String[] notes;
	public int[] days;
	public boolean shouldRepeatWeekly;
	public TriggerType triggerType;
	public boolean isTurnedOn;
	public String startDate;
	
	public String notesString()
	{
		return this.notes[0];
	}
	
	public String daysString()
	{
		return " "+this.days[0];
	}
	
	@Override
	public String toString()
	{
		return this.notesString();
	}
}
