package com.stopcheck.activities;

/*
 * Created: 24 Jan 2014
 * Author: Jeremiah
 * 
 * Purpose: The activity that would display an editable table for users
 * 			to add or remove notes to a new reminder
 */

import com.example.stopcheck.R;

import android.os.Bundle;
import android.view.Menu;

public class ReminderNotesActivity extends LocationReminderActivity {

	private String[] notes;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_reminder_notes);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.reminder_notes, menu);
		return true;
	}
	
	/**
	 * @category setter
	 * @param notes
	 */
	public void setNotes(String[] notes)
	{
		this.notes = notes;
	}
	
	/**
	 * @category getter
	 * @return String[] notes
	 */
	public String[] getNotes()
	{
		return this.notes;
	}

	public void addNote(String note) {
		// Add a note onto the notes array
		// and draws a new cell for user to add the next note
		
		int numberOfNotes = this.notes.length;
		this.notes[numberOfNotes] = note;
		
		this.drawCell(note);
		
	}

	public void drawCell(String note) {
		// draws a new cell onto the view
	}

	public void removeNote(int index) {
		// Remove a note from the notes array
		// and delete the cell
		
		this.notes[index] = null;
		this.destroyCell(index);
	}

	public void destroyCell(int index) {
		// remove a cell from the view
		
	}

	public String notesString() {
		// return all the notes in a string
		// return "No Notes" if there is no notes
		return this.notes.toString();
	}

	public void startRepeatActivity() {
		// start ReminderRepeatActivity activity with the notesString
		// reminderId = 0 and locationId;
	}

}
