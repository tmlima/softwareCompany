{ include("common.asl") }

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

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
		lookupArtifact(TaskArtIdString, TaskArtId);
		focus(TaskArtId);
		setPersonResponsible(Name)[artifact_id(TaskArtId)];
		?personResponsible(Responsible)[artifact_id(TaskArtId)];
		moveTask(TaskArtIdString, "Todo", "Doing", Responsible)[artifact_id(BoardArtId)];
		.
			
+!codeTask(TaskArtIdString)
	<-
		.print("Developing task ", TaskArtIdString);
		lookupArtifact(TaskArtIdString, TaskArtId);
		?size(Size)[artifact_id(TaskArtId)];		
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
