package softwareCompany.gui;

import softwareCompany.gui.domain.Task;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import cartago.ArtifactId;
import cartago.OPERATION;
import cartago.tools.GUIArtifact;

public class Board extends GUIArtifact {
	
	BoardView view;
	List<BoardColumn> columns;

	public static final String OBS_PROPERTY_FIRST_TASK_TODO_ART_ID = "firstTaskTodoArtId";
	public static final String OBS_PROPERTY_FIRST_TASK_TOTEST_ART_ID = "firstTaskToTestArtId";
	
	@Override
	public void init() {
		view = new BoardView();
		view.setVisible(true);
        defineObsProperty(OBS_PROPERTY_FIRST_TASK_TODO_ART_ID, "");
        defineObsProperty(OBS_PROPERTY_FIRST_TASK_TOTEST_ART_ID, "");
        
		columns = new ArrayList<BoardColumn>();
		columns.add(new BoardColumn("Todo"));
		columns.add(new BoardColumn("Doing"));
		columns.add(new BoardColumn("ToTest"));
		columns.add(new BoardColumn("Testing"));
		columns.add(new BoardColumn("Done"));
	}
	
	@OPERATION public void addTask(ArtifactId artifactId, String name) {
		Task task = new Task(artifactId.toString(), name);
		addTaskToColumn(task, "Todo");
		if (getObsProperty(OBS_PROPERTY_FIRST_TASK_TODO_ART_ID).getValue().toString().isEmpty())
			updateObsProperty(OBS_PROPERTY_FIRST_TASK_TODO_ART_ID, artifactId.toString());

		update();
	}

	@OPERATION public void moveTask(String taskArtId, String columnFrom, String columnTo, String personResponsible) {
		try {
			Task task = getTaskFromColumn(taskArtId, columnFrom);
			task.setPersonResponsible(personResponsible);
			addTaskToColumn(task, columnTo);
			update();			

			updateFirstTaskArtifactId(columnFrom);
			updateFirstTaskArtifactId(columnTo);
		}catch (Exception e) {
			e.printStackTrace();
			failed("MoveTask: " + e.getMessage());
		}
	}

	private void updateFirstTaskArtifactId(String column) {
		if  (columnHaveFirstTaskArtifactId(column)) {
			String obsProperty;
			if (column.equals("Todo"))
				obsProperty = OBS_PROPERTY_FIRST_TASK_TODO_ART_ID;
			else if (column.equals("ToTest"))
				obsProperty = OBS_PROPERTY_FIRST_TASK_TOTEST_ART_ID;
			else
				throw new RuntimeException(column);

			String artifactId = getFirstTaskArtifactId(getColumn(column));
			updateObsProperty(obsProperty, artifactId);			
		}
	}
	
	private boolean columnHaveFirstTaskArtifactId(String column) {
		return !column.equals("Doing") && !column.equals("Testing") && !column.equals("Done");		
	}
	
	private String getFirstTaskArtifactId(BoardColumn column) {
		String firstTaskArtifactId = "";
		if (!column.getTasks().isEmpty()) {
			firstTaskArtifactId = column.getTasks().get(0).getArtifactId();
		}

		return firstTaskArtifactId;		
	}
	
	private Task getTaskFromColumn(String taskArtifactId, String columnFrom) {
		BoardColumn column = getColumn(columnFrom);
		if (column != null) {
			Task task = column.popTask(taskArtifactId);	
			if (task != null)
				return task;
		}
		
		throw new RuntimeException("Task " + taskArtifactId + " not found");
	}
	
	private void addTaskToColumn(Task task, String columnTo) {
		getColumn(columnTo).addTask(task);
		update();
	}
	
	private BoardColumn getColumn(String columnName) {
		for (BoardColumn b : columns) {
			if (b.getName().equals(columnName))
				return b;
		}

		throw new RuntimeException("Unkown column: " + columnName);
	}
	
	private void update() {
		view.update(columns);
	}	
}
