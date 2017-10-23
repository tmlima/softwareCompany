{ include("common.asl") }

/* Initial beliefs and rules */

/* Initial goals */

!new_software_deployed.

/* Plans */

+!new_software_deployed
	<- 
		ProjectName = "projectOne";
		!create_requirements(ProjectName);
		!contract_project_team(ProjectName).

+!create_requirements(ProjectName)
	<-
		!create_requirement(ProjectName, "login");
		!create_requirement(ProjectName, "firstCrud");
		!create_requirement(ProjectName, "secondCrud").

+!create_requirement(ProjectName, RequirementName)
	<-
		.print("Creating requirement ", RequirementName, " for project ", ProjectName);
		.concat("requirement_", ProjectName, "_", RequirementName, ArtName);
		makeArtifact(ArtName, "softwareCompany.tools.RequirementArt", [RequirementName], ArtId);
		focus(ArtId).
		
+!contract_project_team(ProjectName)
	<-
		for (focused(_,RequirementArtifactName[_],ArtId)) {
			.send(manager, tell, 	requirement(ProjectName, RequirementArtifactName));
		}	
		.print("Telling manager to start project");
		.send(manager, tell, project(ProjectName));
		.
