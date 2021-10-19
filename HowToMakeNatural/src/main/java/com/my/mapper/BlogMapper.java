package com.my.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface BlogMapper {
	//select
	public List<HashMap<String, Object>> selectPost(Map<String, Object> map) throws Exception; //게시글 목록
	public List<HashMap<String, Object>> selectComment(Map<String, Object> map) throws Exception; //댓글 목록
	public List<HashMap<String, Object>> selectCategory(Map<String, Object> map) throws Exception; //카테고리 목록
	public List<HashMap<String, Object>> selectNeighbor(Map<String, Object> map) throws Exception; //이웃 목록
	public int checkMyNeighbor(Map<String, Object> map) throws Exception; //이웃 여부 확인
	public int selectGood(Map<String, Object> map) throws Exception; //좋아요 개수
	public int checkMyGood(Map<String, Object> map) throws Exception; //좋아요 여부 확인
	
	//insert
	public void insertPost(Map<String, Object> map) throws Exception; //게시글 추가
	public void insertComment(Map<String, Object> map) throws Exception; //댓글 추가
	public void insertNeighbor(Map<String, Object> map) throws Exception; //이웃 추가
	public void insertGood(Map<String, Object> map) throws Exception; //좋아요 추가
	
	//update
	public void updatePost(Map<String, Object> map) throws Exception; //게시글 수정
	public void updateComment(Map<String, Object> map) throws Exception; //댓글 수정
	
	//delete
	public void deletePost(Map<String, Object> map) throws Exception; //게시글 삭제
	public void deleteComment(Map<String, Object> map) throws Exception; //댓글 삭제
	public void deleteAllCommentForPost(Map<String, Object> map) throws Exception; //특정 게시글에 대한 모든 댓글 삭제
	public void deleteNeighbor(Map<String, Object> map) throws Exception; //이웃 취소
	public void deleteGood(Map<String, Object> map) throws Exception; //좋아요 취소
	public void deleteAllGoodForPost(Map<String, Object> map) throws Exception; //특정 게시글에 대한 모든 좋아요 취소
}
