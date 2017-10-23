{ include("common.asl") }

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+createTasksForRequirement(RequirementName)
	<-
		.print("Creating tasks for project ", RequirementName).

+requirement(ProjectName, RequirementArtifactName)
	<-	
	!createTasksFromRequirement(RequirementArtifactName)
	.

+!createTasksFromRequirement(RequirementArtifactName)
	<-
		.concat(RequirementArtifactName, "_task1", TaskName1);
		!createTask(TaskName1);
		
		.concat(RequirementArtifactName, "_task2", TaskName2);
		!createTask(TaskName2);
      	.

+!createTask(TaskName)
	<-
		.print("Creating task ", TaskName);
		makeArtifact(TaskName, "softwareCompany.tools.TaskArt", [], TaskArtId);
		focus(TaskArtId);
		!addTaskToBoard(TaskArtId);
		.
		
+!addTaskToBoard(TaskArtId) : id(TaskId)[artifact_id(TaskArtId)]
	<-
		lookupArtifact("board", BoardArtId);
		focus(BoardArtId);
		.print("Adding task ", TaskId, " to board");
		.term2string(TaskId, TaskIdString);
		addTask(TaskArtId, TaskIdString)[artifact_id(BoardArtId)]
		.