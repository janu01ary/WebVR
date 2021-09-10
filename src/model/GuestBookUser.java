package model;

import java.util.Date;

public class GuestBookUser {
	private int gbID;//pk
	private String content;
	private Date date;
	private String nickname;//fk
	private int exhbId;//fk
	
	public GuestBookUser(int gbID, String nickname, int exhbId, String content, Date date) {
		super();
		this.gbID = gbID;
		this.content = content;
		this.date = date;
		this.nickname = nickname;
		this.exhbId = exhbId;
	}

	public int getGbID() {
		return gbID;
	}

	public void setGbID(int gbID) {
		this.gbID = gbID;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getExhbId() {
		return exhbId;
	}

	public void setExhbId(int exhbId) {
		this.exhbId = exhbId;
	}

}
