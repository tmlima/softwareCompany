{ include("common.asl") }

experienceFactor(0).
		
+project(ProjectName) 
	<- 	
		.print("I was assigned to project ", ProjectName);
		lookupArtifact("board", BoardArtId);
		focus(BoardArtId);
		+boardArtId(BoardArtId);
		+idle(0);
		.
		
+deployed : idle(IdleTime) <- .print("Idle time:", IdleTime).		

+idle(IdleTime) : boardArtId(BoardArtId) & firstTaskTodoArtId(TaskArtId)[artifact_id(BoardArtId)] & not(TaskArtId = "")
	<-
		-idle(IdleTime);
		!doTask(TaskArtId);
		+idle(IdleTime);
		.

+idle(IdleTime) : true <- !idle.

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
			
+!codeTask(TaskArtIdString) : experienceFactor(Factor)
	<-
		.print("Developing task ", TaskArtIdString);
		lookupArtifact(TaskArtIdString, TaskArtId);
		?size(Size)[artifact_id(TaskArtId)];		
		.term2string(SizeNumber, Size);
		.wait((SizeNumber * 3000) - ((SizeNumber * 3000) * (Factor * 0.05)));
		!increaseExperience(SizeNumber);
		.print("Task ", TaskArtIdString, " developed!");
		.
+!increaseExperience(TaskSize) : experienceFactor(Factor) & ((Factor + TaskSize) < 10) <- -+experienceFactor(Factor + TaskSize).
+!increaseExperience(TaskSize) : experienceFactor(Factor) & ((Factor + SizeNumer) >= 10) <- -+experienceFactor(10).
	
+!doTask(TaskArtId) : boardArtId(BoardArtId)
	<-
		!getTask(TaskArtId, BoardArtId);
		!codeTask(TaskArtId);
		!moveToTest(TaskArtId, BoardArtId);
		.
		
-!doTask(TaskArtId)[error_msg(ErrorMsg)] <- -+idle.		

+!moveToTest(TaskArtIdString, BoardArtId)
	<-
		!removePersonReponsible(TaskArtId);
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
		.print("Telling admin package is ready");
		.wait(5000);
		.send(admin, tell, package_ready);		
		.
