package com.jusung.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jusung.web.dao.TestDAO;
import com.jusung.web.dto.BoardDTO;

@Service
public class TestService {
	
	@Autowired
	private TestDAO testDAO;

	public List<BoardDTO> boardList() {
		return testDAO.boardList();
	}

}
