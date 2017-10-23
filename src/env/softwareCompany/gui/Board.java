package softwareCompany.gui;

import softwareCompany.gui.domain.Task;

import java.util.ArrayList;
import java.util.List;

import cartago.ArtifactId;
import cartago.OPERATION;
import cartago.tools.GUIArtifact;

public class Board extends GUIArtifact {
	
	BoardView view;
	List<BoardColumn> columns;

	public static final String OBS_PROPERTY_FIRST_TASK_TODO_ART_ID = "firstTaskTodoArtId";
	
	@Override
	public void init() {
		view = new BoardView();
		view.setVisible(true);
        defineObsProperty(OBS_PROPERTY_FIRST_TASK_TODO_ART_ID, "");
        
		columns = new ArrayList<BoardColumn>();
		columns.add(new BoardColumn("Todo"));
		columns.add(new BoardColumn("Doing"));
		columns.add(new BoardColumn("Test"));
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
		}catch (Exception e) {
			failed("MoveTask: " + e.getMessage());
		}
	}

	private Task getTaskFromColumn(String taskArtifactId, String columnFrom) {
		BoardColumn column = getColumn(columnFrom);
		if (column != null)
			return column.popTask(taskArtifactId);
		else		
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
