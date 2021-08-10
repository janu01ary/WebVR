package model;

public class CommentDTO {
	private int cmtID;//pk
	private String content;
	private String date;
	private int userID;//fk
	private int artwId;//fk
	
	public CommentDTO(int cmtID, String content, String date, int userID, int artwId) {
		super();
		this.cmtID = cmtID;
		this.content = content;
		this.date = date;
		this.userID = userID;
		this.artwId = artwId;
	}

	public int getCmtID() {
		return cmtID;
	}

	public void setCmtID(int cmtID) {
		this.cmtID = cmtID;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public int getArtwId() {
		return artwId;
	}

	public void setArtwId(int artwId) {
		this.artwId = artwId;
	}
	
	
}
