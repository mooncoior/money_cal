package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
@Mapper
public interface CalDAO {
	int addCal(CalendarDTO calendarDTO);
	int upCal(CalendarDTO calendarDTO);
	int delCal(CalendarDTO calendarDTO);
	List<Map<String,String>> getCalList(CalendarDTO calendarDTO);
	List<Map<String,String>> getCalDetail(CalendarDTO calendarDTO);
}
