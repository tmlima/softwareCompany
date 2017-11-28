{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

/* Initial beliefs and rules */

/* Initial goals */

+!send_role(Role, Message) : .findall(Agent, play(Agent, Role, _), Group)
	<-
		.send(Group, tell, Message).

+!removePersonReponsible(TaskArtIdString)
	<-
		lookupArtifact(TaskArtIdString, TaskArtId);
		focus(TaskArtId);
		setPersonResponsible("")[artifact_id(TaskArtId)]
		.		
		
+!idle
	<- 
		.wait(5000); 
		-+idle
		.
