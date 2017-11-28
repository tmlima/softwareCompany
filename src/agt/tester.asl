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
		
+!testTask(TaskArtIdString) : .random(N) & N > 0.6
	<-
		.print("Testing task ", TaskArtIdString);
		lookupArtifact(TaskArtIdString, TaskArtId);
		?size(Size)[artifact_id(TaskArtId)];		
		.term2string(SizeNumber, Size);
		.wait((SizeNumber * 1000) / 3);
		.print("Bug found on task ", TaskArtIdString, "!");
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
		!removePersonReponsible(TaskArtId);
		moveTask(TaskArtId, "Testing", "Todo", "")[artifact_id(BoardArtId)];
		-bugFound;
		.		
		
+!moveTask(TaskArtId, BoardArtId)
	<-
		!removePersonReponsible(TaskArtId);	
		moveTask(TaskArtId, "Testing", "Done", "")[artifact_id(BoardArtId)];
		.
