package softwareCompany.tools;

import cartago.Artifact;

public class RequirementArt extends Artifact {
	
	void init(String name) {
        defineObsProperty("name", name);
	}
}