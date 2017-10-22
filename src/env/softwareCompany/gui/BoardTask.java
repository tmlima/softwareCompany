package softwareCompany.gui;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;

import softwareCompany.gui.domain.Task;

public class BoardTask {
	public static final int POSTIT_HEIGHT = 50;
	private static final int FONT_SIZE = 24;
	private Task task;
	
	public BoardTask(Task task) {
		this.task = task;
	}
	
	public void draw(Graphics g, int x, int y) {
		g.setColor(Color.WHITE);
		g.fillRect(x, y, 150, this.POSTIT_HEIGHT);
		g.setColor(Color.BLUE);
		g.setFont(new Font("Arial", Font.PLAIN, FONT_SIZE));
		g.drawString(task.getName(), x, y + FONT_SIZE);
	}
}
