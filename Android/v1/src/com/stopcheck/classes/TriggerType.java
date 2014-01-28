package com.stopcheck.classes;

public enum TriggerType {

	TRIGGER_ON_NONE (-1),
	TRIGGER_ON_ENTER (0),
	TRIGGER_ON_EXIT (1),
	TRIGGER_ON_BOTH (2);
	
	TriggerType (int i)
	{
		this.type = i;
	}
	
	private int type;

    public int getNumericType()
    {
        return type;
    }
    
    public static TriggerType getTriggerType(int i)
    {
    	TriggerType triggerType = null;
		switch(i)
		{
		case -1: triggerType = TriggerType.TRIGGER_ON_NONE; break;
		case 0: triggerType = TriggerType.TRIGGER_ON_ENTER; break;
		case 1: triggerType = TriggerType.TRIGGER_ON_EXIT; break;
		case 2: triggerType = TriggerType.TRIGGER_ON_BOTH; break;
		}
    	return triggerType;
    }
	
	
}
