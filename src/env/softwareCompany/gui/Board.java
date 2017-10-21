package softwareCompany.gui;

import softwareCompany.gui.domain.Task;
import cartago.OPERATION;
import cartago.tools.GUIArtifact;

public class Board extends GUIArtifact {
	
	BoardView view;
	
	@Override
	public void init() {
		view = new BoardView();
		view.setVisible(true);
	}
	
	@OPERATION public void addTask(int id) {
		Task task = new Task(id);
		view.addTask(task);
		signal("taskAdded");
	}
	
	@OPERATION
	public void moveTask(int taskId, String columnFrom, String columnTo) {
		view.moveTask(taskId, columnFrom, columnTo);
//		signal("taskMoved");
	}
}
