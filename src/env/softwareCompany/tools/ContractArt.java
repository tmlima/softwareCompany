package softwareCompany.tools;

import cartago.*;

public class ContractArt extends Artifact {

	private boolean clientSigned = false;
	private boolean companySigned = false;
	
    void init()  {
    }

    @OPERATION public void clientSign() {
    	clientSigned = true;
    	updateBothSigned();
    }

    @OPERATION public void companySign() {
    	companySigned = true;
    	updateBothSigned();
    }
    
    private void updateBothSigned() {
    	if (clientSigned && companySigned)
          defineObsProperty("bothSigned");
    }
}
