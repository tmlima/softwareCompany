package softwareCompany.tools;

import cartago.Artifact;
import cartago.OPERATION;

public class RequirementDocumentArt extends Artifact {
	
	private boolean ownerApproved = false;
	private boolean analystApproved = false;
	
    void init()  {    	
    }

    @OPERATION public void ownerApproval() {
    	ownerApproved = true;
    	updateBothApproved();
    }

    @OPERATION public void analystApproval() {
    	analystApproved = true;
    	updateBothApproved();
    }
    
    private void updateBothApproved() {
    	if (ownerApproved && analystApproved)
            defineObsProperty("bothApproved");
    }
}
