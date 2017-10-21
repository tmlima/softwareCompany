package softwareCompany.gui;

import javax.swing.JFrame;

import softwareCompany.gui.domain.Task;

public class BoardView extends JFrame {

	BoardPanel panel;
	
	public BoardView() {
		setSize(1200,800);
		
		panel = new BoardPanel(this);
		
		setContentPane(panel);
	}
	
	public synchronized void addTask(Task task) {
		panel.addTask(task);
		repaint();
	}
	
	public synchronized void moveTask(int taskId, String columnFrom, String columnTo) {
		panel.moveTask(taskId, columnFrom, columnTo);
		repaint();
	}
}
