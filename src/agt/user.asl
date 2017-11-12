{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+project(ProjectName)
	<-
		.print("Analysing requirments");
		.wait(5000);
		lookupArtifact("requirements", RequirementsArtId);
		focus(RequirementsArtId);
		userApproval[artifact_id(RequirementsArtId)];
		.print("Requirements document approved");
		.