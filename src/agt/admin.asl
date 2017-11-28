
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }


+package_ready[source(Developer)]
	<-
		.print("Deployed");		
		.broadcast(tell,deployed);
		.