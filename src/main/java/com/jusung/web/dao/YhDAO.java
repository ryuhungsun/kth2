/*
 * Copyright 2011 MOPAS(Ministry of Public Administration and Security).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.jusung.web.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.jusung.web.dto.CompanyDTO;
import com.jusung.web.dto.UserDTO;

@Repository
@Mapper
public interface YhDAO {
	/**
	 * 회사 목록을 조회한다.
	 * @param CompanyDTO - 조회할 정보가 담긴 VO
	 * @return 회사 목록
	 * @exception Exception
	 */
	List<CompanyDTO> selectCompanyList(CompanyDTO searchVO) throws Exception;
	
	/**
	 * 회사를 등록한다.
	 * @param vo - 등록할 정보가 담긴 CompanyVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	void insertCompany(CompanyDTO vo) throws Exception;

	/**
	 * 측정자 목록을 조회한다.
	 * @param CompanyDTO - 조회할 정보가 담긴 VO
	 * @return 측정자 목록
	 * @exception Exception
	 */
	List<?> selectMeasurerList(String companyNo) throws Exception;

	/**
	 * 측정 목록을 조회한다.
	 * @param CompanyDTO - 조회할 정보가 담긴 VO
	 * @return 측정 목록
	 * @exception Exception
	 */
	List<?> selectMeasureList(String measurerNo) throws Exception;

	/**
	 * 측정 데이터 여부를 조회한다.
	 * @param CompanyDTO - 조회할 정보가 담긴 VO
	 * @return 측정 목록
	 * @exception Exception
	 */
	int selectMeasureYn(Map measure) throws Exception;
	
	/**
	 * 측정 값을 수정한다.
	 * @param CompanyDTO - 조회할 정보가 담긴 VO
	 * @return 측정 목록
	 * @exception Exception
	 */
	Integer insertMeasure(Map measure) throws Exception;
	
	/**
	 * 측정 값을 수정한다.
	 * @param CompanyDTO - 조회할 정보가 담긴 VO
	 * @return 측정 목록
	 * @exception Exception
	 */
	Integer updateMeasure(Map measure) throws Exception;
	
	/**
	 * 측정 값을 수정한다.
	 * @param CompanyDTO - 조회할 정보가 담긴 VO
	 * @return 측정 목록
	 * @exception Exception
	 */
	UserDTO login(UserDTO userDTO) throws Exception;
}
