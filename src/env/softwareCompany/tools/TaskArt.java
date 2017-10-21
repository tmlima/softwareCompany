package softwareCompany.tools;

import cartago.*;

public class TaskArt extends Artifact {
			
	private static final String PHASE_OBS_PROPERTY_ID = "id";	
	private static final String PHASE_OBS_PROPERTY_NAME = "phase";
	private static int lastTaskId = 1;
	
	void init() {
        defineObsProperty(PHASE_OBS_PROPERTY_ID, lastTaskId);
        defineObsProperty(PHASE_OBS_PROPERTY_NAME, RequirementPhase.DEV);
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
	
	private void updatePhase(RequirementPhase phase) {
		ObsProperty prop = getObsProperty(PHASE_OBS_PROPERTY_NAME);
		prop.updateValue(phase);
	}
}

