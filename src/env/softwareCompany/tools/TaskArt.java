package softwareCompany.tools;

import cartago.*;

public class TaskArt extends Artifact {
			
	private static final String PROPERTY_NAME_ID = "id";	
	private static final String PROPERTY_NAME_SIZE = "size";
	private static int lastTaskId = 1;
	
	void init(String name, String size) {
        defineObsProperty(PROPERTY_NAME_ID, lastTaskId);
        defineObsProperty(PROPERTY_NAME_SIZE, size);
		lastTaskId++;
	}

	@OPERATION
	void size(OpFeedbackParam size) {
		size.set(getObsProperty(PROPERTY_NAME_SIZE).getValue());
	}
}
