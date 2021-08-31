package model;

import java.util.Date;

public class Artwork {

	private int artworkId; // pk(기본키)
	private int exhibitionId; // exhibition의 PK, FK
	private String title; // 작품 제목
	private String artworkAddress; // 작품 사진 주소 경로
	private String description; // 작품 설명
	private String artistName; // 작품 작가 이름
	private Date date; // 작품을 제작한 날짜
	private int viewCount; // 작품의 조회수
	private int likesCount; // 작품의 좋아요 수
	
	public Artwork() {}

	public Artwork(int artworkId, int exhibitionId, String title,  String artworkAddress, String description, String artistName, Date date,
			int viewCount, int likesCount) {
		super();
		this.artworkId = artworkId;
		this.exhibitionId = exhibitionId;
		this.title = title;
		this.artworkAddress = artworkAddress;
		this.description = description;
		this.artistName = artistName;
		this.date = date;
		this.viewCount = viewCount;
		this.likesCount = likesCount;
	}

	public int getArtworkId() {
		return artworkId;
	}

	public void setArtworkId(int artworkId) {
		this.artworkId = artworkId;
	}

	public int getExhibitionId() {
		return exhibitionId;
	}

	public void setExhibitionId(int exhibitionId) {
		this.exhibitionId = exhibitionId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getArtworkAddress() {
		return artworkAddress;
	}

	public void setArtworkAddress(String artworkAddress) {
		this.artworkAddress = artworkAddress;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getArtistName() {
		return artistName;
	}

	public void setArtistName(String artistName) {
		this.artistName = artistName;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public int getLikesCount() {
		return likesCount;
	}

	public void setLikesCount(int likesCount) {
		this.likesCount = likesCount;
	}

}
