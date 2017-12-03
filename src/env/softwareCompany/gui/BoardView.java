package softwareCompany.gui;

import java.util.List;

import javax.swing.JFrame;

import softwareCompany.gui.domain.Task;

public class BoardView extends JFrame {

	BoardPanel panel;
	
	public BoardView() {
		setSize(1250,1000);
		
		panel = new BoardPanel(this);
		
		setContentPane(panel);
	}

	public synchronized void update(List<BoardColumn> columns) {
		panel.update(columns);
		repaint();
	}
}
