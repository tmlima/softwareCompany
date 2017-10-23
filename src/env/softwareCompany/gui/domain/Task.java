package softwareCompany.gui.domain;

public class Task {

	private String artifactId;
	private String name;
	private String personResponsible;
	
	public Task(String artifactId, String name) {
		this.artifactId = artifactId;
		this.name = name;
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
}
