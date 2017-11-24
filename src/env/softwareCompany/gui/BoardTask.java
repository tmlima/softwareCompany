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
		g.setColor(Color.YELLOW);
		g.fillRect(x, y, 150, this.POSTIT_HEIGHT);
		g.setColor(Color.BLUE);
		g.setFont(new Font("Arial", Font.PLAIN, FONT_SIZE));
		y += FONT_SIZE;
		g.drawString("Task " + task.getName() + " (" + task.getSize() + ")", x, y);
		y += FONT_SIZE;
		if (task.getPersonResponsible() != null)
			g.drawString(task.getPersonResponsible(), x, y);
	}
}
