package softwareCompany.gui;

import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JPanel;

import softwareCompany.gui.domain.Task;
import cartago.OPERATION;

public class BoardPanel extends JPanel {

	BoardView view;
	List<BoardColumn> columns;

	public BoardPanel(BoardView view) {
		this.view = view;
		
		columns = new ArrayList<BoardColumn>();
		columns.add(new BoardColumn("Todo"));
		columns.add(new BoardColumn("Doing"));
		columns.add(new BoardColumn("Test"));
		columns.add(new BoardColumn("Done"));
	}
	
	public void paintComponent(Graphics g) {
		super.paintComponent(g);
		
		final int SPACE_BETWEEN_COLUMNS = 10;
		int x = 0;
		for (int i=0; i<columns.size(); i++) {
			x += SPACE_BETWEEN_COLUMNS + BoardColumn.WIDTH;
			columns.get(i).draw(g, x);
		}
	}
	
	public void addTask(Task task) {
		addTaskToColumn(task, "Todo");
	}
	
	public void moveTask(int taskId, String columnFrom, String columnTo) {
		Task task = getTaskFromColumn(taskId, columnFrom);
		addTaskToColumn(task, columnTo);		
	}
	
	private Task getTaskFromColumn(int taskId, String columnFrom) {
		for (BoardColumn c : columns) {
			if (c.getName() == columnFrom) {
				return c.popTask(taskId);
			}
		}
		
		throw new RuntimeException("Task " + taskId + " not found");
	}
	
	private void addTaskToColumn(Task task, String columnTo) {
		for (BoardColumn c : columns) {
			if (c.getName() == columnTo) {
				c.addTask(task);
			}
		}
	}
}