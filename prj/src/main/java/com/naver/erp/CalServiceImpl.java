package com.naver.erp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CalServiceImpl implements CalService{
	@Autowired
	private CalDAO calDAO;
	
	@Override
	public int addCal(CalendarDTO calendarDTO) throws Exception{
		int addCnt = 0;
		addCnt = this.calDAO.addCal(calendarDTO);
		return addCnt;
	}
	@Override
	public int upCal(CalendarDTO calendarDTO) throws Exception{
		int upCnt = 0;
		upCnt = this.calDAO.upCal(calendarDTO);
		return upCnt;
	}
	@Override
	public int delCal(CalendarDTO calendarDTO) throws Exception{
		int delCnt = 0;
		delCnt = this.calDAO.delCal(calendarDTO);
		return delCnt;
	}
}
