package com.naver.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	@Autowired
	private CalService calService;
	@Autowired
	private CalDAO calDAO;

	
	
	@RequestMapping(value="/calendar.do")
	public ModelAndView calendarList(
			CalendarDTO calendarDTO
			)
	{
		Map<String,Object> calMap = getCalMap(calendarDTO);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("calendar.jsp");	
		mav.addObject("calMap", calMap);
		return mav;
	}
	public Map<String,Object> getCalMap(
			CalendarDTO calendarDTO
	){
			
			Map<String,Object> resultMap = new HashMap<String,Object>();
			List<Map<String,String>> calList;
			calList = this.calDAO.getCalList(calendarDTO);
			
			resultMap.put("calList"	,calList);
			
			return resultMap;
	}
	
	@RequestMapping(
			 value="/calDetail.do",
			 method = RequestMethod.POST,
			 produces ="application/json;charset=UTF-8"
		)
		@ResponseBody
		public Map<String, Object> calDetail(
				CalendarDTO calendarDTO
		){
			Map<String, Object> calDetailMap = getCalDetailMap( calendarDTO );	
			return calDetailMap;
		}  
	
	public Map<String,Object> getCalDetailMap(
			CalendarDTO calendarDTO
	){
			Map<String,Object> resultMap = new HashMap<String,Object>();
			List<Map<String,String>> calList;
			calList = this.calDAO.getCalDetail(calendarDTO);
			
			resultMap.put("calList"	,calList);
			
			return resultMap;
	}
	
	   @RequestMapping(
	         value="/addCal.do" 
	         ,method=RequestMethod.POST
	         ,produces="application/json;charset=UTF-8"
	   )
	   @ResponseBody
	   public Map<String,String> addCal(  
			   CalendarDTO  calendarDTO

	   ){
	      Map<String,String> responseMap = new HashMap<String,String>();
	      int addCnt = 0;
	            try{
	            	addCnt = this.calService.addCal(calendarDTO);
	               }
	            catch(Exception ex){
	            	addCnt = -1;
	             }
	      responseMap.put("addCnt" , addCnt+"" );
		return responseMap;
		}
	   
	   @RequestMapping(
		         value="/upCal.do" 
		         ,method=RequestMethod.POST
		         ,produces="application/json;charset=UTF-8"
		   )
		   @ResponseBody
		   public Map<String,String> upCal(  
				   CalendarDTO  calendarDTO

		   ){
		      Map<String,String> responseMap = new HashMap<String,String>();
		      int upCnt = 0;
		            try{
		            	upCnt = this.calService.upCal(calendarDTO);
		               }
		            catch(Exception ex){
		            	upCnt = -1;
		             }
		      responseMap.put("upCnt" , upCnt+"" );
			return responseMap;
			}
	   
	   @RequestMapping(
		         value="/delCal.do" 
		         ,method=RequestMethod.POST
		         ,produces="application/json;charset=UTF-8"
		   )
		   @ResponseBody
		   public Map<String,String> delCal(  
				   CalendarDTO  calendarDTO

		   ){
		      Map<String,String> responseMap = new HashMap<String,String>();
		      int delCnt = 0;
		            try{
		            	delCnt = this.calService.delCal(calendarDTO);
		               }
		            catch(Exception ex){
		            	delCnt = -1;
		             }
		      responseMap.put("delCnt" , delCnt+"" );
			return responseMap;
			}
}
	
