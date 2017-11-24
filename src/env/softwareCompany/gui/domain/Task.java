package softwareCompany.gui.domain;

public class Task {

	private String artifactId;
	private String name;
	private String personResponsible;
	private int size;
	
	public Task(String artifactId, String name, int size) {
		this.artifactId = artifactId;
		this.name = name;
		this.size = size;
	}

	public String getArtifactId() {
		return artifactId;
	}
	
	public String getName() {
		return name;
	}
	
	public void setPersonResponsible(String personResponsible) {
		this.personResponsible = personResponsible;
	}
	
	public String getPersonResponsible() {
		return personResponsible;
	}

	public int getSize() {
		return size;
	}
}
