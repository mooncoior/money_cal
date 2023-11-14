package com.naver.erp;

public interface CalService {
	int addCal(CalendarDTO calendarDTO) throws Exception;
	int upCal(CalendarDTO calendarDTO) throws Exception;
	int delCal(CalendarDTO calendarDTO) throws Exception;

}
