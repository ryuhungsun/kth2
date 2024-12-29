package com.jusung.web.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.jusung.web.dto.BoardDTO;

@Repository
@Mapper
public interface TestDAO {

	List<BoardDTO> boardList();

}
