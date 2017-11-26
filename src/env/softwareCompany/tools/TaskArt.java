package softwareCompany.tools;

import cartago.*;

public class TaskArt extends Artifact {
			
	private static final String PROPERTY_NAME_ID = "artifactId";	
	private static final String PROPERTY_NAME_NAME = "name";
	private static final String PROPERTY_NAME_SIZE = "size";
	private static final String PROPERTY_NAME_PERSON_RESPONSIBLE = "personResponsible";        
	private static int lastTaskId = 1;
	
	void init(String name, String size) {
        defineObsProperty(PROPERTY_NAME_ID, lastTaskId);
        defineObsProperty(PROPERTY_NAME_NAME, name);
        defineObsProperty(PROPERTY_NAME_SIZE, size);
        defineObsProperty(PROPERTY_NAME_PERSON_RESPONSIBLE, "");
        lastTaskId++;
	}

	@OPERATION
	void setPersonResponsible(String personResponsible) {
		updateObsProperty(PROPERTY_NAME_PERSON_RESPONSIBLE, personResponsible);
	}
}
