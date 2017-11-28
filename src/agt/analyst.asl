{ include("common.asl") }

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+project(ProjectName)
	<-	
		.print("Analysing requirments");
		.wait(5000);
		makeArtifact("requirements", "softwareCompany.tools.RequirementDocumentArt", [], DocumentArtId);
		focus(DocumentArtId);
		!signDocument;
		!sendRequirementsDocumentToUser(ProjectName);
		.

+bothApproved <- !createTasksFromRequirement.

+allTasksDone 
	<- 
		.print("All tasks done!");
		.wait(3000);
		!remove_tasks_from_board;
		!tell_developer_to_deploy;
		.	

+!sendRequirementsDocumentToUser(ProjectName)
	<-
		.send(proj_owner, tell, project(ProjectName));
		.
		
+!signDocument
	<-
		analystApproval[artifact_id(DocumentArtId)];
		.print("Requirements document approved");
		.

+!createTasksFromRequirement
	<-
		!createTask("crud1");
		!createTask("crud2");
		!createTask("crud3");
		!createTask("crud4");
		!createTask("crud5");
		!createTask("crud6");
		!createTask("crud7");
		!createTask("crud8");
		!createTask("crud9");
		!createTask("crud10");
		!createTask("crud11");
		!createTask("crud12");
  		.

+!createTask(TaskName) : .random(N) & N > 0
	<-
		.print("Creating task ", TaskName);
		Size = math.round(N * 10);
		.term2string(Size, SizeString);
		makeArtifact(TaskName, "softwareCompany.tools.TaskArt", [TaskName, SizeString], TaskArtId);
		focus(TaskArtId);
		!addTaskToBoard(TaskArtId);
		.
		
+!addTaskToBoard(TaskArtId) : artifactId(TaskId)[artifact_id(TaskArtId)] & size(TaskSize)[artifact_id(TaskArtId)]
	<-
		lookupArtifact("board", BoardArtId);
		focus(BoardArtId);
		.print("Adding task ", TaskId, " to board");
		.term2string(TaskId, TaskIdString);
		.term2string(TaskSize, TaskSizeString);
		addTask(TaskArtId, TaskIdString, TaskSize)[artifact_id(BoardArtId)]
		.
		
+!remove_tasks_from_board
	<-
		.print("Removing tasks from board");
		lookupArtifact("board", BoardArtId);
		focus(BoardArtId);
		removeAllTasks[artifact_id(BoardArtId)]
		.
	
+!tell_developer_to_deploy : play(Developer,developer,p_team)
	<-
		.print("Telling developer to deploy");
		.wait(1000);
		.send(Developer, tell, readyToDeploy);
		.
