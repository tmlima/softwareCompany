package softwareCompany.gui;

import java.awt.Color;
import java.awt.Graphics;
import java.util.ArrayList;
import java.util.List;
import softwareCompany.gui.domain.Task;

public class BoardColumn {

	public static final int WIDTH = 170;
	private static final int DISTANCE_BETWEEN_POSTITS = 10;
	
	private String name;
	private List<Task> tasks;
	
	public String getName() {
		return name;
	}

	public BoardColumn(String name) {
		this.name = name;
		this.tasks = new ArrayList<Task>();
	}
	
	public void draw(Graphics g, int x) {
		int y = 100;
		g.setColor(Color.LIGHT_GRAY);
		g.fillRect(x, y, this.WIDTH, 500);

		x += 10;
		for(int i=0; i<tasks.size(); i++) {
			y += this.DISTANCE_BETWEEN_POSTITS + BoardTask.POSTIT_HEIGHT;
			new BoardTask(tasks.get(i)).draw(g, x, y);
		}
	}
	
	public void addTask(Task task) {
		this.tasks.add(task);
	}
	
	public Task popTask(String artifactId) {
		for (Task t : tasks) {
			if (t.getArtifactId().equals(artifactId)) {
				Task toPop = t;
				tasks.remove(t);
				return toPop;
			}
		}
		
		return null;
	}
}
