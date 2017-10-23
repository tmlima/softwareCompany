{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

/* Initial beliefs and rules */

/* Initial goals */

+!send_role(Role, Message) : .findall(Agent, play(Agent, Role, _), Devs)
	<-
		.send(Devs, tell, Message).