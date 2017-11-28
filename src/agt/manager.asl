{ include("common.asl") }

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+project(Name) 
	<- 
		!signContract;
		.

+bothSigned : .time(H,M,S)
	<-
		Name = "Project1";
		.print("Both signed");
		.print("Starting project ", Name, " at ", H, ":", M, ":", S);
		+start(H,M,S);
		.print("Assigning requirements to analyst");
		
  		makeArtifact(myorg, "ora4mas.nopl.OrgBoard", ["src/org/softwareCompany.xml"], OrgArtId)[wid(WOrg)];
      	focus(OrgArtId);
      
		makeArtifact("board", "softwareCompany.gui.Board");
		!tellAnalystToAnalyseRequirements(Name);
		!assignDevsToProject(Name);
		!assignTestersToProject(Name);
		.

+deployed : start(SH, SM, SS) & .time(EH,EM,ES)
	<-
		.print("Project start time: ", SH, ":", SM, ":", SS);
		.print("Project end time: ", EH, ":", EM, ":", ES);
		.

+!signContract
	<-
		lookupArtifact("contract", ContractArtId);
		focus(ContractArtId);
		companySign[artifact_id(ContractArtId)];
		.print("Manager signed");
		.

+!tellAnalystToAnalyseRequirements(ProjectName) <- .send(analyst, tell, project(ProjectName)).
+!assignDevsToProject(ProjectName) <- !send_role(developer, project(ProjectName)).
+!assignTestersToProject(ProjectName) <- !send_role(tester, project(ProjectName)).
