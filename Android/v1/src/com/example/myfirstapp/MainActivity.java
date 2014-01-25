package com.example.myfirstapp;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.widget.Button;
import android.widget.RelativeLayout;
import android.widget.LinearLayout;

public class MainActivity extends Activity {
	
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        RelativeLayout layout = (RelativeLayout) View.inflate(this, R.layout.activity_main, null);
        
        Button newButton = new Button(this);
        newButton.setText(R.string.hello_world);
        
        LinearLayout.LayoutParams buttonLayout = new LinearLayout.LayoutParams(
        		ViewGroup.LayoutParams.WRAP_CONTENT,
                ViewGroup.LayoutParams.WRAP_CONTENT);
        buttonLayout.setMargins(100, 100, 0, 0);
        
        newButton.setLayoutParams(buttonLayout);

        layout.addView(newButton);
        
        setContentView(layout);
        
        
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }
    
}
