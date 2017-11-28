{ include("common.asl") }

!hire_software_company.

+readyToDeploy[source(Developer)] 
	<- 
		.print("Deploy approved");
		.wait(1000);		
		.send(Developer, tell, deployApproved);
		.

+project(ProjectName)
	<-
		.print("Analysing requirments");
		.wait(5000);
		lookupArtifact("requirements", RequirementsArtId);
		focus(RequirementsArtId);
		ownerApproval[artifact_id(RequirementsArtId)];
		.print("Requirements document approved");
		.

+!hire_software_company
	<-
		ProjectName = "projectOne";	
		!hireSoftwareCompany(ProjectName);
		.
		
+!hireSoftwareCompany(ProjectName)
	<-
		ProjectName = "projectOne";
		.print("Hiring software company for project ", ProjectName);
		makeArtifact("contract", "softwareCompany.tools.ContractArt", [], ContractArtId);
		!callManager(ProjectName, ContractArtId);
		!signContract;
		.

+!signContract
	<-
		clientSign[artifact_id(ContractArtId)];
		.print("Client signed");
		.

+!callManager(ProjectName, ContractArtId)
	<-
		.send(manager, tell, project(ProjectName));
		.
