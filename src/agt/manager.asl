{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+project(Name) 
	<- 
		.print("Starting project ", Name);
		.print("Assigning requirements to analyst");
		
  		makeArtifact(myorg, "ora4mas.nopl.OrgBoard", ["src/org/softwareCompany.xml"], OrgArtId)[wid(WOrg)];
      	focus(OrgArtId);
      
		makeArtifact("board", "softwareCompany.gui.Board");
		!sendRequirementsToAnalyst
		.
	
+!sendRequirementsToAnalyst
	<-
		for (requirement(ProjectName,RequirementArtifactName)) {
			.send(analyst, tell, requirement(ProjectName,RequirementArtifactName));
		}	
		.send(analyst, tell, project(ProjectName))
		.
