package softwareCompany.gui;

import java.util.List;

import javax.swing.JFrame;

import softwareCompany.gui.domain.Task;

public class BoardView extends JFrame {

	BoardPanel panel;
	
	public BoardView() {
		setSize(1200,800);
		
		panel = new BoardPanel(this);
		
		setContentPane(panel);
	}

	public synchronized void update(List<BoardColumn> columns) {
		panel.update(columns);
		repaint();
	}
}
