package softwareCompany.tools;

import cartago.*;

public class TaskArt extends Artifact {
			
	private static final String PHASE_OBS_PROPERTY_ID = "id";	
	private static final String PHASE_OBS_PROPERTY_NAME = "phase";
	private static final String SIZE_PROPERTY_NAME = "size";
	private static int lastTaskId = 1;
	
	void init(String name, String size) {
        defineObsProperty(PHASE_OBS_PROPERTY_ID, lastTaskId);
        defineObsProperty(PHASE_OBS_PROPERTY_NAME, RequirementPhase.DEV);
        defineObsProperty(SIZE_PROPERTY_NAME, size);
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
		size.set(getObsProperty(SIZE_PROPERTY_NAME).getValue());
	}
	
	private void updatePhase(RequirementPhase phase) {
		ObsProperty prop = getObsProperty(PHASE_OBS_PROPERTY_NAME);
		prop.updateValue(phase);
	}
}

