package softwareCompany.tools;

import cartago.*;

public class TaskArt extends Artifact {
			
	private static final String PROPERTY_NAME_ID = "id";	
	private static final String PROPERTY_NAME_PHASE_OBS = "phase";
	private static final String PROPERTY_NAME_SIZE = "size";
	private static int lastTaskId = 1;
	
	void init(String name, String size) {
        defineObsProperty(PROPERTY_NAME_ID, lastTaskId);
        defineObsProperty(PROPERTY_NAME_PHASE_OBS, RequirementPhase.DEV);
        defineObsProperty(PROPERTY_NAME_SIZE, size);
		lastTaskId++;
	}
		
	@OPERATION
	void develop() {
		updatePhase(RequirementPhase.TEST);
	}

	@OPERATION
	void test() {
		updatePhase(RequirementPhase.RELEASE);
	}
	
	@OPERATION
	void size(OpFeedbackParam size) {
		size.set(getObsProperty(PROPERTY_NAME_SIZE).getValue());
	}
	
	private void updatePhase(RequirementPhase phase) {
		ObsProperty prop = getObsProperty(PROPERTY_NAME_PHASE_OBS);
		prop.updateValue(phase);
	}
}

