package model;

public class Likes {
	
	private int likeId; // pk(기본키)
	private int userId; // user의 PK, FK
	private int artworkId; // artwork의 PK, FK
	
	public Likes() { }
	
	public Likes(int likeId, int userId, int artworkId) {
		super();
		this.likeId = likeId;
		this.userId = userId;
		this.artworkId = artworkId;
	}
	
	public int getLikeId() {
		return likeId;
	}
	
	public void setLikeId(int likeId) {
		this.likeId = likeId;
	}
	
	public int getUserId() {
		return userId;
	}
	
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public int getArtworkId() {
		return artworkId;
	}
	
	public void setArtworkId(int artworkId) {
		this.artworkId = artworkId;
	}
}
