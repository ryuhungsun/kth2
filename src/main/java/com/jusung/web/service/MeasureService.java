package com.jusung.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.jusung.web.dao.YhDAO;
import com.jusung.web.dto.CompanyDTO;
import com.jusung.web.dto.UserDTO;

import jakarta.annotation.Resource;

@Service
public class MeasureService {
	private static final Logger LOGGER = LoggerFactory.getLogger(MeasureService.class);

	@Autowired 
	private YhDAO yhDAO;
	
	//회사목록
	public List<?> selectCompanyList(CompanyDTO vo) throws Exception {
		
		return yhDAO.selectCompanyList(vo);
	}
//	public String insertCompany(CompanyVO vo) throws Exception{};
//	
	//즉정자목록
	public List<?> selectMeasurerList(String companyNo) throws Exception{
		LOGGER.debug("============ddd");
		return yhDAO.selectMeasurerList(companyNo);
	}
	
	//즉정목록
	public List<?> selectMeasureList(String measurerNo) throws Exception{
		return yhDAO.selectMeasureList(measurerNo);
	}
	
	//즉정저장
	public Integer saveMeasure(Map measure) throws Exception{
		if(yhDAO.selectMeasureYn(measure) == 0) {
			//파일 첨부여부체크
			if(measure.get("uploadYn").equals("Y")){
				
			}
			return yhDAO.insertMeasure(measure);
		}else{
			return yhDAO.updateMeasure(measure);
		}
	}
	
	public UserDTO logIn(UserDTO userDTO) throws Exception{
		return yhDAO.login(userDTO);
	}
}
