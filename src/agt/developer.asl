{ include("common.asl") }

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true.

+project(ProjectName) 
	<- 	
		.print("I was assigned to project ", ProjectName);
		lookupArtifact("board", BoardArtId);
		focus(BoardArtId);
		+boardArtId(BoardArtId);
		+idle;
		.

+doingTask(TaskArtId) : boardArtId(BoardArtId)
	<-
		!doTask(TaskArtId);
		moveTask(TaskArtId, "Doing", "Test")[artifact_id(BoardArtId)];
		.
		
+idle : boardArtId(BoardArtId) & firstTaskTodoArtId(TaskArtId)[artifact_id(BoardArtId)] & not(TaskArtId = "")
	<-
		!getTask(TaskArtId, BoardArtId);
		-idle;
		+doingTask(TaskArtId);
		.

+idle : true <- !idle.

+!getTask(TaskArtIdString, BoardArtId) : .my_name(Name)
	<-
		.print("Found task ", TaskArtIdString, " todo");
		moveTask(TaskArtIdString, "Todo", "Doing", Name)[artifact_id(BoardArtId)];
		lookupArtifact(TaskArtIdString, TaskArtId);
		focus(TaskArtId);
		.

+!idle
	<- 
		.print("Any task todo found");
		.wait(5000); 
		-+idle
		.
		
+!doTask(TaskArtId)
	<-
		.print("Doing task ", TaskArtId);
		.wait(10000);
		.print("Task ", TaskArtId, " done!");
		.

