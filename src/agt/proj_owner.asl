{ include("common.asl") }

/* Initial beliefs and rules */

!needItSolution.

/* Initial goals */

/* Plans */

+readyToDeploy[source(Developer)] 
	<- 
		.print("Deploy approved");
		.wait(1000);		
		.send(Developer, tell, deployApproved);
		.

+!needItSolution
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
