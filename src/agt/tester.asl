{ include("common.asl") }

+deployed : idle(IdleTime) <- .print("Idle time:", IdleTime).
		
+project(ProjectName) 
	<- 	
		.print("I was assigned to project ", ProjectName);
		lookupArtifact("board", BoardArtId);
		focus(BoardArtId);
		+boardArtId(BoardArtId);
		+idle(0);
		.
				
+idle(IdleTime) : boardArtId(BoardArtId) & firstTaskToTestArtId(TaskArtId)[artifact_id(BoardArtId)] & not(TaskArtId = "")
	<-
		!doTask(TaskArtId);
		-+idle(IdleTime);		
		.

+idle(IdleTime) : true <- !idle.

+!getTask(TaskArtIdString, BoardArtId) : .my_name(Name)
	<-
		.print("Found task ", TaskArtIdString, " to test");
		lookupArtifact(TaskArtIdString, TaskArtId);
		focus(TaskArtId);
		setPersonResponsible(Name)[artifact_id(TaskArtId)];
		?personResponsible(Responsible)[artifact_id(TaskArtId)];
		moveTask(TaskArtIdString, "ToTest", "Testing", Responsible)[artifact_id(BoardArtId)];
		.

-!getTask(TaskArtIdString, BoardArtId) : idle(IdleTime) <- -+idle(IdleTime).
		
+!doTask(TaskArtId) : boardArtId(BoardArtId)
	<-
		!getTask(TaskArtId, BoardArtId);
		!testTask(TaskArtId);
		!moveTask(TaskArtId, BoardArtId);
		.
		
+!testTask(TaskArtIdString) : .random(N) & N > 0.6
	<-
		.print("Testing task ", TaskArtIdString);
		lookupArtifact(TaskArtIdString, TaskArtId);
		?size(Size)[artifact_id(TaskArtId)];		
		.term2string(SizeNumber, Size);
		!testTime(SizeNumber);
		.print("Bug found on task ", TaskArtIdString, "!");
		+bugFound;
		.
		
+!testTask(TaskArtIdString)
	<-
		.print("Testing task ", TaskArtIdString);
		lookupArtifact(TaskArtIdString, TaskArtId);
		?size(Size)[artifact_id(TaskArtId)];		
		.term2string(SizeNumber, Size);
		!testTime(SizeNumber);
		.print("Task ", TaskArtIdString, " tested!");
		.
		
+!testTime(Size) <- .wait((Size * 3000) / 3).
		
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
