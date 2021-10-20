package com.my.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.mapper.BlogMapper;

@Service
public class BlogService implements BlogServiceInterface {
	@Autowired
    private BlogMapper mapper;
	
	//===========================================================<<< select >>>============================================================================
	/* 메인에서 가장 최근글 10개 긁어오기 */
	@Override
	public List<HashMap<String, Object>> selectPost(Map<String, Object> map) throws Exception {
		return mapper.selectPost(map);
	}
	
	/* 댓글 가져오기 */
	@Override
	public List<HashMap<String, Object>> selectComment(Map<String, Object> map) throws Exception {
		return mapper.selectComment(map);
	}
	
	/* 카테고리 검색 */
	@Override
	public List<HashMap<String, Object>> selectCategory(Map<String, Object> map) throws Exception {
		return mapper.selectCategory(map);
	}
	
	/* 이웃 검색 */
	@Override
	public List<HashMap<String, Object>> selectNeighbor(Map<String, Object> map) throws Exception {
		return mapper.selectNeighbor(map);
	}

	/* 나를 추가한 이웃 목록 */
	@Override
	public List<HashMap<String, Object>> selectNeighborFollowMe(Map<String, Object> map) throws Exception {
		return mapper.selectNeighborFollowMe(map);
	}
	
	/* 이웃 여부 확인 */
	@Override
	public int checkMyNeighbor(Map<String, Object> map) throws Exception {
		return mapper.checkMyNeighbor(map);
	};

	/* 좋아요 검색 */
	@Override
	public int selectGood(Map<String, Object> map) throws Exception {
		return mapper.selectGood(map);
	}

	/* 좋아요 여부 확인*/
	@Override
	public int checkMyGood(Map<String, Object> map) throws Exception {
		return mapper.checkMyGood(map);
	}

	
	
	
	//===========================================================<<< insert >>>============================================================================
	//게시글 작성
	@Override
	public void insertPost(Map<String, Object> map) throws Exception {
		mapper.insertPost(map);
	}

	//댓글 작성
	@Override
	public void insertComment(Map<String, Object> map) throws Exception{
		mapper.insertComment(map);
	};

	//이웃 추가
	@Override
	public void insertNeighbor(Map<String, Object> map) throws Exception {
		mapper.insertNeighbor(map);
	}

	//좋아요 추가
	@Override
	public void insertGood(Map<String, Object> map) throws Exception {
		mapper.insertGood(map);
	}

	
	
	
	//===========================================================<<< update >>>============================================================================
	//게시글 수정
	@Override
	public void updatePost(Map<String, Object> map) throws Exception {
		mapper.updatePost(map);
	}

	//댓글 수정
	@Override
	public void updateComment(Map<String, Object> map) throws Exception{
		mapper.updateComment(map);
	};

	
	
	//===========================================================<<< delete >>>============================================================================
	//게시글 석제
	@Override
	public void deletePost(Map<String, Object> map) throws Exception {
		mapper.deletePost(map);
	}
	
	//댓글 삭제
	@Override
	public void deleteComment(Map<String, Object> map) throws Exception{
		mapper.deleteComment(map);
	}

	//특정 게시글에 대한 모든 댓글 삭제
	@Override
	public void deleteAllCommentForPost(Map<String, Object> map) throws Exception {
		mapper.deleteAllCommentForPost(map);
	}

	//이웃 취소
	@Override
	public void deleteNeighbor(Map<String, Object> map) throws Exception {
		mapper.deleteNeighbor(map);
	}

	//좋아요 취소
	@Override
	public void deleteGood(Map<String, Object> map) throws Exception {
		mapper.deleteGood(map);
	}

	//특정 게시글에 대한 모든 좋아요 취소
	@Override
	public void deleteAllGoodForPost(Map<String, Object> map) throws Exception {
		mapper.deleteAllGoodForPost(map);
	}
}
