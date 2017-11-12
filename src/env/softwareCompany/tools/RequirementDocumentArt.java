package softwareCompany.tools;

import cartago.Artifact;
import cartago.OPERATION;

public class RequirementDocumentArt extends Artifact {
	
	private boolean userApproved = false;
	private boolean analystApproved = false;
	
    void init()  {    	
    }

    @OPERATION public void userApproval() {
    	userApproved = true;
    	updateBothApproved();
    }

    @OPERATION public void analystApproval() {
    	analystApproved = true;
    	updateBothApproved();
    }
    
    private void updateBothApproved() {
    	if (userApproved && analystApproved)
            defineObsProperty("bothApproved");
    }
}
