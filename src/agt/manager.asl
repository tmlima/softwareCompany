{ include("common.asl") }

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+project(Name) 
	<- 
		!signContract;
		.

+bothSigned
	<-
		Name = "Project1";
		.print("Both signed");
		.print("Starting project ", Name);
		.print("Assigning requirements to analyst");
		
  		makeArtifact(myorg, "ora4mas.nopl.OrgBoard", ["src/org/softwareCompany.xml"], OrgArtId)[wid(WOrg)];
      	focus(OrgArtId);
      
		makeArtifact("board", "softwareCompany.gui.Board");
		!tellAnalystToAnalyseRequirements(Name);
		!assignDevsToProject(Name);
		!assignTestersToProject(Name);
		.

+!signContract
	<-
		lookupArtifact("contract", ContractArtId);
		focus(ContractArtId);
		companySign[artifact_id(ContractArtId)];
		.print("Manager signed");
//		?bothSigned;
		.

+!tellAnalystToAnalyseRequirements(ProjectName) <- .send(analyst, tell, project(ProjectName)).
+!assignDevsToProject(ProjectName) <- !send_role(developer, project(ProjectName)).
+!assignTestersToProject(ProjectName) <- !send_role(tester, project(ProjectName)).
