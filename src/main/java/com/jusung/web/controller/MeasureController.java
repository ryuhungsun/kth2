package com.jusung.web.controller;

import java.io.File;
import java.io.IOException;
import java.net.http.HttpRequest;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.json.JSONObject;
//import javax.annotation.Resource;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
//
//import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jusung.web.dto.BoardDTO;
import com.jusung.web.dto.CompanyDTO;
import com.jusung.web.dto.MeasureDTO;
import com.jusung.web.dto.MeasurerDTO;
import com.jusung.web.dto.UserDTO;
import com.jusung.web.service.MeasureService;
import com.jusung.web.service.TestService;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MeasureController { 
	private static final Logger LOGGER = LoggerFactory.getLogger(MeasureController.class);
	@Resource(name = "measureService")
	private MeasureService measureService;
	
	@Autowired 
	TestService testService;
	
	@GetMapping("/")
	public String wlcome(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if(session == null || session.getAttribute("userId") == null) {
			return "loginForm";
		}
		LOGGER.debug("Session : ++++++++> "+session.getAttribute("id"));
		return "main";
	}
	
	@RequestMapping(value="/main")
	public String main(HttpServletRequest request) {
		LOGGER.debug("Session : ++++++++> main");
		HttpSession session = request.getSession(true);
		LOGGER.debug("Session : ++++++++> "+ session.getAttribute("id"));
		if(session.getAttribute("userId") == null) {
			return "loginForm";
		}
		return "main";
	}
	
	//신체 측정
	@RequestMapping(value="/measure")
	public String yh(@ModelAttribute("searchVO") CompanyDTO searchVO, ModelMap model) throws Exception {
		List<?> companyList = measureService.selectCompanyList(searchVO);
		
		model.addAttribute("resultList", companyList);
		return "measure";
	}
	
	//측정자 목록
	@RequestMapping(value="/selectMeasurer")
	@ResponseBody
	public String selectMeasurer(@RequestParam("companyNo")  String companyNo, ModelMap model) throws Exception {
		//String companyNo= (String) model.get("companyNo");

		LOGGER.debug("=companyNo===33====>> "+companyNo);
		@SuppressWarnings("unchecked")
		List<MeasurerDTO> measurerList =  (List<MeasurerDTO>) measureService.selectMeasurerList(companyNo);
//		
		JSONObject json = new JSONObject();
		json.put("list", measurerList);
		LOGGER.debug("=json========>> "+json.toString());
		return json.toString();//sampleList;
	}	
//	
//	//측정 목록
	@RequestMapping(value="/measureList")
	@ResponseBody
	public String measureList(@RequestParam("measurerNo") String measurerNo, ModelMap model) throws Exception {
		List<MeasureDTO> measurerList = (List<MeasureDTO>) measureService.selectMeasureList(measurerNo);
		
		JSONObject json = new JSONObject();
		json.put("list", measurerList);
		LOGGER.debug(measurerNo+"=json========>> "+json.toString());
		return json.toString();//sampleList;
	}	

//	//측정 저장
	@RequestMapping(value="/saveMeasure")
	@ResponseBody
	public String saveMeasure(@RequestParam Map<String, Object> measure, ModelMap model) throws Exception {
		String measureDate= (String) measure.get("measureDate");
		String angle= (String) measure.get("angle");

		LOGGER.info(measureDate+"=json========>> "+angle);
		
		measureService.saveMeasure(measure);
		/*
		 * List<MeasureDTO> measurerList = (List<MeasureDTO>)
		 * measureService.selectMeasureList(measurerNo);
		 * 
		 * JSONObject json = new JSONObject(); json.put("list", measurerList);
		 */
		return "success";
	}
	
	@RequestMapping(value="/loginForm")
	public String loginForm(HttpServletRequest request, ModelMap model) {
		HttpSession session = request.getSession(false);
		if(session != null) {
			String userId = (String) session.getAttribute("userId");
			LOGGER.debug("loginForm-------------->>"+userId);
			model.addAttribute("login", userId);
		}
		LOGGER.info("loginForm------model-------->>"+model.getAttribute("login"));
		return "loginForm";
	}
	
	@RequestMapping(value="/login")
//	public String login(@RequestParam("id") String id, @RequestParam("pwd") String pwd, HttpServletRequest request, ModelMap model) {
	public String login(@ModelAttribute("userDTO") UserDTO userDTO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug(userDTO.getId()+"--------------login-------"+userDTO.getPwd());
		UserDTO loginDTO =measureService.logIn(userDTO);
		
		if(loginDTO != null) {
			LOGGER.debug(loginDTO.getId()+"--------------login OK-------"+loginDTO.getPwd());
			HttpSession session = request.getSession(true);
			// Session의 유효 시간 설정 (1800초 = 30분)
			session.setMaxInactiveInterval(1800);
			session.setAttribute("userId", loginDTO.getId());
			session.setAttribute("userName", loginDTO.getName());
			model.addAttribute("login", loginDTO);
			LOGGER.debug(session.getAttribute("userId")+"--------------login OK2-------"+session.getAttribute("userName"));
		
			return "main";
		}else {
			model.addAttribute("error", "ID / PWD가 일치하지 않습니다.");
			return "loginForm";
		}
	}
	
	@PostMapping(value = "/fileUpload")
	@ResponseBody
	public String result(@RequestParam("file1") MultipartFile multi,HttpServletRequest request,HttpServletResponse response, Model model)
    {
        String url = null;
        
        try {
 
            //String uploadpath = request.getServletContext().getRealPath(path);
            
            String originFilename = multi.getOriginalFilename();
            String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
            long size = multi.getSize();
            String saveFileName = originFilename;
            
//            LOGGER.debug("uploadpath : " + uploadpath);
            
            LOGGER.debug("originFilename : " + originFilename);
            LOGGER.debug("extensionName : " + extName);
            LOGGER.debug("size : " + size);
            LOGGER.debug("saveFileName : " + saveFileName);
            String path = System.getProperty("user.dir");
            LOGGER.debug("현재 작업 경로: " + path);
            String uploadpath = path+"/src/main/webapp/upload/tmp/";//c:\\Temp";
            LOGGER.debug("현재 작업 경로: " + uploadpath);
            
            if(!multi.isEmpty())
            {
            	HttpSession session = request.getSession(false);
            	LOGGER.debug("userId@@@@@@@@@@@@@@@@@@@@@>>> " + session.getAttribute("userId")+extName);
                File file = new File(uploadpath, session.getAttribute("userId")+extName);//multi.getOriginalFilename());
                multi.transferTo(file);
                
                model.addAttribute("filename", multi.getOriginalFilename());
                model.addAttribute("uploadPath", file.getAbsolutePath());
                
                //return "filelist";
                JSONObject json = new JSONObject();
        		json.put("file", session.getAttribute("userId")+extName);
        		LOGGER.debug("=json========>> "+json.toString());
        		return json.toString();
            }
        }catch(Exception e)
        {
            LOGGER.debug(e.toString());
        }
        return "success";
    }


	
	@GetMapping("/index")
	public String index(Model model) {
		model.addAttribute("test", "topmajor"); 
		List<BoardDTO> list = testService.boardList();
		
		model.addAttribute("list", list);
		for(int i=0; i < list.size();i++) {
		}
		return "index2";
	}
	
}
