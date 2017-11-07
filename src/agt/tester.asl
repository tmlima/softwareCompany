{ include("common.asl") }

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true <- .print("hello world.").

+doingTask(TaskArtId) : boardArtId(BoardArtId)
	<-
		!doTask(TaskArtId);
		moveTask(TaskArtId, "Testing", "Done")[artifact_id(BoardArtId)];
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
		moveTask(TaskArtIdString, "ToTest", "Testing", Name)[artifact_id(BoardArtId)];
		lookupArtifact(TaskArtIdString, TaskArtId);
		focus(TaskArtId);
		.
		
+!doTask(TaskArtId)
	<-
		.print("Testing task ", TaskArtId);
		.wait(10000);
		.print("Task ", TaskArtId, " tested!");
		.
		