package com.stopcheck.databases;

import java.util.List;

import android.database.Cursor;
import android.database.SQLException;

public interface DataSource<Type> {
	
	public void open() throws SQLException;
	
	public void close();
	
	public Type insert(Type object);
	
	public List<Type> queryAll();
	
	public Type queryById(int id);
	
	public boolean delete(Type object);
	
	public boolean update(Type object);
	
	public Type cursorToObject(Cursor cursor);
	
}
