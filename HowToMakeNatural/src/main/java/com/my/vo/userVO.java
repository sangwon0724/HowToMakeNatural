package com.my.vo;

public class userVO {
	//개인정보
	private String id;
	private String password;
	
	//블로그 관련 개인정보
	private String blog_nickname; //블로그 닉네임
	private String blog_profile_text; //블로그 소개글
	private String blog_logo_text; //블로그 배경글
	private String blog_logo_image; //블로그 배경글의 배경이미지 파일 주소
	private String blog_background_image; //블로그 전체 배경의 이미지 파일 주소
	private Character blog_setting_type; //블로그의 구성 타입

	//개인정보
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	//블로그 관련 개인정보
	public String getBlog_nickname() {
		return blog_nickname;
	}
	public void setBlog_nickname(String blog_nickname) {
		this.blog_nickname = blog_nickname;
	}
	public String getBlog_profile_text() {
		return blog_profile_text;
	}
	public void setBlog_profile_text(String blog_profile_text) {
		this.blog_profile_text = blog_profile_text;
	}
	public String getBlog_logo_text() {
		return blog_logo_text;
	}
	public void setBlog_logo_text(String blog_logo_text) {
		this.blog_logo_text = blog_logo_text;
	}
	public String getBlog_logo_image() {
		return blog_logo_image;
	}
	public void setBlog_logo_image(String blog_logo_image) {
		this.blog_logo_image = blog_logo_image;
	}
	public String getBlog_background_image() {
		return blog_background_image;
	}
	public void setBlog_background_image(String blog_background_image) {
		this.blog_background_image = blog_background_image;
	}
	public Character getBlog_setting_type() {
		return blog_setting_type;
	}
	public void setBlog_setting_type(Character blog_setting_type) {
		this.blog_setting_type = blog_setting_type;
	}
}
