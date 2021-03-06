package com.synergy.socdoc.member;

public class PharmacyVO {

	private int pharmSeq;
	private String name;
	private String address;
	private String addressDetail;
	private String phone;
	private double latitude;
	private double longitude;
	private String mainImg;
	private String distance;
	private int avgRating;
	
	public PharmacyVO() {
		
	}

	public PharmacyVO(int pharmSeq, String name, String address, String addressDetail, String phone, double latitude,
			double longitude, String mainImg, String distance, int avgRating) {
		super();
		this.pharmSeq = pharmSeq;
		this.name = name;
		this.address = address;
		this.addressDetail = addressDetail;
		this.phone = phone;
		this.latitude = latitude;
		this.longitude = longitude;
		this.mainImg = mainImg;
		this.distance = distance;
		this.avgRating = avgRating;
	}

	public int getPharmSeq() {
		return pharmSeq;
	}

	public void setPharmSeq(int pharmSeq) {
		this.pharmSeq = pharmSeq;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddressDetail() {
		return addressDetail;
	}

	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public String getMainImg() {
		return mainImg;
	}

	public void setMainImg(String mainImg) {
		this.mainImg = mainImg;
	}

	public String getDistance() {
		return distance;
	}

	public void setDistance(String distance) {
		this.distance = distance;
	}

	public int getAvgRating() {
		return avgRating;
	}

	public void setAvgRating(int avgRating) {
		this.avgRating = avgRating;
	}
	
	
}
