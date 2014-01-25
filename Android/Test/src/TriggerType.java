
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
	
	
}
