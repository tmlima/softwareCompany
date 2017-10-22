package softwareCompany.gui;

import java.awt.Graphics;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JPanel;

public class BoardPanel extends JPanel {

	BoardView view;
	List<BoardColumn> columns;

	public BoardPanel(BoardView view) {
		this.view = view;
		columns = new ArrayList<BoardColumn>();
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

	public void update(List<BoardColumn> columns) {
		this.columns = columns;
	}

}