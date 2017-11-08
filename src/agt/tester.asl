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
		.print("Found task ", TaskArtIdString, " todo");
		moveTask(TaskArtIdString, "ToTest", "Testing", Name)[artifact_id(BoardArtId)];
		lookupArtifact(TaskArtIdString, TaskArtId);
		focus(TaskArtId);
		.

+!doTask(TaskArtId) : boardArtId(BoardArtId)
	<-
		!testTask(TaskArtId);
		!moveToDone(TaskArtId, BoardArtId);
		.
		
+!testTask(TaskArtId)
	<-
		.print("Testing task ", TaskArtId);
		.wait(3000);
		.print("Task ", TaskArtId, " tested!");
		.
		
+!moveToDone(TaskArtId, BoardArtId)
	<-
		moveTask(TaskArtId, "Testing", "Done", "")[artifact_id(BoardArtId)];
		.