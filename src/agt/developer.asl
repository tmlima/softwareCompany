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
		!getTask(TaskArtId, BoardArtId);
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

-!getTask(TaskArtIdString, BoardArtId)[error_msg(ErrorMsg)]  
	<-
		.print("Error when getting task from board:", ErrorMsg);
		.
			
+!codeTask(TaskArtIdString)
	<-
		.print("Developing task ", TaskArtIdString);
		.wait(5000);
		.print("Task ", TaskArtIdString, " developed!");
		.

+!doTask(TaskArtId) : boardArtId(BoardArtId)
	<-
		!codeTask(TaskArtId);
		!moveToTest(TaskArtId, BoardArtId);
		.

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
