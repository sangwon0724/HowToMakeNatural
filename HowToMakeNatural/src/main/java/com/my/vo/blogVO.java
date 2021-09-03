package com.my.vo;

import java.sql.Date;

public class blogVO {
	private int no; //글 번호
	private String title; //제목
	private String content; //내용
	private String category; //분류 - 블로그 내부
	private String tag; //분류 - 블로그 외부
	private Date signdate; //작성일
	private Date updateDate; //최종 수정일
	private String userID; //작성자 아이디
	private String userNickName; //작성자 닉네임
	private int good; //좋아요 개수
	
	private String object; //검색 항목
	private String search_text; //검색 단어
	private int page; //페이지 - 페이징용
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public Date getSigndate() {
		return signdate;
	}
	public void setSigndate(Date signdate) {
		this.signdate = signdate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserNickName() {
		return userNickName;
	}
	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}
	public int getGood() {
		return good;
	}
	public void setGood(int good) {
		this.good = good;
	}
	
	public String getObject() {
		return object;
	}
	public void setObject(String object) {
		this.object = object;
	}
	public String getSearch_text() {
		return search_text;
	}
	public void setSearch_text(String search_text) {
		this.search_text = search_text;
	}
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
}
