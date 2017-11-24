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
		
+idle : boardArtId(BoardArtId) & firstTaskTodoArtId(TaskArtId)[artifact_id(BoardArtId)] & not(TaskArtId = "")
	<-
		-idle;
		!doTask(TaskArtId);
		+idle;
		.

+idle : true <- !idle.

+readyToDeploy <- !getOwnerApproval.
		
+deployApproved <- !deploy.



+!getTask(TaskArtIdString, BoardArtId) : .my_name(Name)
	<-
		.print("Found task ", TaskArtIdString, " todo");
		moveTask(TaskArtIdString, "Todo", "Doing", Name)[artifact_id(BoardArtId)];
		lookupArtifact(TaskArtIdString, TaskArtId);
		focus(TaskArtId);
		.
			
+!codeTask(TaskArtIdString)
	<-
		.print("Developing task ", TaskArtIdString);
		size(Size)[artifact_id(TaskArtIdString)];
		.term2string(SizeNumber, Size);
		.wait(SizeNumber * 1000);
		.print("Task ", TaskArtIdString, " developed!");
		.

+!doTask(TaskArtId) : boardArtId(BoardArtId)
	<-
		!getTask(TaskArtId, BoardArtId);
		!codeTask(TaskArtId);
		!moveToTest(TaskArtId, BoardArtId);
		.
		
-!doTask(TaskArtId)[error_msg(ErrorMsg)] <- .print("Error when doing task ", TaskArtId, ": ", ErrorMsg).		

+!moveToTest(TaskArtIdString, BoardArtId)
	<-
		moveTask(TaskArtIdString, "Doing", "ToTest", "")[artifact_id(BoardArtId)];
		.
-!moveToTest(TaskArtIdString, BoardArtId)[error_msg(ErrorMsg)]
	<-
		moveTask(TaskArtIdString, "Doing", "ToTest", "")[artifact_id(BoardArtId)];
		.

+!getOwnerApproval
	<-
		.print("Getting Owner approval");
		.send(proj_owner, tell, readyToDeploy);		
		.

+!deploy
	<-
		.print("Deploying");
		.wait(5000);
		.print("Deployed");
		.
