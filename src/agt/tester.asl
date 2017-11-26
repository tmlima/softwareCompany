{ include("common.asl") }

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true <- +idle.
		
+project(ProjectName) 
	<- 	
		.print("I was assigned to project ", ProjectName);
		lookupArtifact("board", BoardArtId);
		focus(BoardArtId);
		+boardArtId(BoardArtId);
		+idle;
		.
				
+idle : boardArtId(BoardArtId) & firstTaskToTestArtId(TaskArtId)[artifact_id(BoardArtId)] & not(TaskArtId = "")
	<-
		!getTask(TaskArtId, BoardArtId);
		-idle;
		!doTask(TaskArtId);
		+idle;		
		.

+idle : true <- !idle.

+!getTask(TaskArtIdString, BoardArtId) : .my_name(Name)
	<-
		.print("Found task ", TaskArtIdString, " to test");
		lookupArtifact(TaskArtIdString, TaskArtId);
		focus(TaskArtId);
		setPersonResponsible(Name)[artifact_id(TaskArtId)];
		?personResponsible(Responsible)[artifact_id(TaskArtId)];
		moveTask(TaskArtIdString, "ToTest", "Testing", Responsible)[artifact_id(BoardArtId)];
		.

+!doTask(TaskArtId) : boardArtId(BoardArtId)
	<-
		!testTask(TaskArtId);
		!moveTask(TaskArtId, BoardArtId);
		.
		
+!testTask(TaskArtId) : .random(N) & N > 0.6
	<-
		.print("Testing task ", TaskArtId);
		.wait(3000);
		.print("Bug found on task ", TaskArtId, "!");
		+bugFound;
		.
		
+!testTask(TaskArtId)
	<-
		.print("Testing task ", TaskArtId);
		.wait(3000);
		.print("Task ", TaskArtId, " tested!");
		.

+!moveTask(TaskArtId, BoardArtId) : bugFound
	<-
		moveTask(TaskArtId, "Testing", "Todo", "")[artifact_id(BoardArtId)];
		-bugFound;
		.		
		
+!moveTask(TaskArtId, BoardArtId)
	<-
		moveTask(TaskArtId, "Testing", "Done", "")[artifact_id(BoardArtId)];
		.
