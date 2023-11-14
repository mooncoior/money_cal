<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html>

<head>
    <title>달력</title>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/cal.css">

    <script language="javaScript">
        window.onload = function () { buildCalendar(); }    // 웹 페이지가 로드되면 buildCalendar 실행

        var nowMonth = new Date();  // 현재 달을 페이지를 로드한 날의 달로 초기화
        var today = new Date();     // 페이지를 로드한 날짜를 저장
        today.setHours(0,0,0,0);    // 비교 편의를 위해 today의 시간을 초기화

        // 달력 생성 : 해당 달에 맞춰 테이블을 만들고, 날짜를 채워 넣는다.
        function buildCalendar() {

            var firstDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth(), 1);     // 이번달 1일
            var lastDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, 0);  // 이번달 마지막날

            var tbody_Calendar = document.querySelector(".Calendar > tbody");
            document.getElementById("calYear").innerText = nowMonth.getFullYear();             // 연도 숫자 갱신
            document.getElementById("calMonth").innerText = leftPad(nowMonth.getMonth() + 1);  // 월 숫자 갱신

            while (tbody_Calendar.rows.length > 0) {                        // 이전 출력결과가 남아있는 경우 초기화
                tbody_Calendar.deleteRow(tbody_Calendar.rows.length - 1);
            }

            var nowRow = tbody_Calendar.insertRow();        // 첫번째 행 추가           

            for (var j = 0; j < firstDate.getDay(); j++) {  // 이번달 1일의 요일만큼
                var nowColumn = nowRow.insertCell();        // 열 추가
            }

            for (var nowDay = firstDate; nowDay <= lastDate; nowDay.setDate(nowDay.getDate() + 1)) {   // day는 날짜를 저장하는 변수, 이번달 마지막날까지 증가시키며 반복  

                var nowColumn = nowRow.insertCell();        // 새 열을 추가하고

                nowColumn.innerText = leftPad(nowDay.getDate());      // 추가한 열에 날짜 입력
                <c:forEach var="cal" items="${requestScope.calMap.calList}" varStatus="vs">
            	if("${cal.schedule_start_date}".substr(0,4)==nowMonth.getFullYear()
            			&&"${cal.schedule_start_date}".substr(4,2)==leftPad(nowMonth.getMonth() + 1)
            			&&"${cal.schedule_start_date}".substr(6,2)==leftPad(nowDay.getDate())){
            		nowColumn.innerText = leftPad(nowDay.getDate())+'\n'+"${cal.subject}";
            		nowColumn.style.backgroundColor = "${cal.color}";
                    nowColumn.style.cursor = "pointer";
            		nowColumn.className = "${cal.cal_num}";
            	}
            	</c:forEach>
            	<c:forEach var="cal" items="${requestScope.calMap.calList}" varStatus="vs">
            	if("${cal.schedule_end_date}".substr(0,4)==nowMonth.getFullYear()
            			&&"${cal.schedule_end_date}".substr(4,2)==leftPad(nowMonth.getMonth() + 1)
            			&&"${cal.schedule_end_date}".substr(6,2)==leftPad(nowDay.getDate())){
            		nowColumn.innerText = leftPad(nowDay.getDate())+'\n'+"${cal.subject}";
            		nowColumn.style.backgroundColor = "${cal.color}";
                    nowColumn.style.cursor = "pointer";
            		nowColumn.className = "${cal.cal_num}";
            	}
            	</c:forEach>
            	
            	
                if (nowDay.getDay() == 0) {                 // 일요일인 경우 글자색 빨강으로
                    nowColumn.style.color = "#DC143C";
                }
                if (nowDay.getDay() == 6) {                 // 토요일인 경우 글자색 파랑으로 하고
                    nowColumn.style.color = "#0000CD";
                    nowRow = tbody_Calendar.insertRow();    // 새로운 행 추가
                }

                nowColumn.onclick = function () { 
                	choiceDate(this); 
                }
                
          
				

                
            }
        }

        // 날짜 선택 후 상세 페이지
        function choiceDate(nowColumn) {
            showPopup_detail($(nowColumn).attr("class"));
        }
        
        // 이전달 버튼 클릭
        function prevCalendar() {
            nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() - 1, nowMonth.getDate());   // 현재 달을 1 감소
            buildCalendar();    // 달력 다시 생성
        }
        // 다음달 버튼 클릭
        function nextCalendar() {
            nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, nowMonth.getDate());   // 현재 달을 1 증가
            buildCalendar();    // 달력 다시 생성
        }

        // input값이 한자리 숫자인 경우 앞에 '0' 붙혀주는 함수
        function leftPad(value) {
            if (value < 10) {
                value = "0" + value;
                return value;
            }
            return value;
        }
        
        
        function showPopup(){
            $(".popup_main").animate({ scrollTop: 0 }, "fast");
            $('.popup').show();   
            
         }
        function showPopup_detail(cal_num){
            $(".popup_main_detail").animate({ scrollTop: 0 }, "fast");
            $('.popup_detail').show();   
            $("[name='cal_num']").val(cal_num)
            
            ajax(
	           "/calDetail.do"
	           ,"post"
	           ,$("[name='upDelForm']")
	           ,function(json){
	            var data = json.calList[0];
				console.log(data);
	
	            $('.upDelForm').find('[name="subject"]').val(data.subject);
	            $('.upDelForm').find('[name="summary"]').val(data.summary);
	            $('.upDelForm').find('[name="schedule_start_date"]').val(data.schedule_start_date.substr(0,16));
	            $('.upDelForm').find('[name="schedule_end_date"]').val(data.schedule_end_date.substr(0,16));
	            $('.upDelForm').find('[name="color"]').val(data.color);
	            $('.upDelForm').find('[name="location"]').val(data.location);
	           }
	     	)
         }
        
        function update(){        	
        	var obj=$("[name='upDelForm']");
        	var check_subject = obj.find("[name='subject']");
        	var check_schedule_start_date = obj.find("[name='schedule_start_date']");
        	var check_schedule_end_date = obj.find("[name='schedule_end_date']");
        	var check_summary = obj.find("[name='summary']");
        	var check_location = obj.find("[name='location']");
        	var check_color = obj.find("[name='color']");
        	
       		if(check_subject.val()==null || check_subject.val()=='') {
       	        alert("일정 이름을 입력해주세요.");
       	     	check_subject.focus();
       	        return;
       	    }
       		if(check_schedule_start_date.val()==null || check_schedule_start_date.val()=='') {
       	        alert("시작일을 입력해주세요.");
       	     	check_schedule_start_date.focus();
       	        return;
       	    }
       		if(check_schedule_end_date.val()==null || check_schedule_end_date.val()=='') {
       	        alert("종료일을 입력해주세요.");
       	    		check_schedule_end_date.focus();
       	        return;
       	    }
       		if(check_schedule_start_date.val() > check_schedule_end_date.val()) {
       	        alert("시작일은 종료일을 초과할 수 없습니다.");
       	     	check_schedule_start_date.focus();
       	        return;
       	    }
       		
       		if(check_color.val()==null || check_color.val()=='') {
       	        alert("표시 색상을 선택해주세요.");
       	     	check_color.focus();
       	        return;
       	    }
       		

        	if( confirm("수정하시겠습니까?")==false ) { return; }
        	
        	ajax(
                    "/upCal.do"
                    ,"post"
                    ,$("[name='upDelForm']")
                    ,function(responseJson){
                        var upCnt = responseJson["upCnt"];
	                    if(upCnt==1){
	                    	alert("일정이 수정되었습니다.")
	                    	closePopup();
	                    }
	                    else{
	                    	alert("일정 수정 중 오류가 발생했습니다. 잠시 후 시도해주십시오.")
	                    }
                    }
               )
        	
        }
        
        
        function add(){
        	var obj=$("[name='schedulerForm']");
        	var check_subject = obj.find("[name='subject']");
        	var check_schedule_start_date = obj.find("[name='schedule_start_date']");
        	var check_schedule_end_date = obj.find("[name='schedule_end_date']");
        	var check_summary = obj.find("[name='summary']");
        	var check_location = obj.find("[name='location']");
        	var check_color = obj.find("[name='color']");
        	
       		if(check_subject.val()==null || check_subject.val()=='') {
       	        alert("일정 이름을 입력해주세요.");
       	     	check_subject.focus();
       	        return;
       	    }
       		if(check_schedule_start_date.val()==null || check_schedule_start_date.val()=='') {
       	        alert("시작일을 입력해주세요.");
       	     	check_schedule_start_date.focus();
       	        return;
       	    }
       		if(check_schedule_end_date.val()==null || check_schedule_end_date.val()=='') {
       	        alert("종료일을 입력해주세요.");
       	    		check_schedule_end_date.focus();
       	        return;
       	    }
       		if(check_schedule_start_date.val() > check_schedule_end_date.val()) {
       	        alert("시작일은 종료일을 초과할 수 없습니다.");
       	     	check_schedule_start_date.focus();
       	        return;
       	    }
       		
       		if(check_color.val()==null || check_color.val()=='') {
       	        alert("표시 색상을 선택해주세요.");
       	     	check_color.focus();
       	        return;
       	    }
        	
        	ajax(
                    "/addCal.do"
                    ,"post"
                    ,$("[name='schedulerForm']")
                    ,function(responseJson){
                        var addCnt = responseJson["addCnt"];
	                    if(addCnt==1){
	                    	alert("일정이 추가되었습니다.")
	                    	closePopup();
	                    }
	                    else{
	                    	alert("일정 추가 중 오류가 발생했습니다. 잠시 후 시도해주십시오.")
	                    }
                    }
               )
        }
        
        function cal_delete(){
        	if( confirm("삭제하시겠습니까?")==false ) { return; }
        	ajax(
                    "/delCal.do"
                    ,"post"
                    ,$("[name='upDelForm']")
                    ,function(responseJson){
                        var delCnt = responseJson["delCnt"];
	                    if(delCnt==1){
	                    	alert("일정이 삭제되었습니다.")
	                    	closePopup();
	                    }
	                    else{
	                    	delCnt("일정 삭제 중 오류가 발생했습니다. 잠시 후 시도해주십시오.")
	                    }
                    }
               )
        }
        
        function closePopup(){
            $('.popup').hide();
            location.reload();
        }
        
        
    </script>
</head>

<body>

    <form name="calendarForm" class="calendarForm">
    <table class="Calendar">
        <thead>
            <tr class="dateHeader" >
            <td colspan="1">
            </td>
                <td onClick="prevCalendar();" style="cursor:pointer;">&#60;</td>
                <td colspan="3">
                    <span id="calYear"></span>년
                    <span id="calMonth"></span>월
                </td>
                <td onClick="nextCalendar();" style="cursor:pointer;">&#62;</td>
                <td class="add" colspan="2" style="cursor:pointer" onclick="showPopup()" >
			        + 일정 추가
			    </td>
            </tr>
            <tr class="header">
                <td>일</td>
                <td>월</td>
                <td>화</td>
                <td>수</td>
                <td>목</td>
                <td>금</td>
                <td>토</td>
            </tr>
        </thead>

        <tbody class="calBody" style="border:1px solid lightgrey;">
        </tbody>
    </table>
    </form>
    <div class='popup'>
        <div class="dim">
          <div class='popup_main'>
                <form name="schedulerForm" class="schedulerForm">
                    <header class="title">새로운 일정 추가</header>
                    <div>
                        <div>일정 이름</div>
                        <div><input type="text" name="subject"></div>
                    </div>
                    <div>
                        <div>기간</div>
                        <div><input type="datetime-local" name="schedule_start_date">
                                ~ <input type="datetime-local" name="schedule_end_date"></div>
                    </div>
                    <div>
                        <div>내용</div>
                        <div>
                        <textarea name="summary" rows="5" cols="110">
						</textarea>
                        </div>
                    </div>
                    <div>
                        <div>장소</div>
                        <div><input type="text" name="location"></div>
                    </div>
                    <div>
                        <div>표시색상</div>
                        <div>
                            <select name="color">
                                <option></option>
                                <option style="background-color:#fe4d4d" value="#fe4d4d">빨강</option>
                                <option style="background-color:#fefca4" value="#fefca4">노랑</option>
                                <option style="background-color:#8fefa4" value="#8fefa4">초록</option>
                                <option style="background-color:#92ddfb" value="#92ddfb">파랑</option>
                                <option style="background-color:#dac5fb" value="#dac5fb">보라</option>
                                <option style="background-color:#fdd7ea" value="#fdd7ea">분홍</option>
                            </select>
                        </div>
                    </div>
                    <span onclick="add()" name="save" class="save" style="cursor: pointer;">저장</span>
                    <span onclick="closePopup()" name="cancel" class="cancel" style="cursor: pointer;">취소</span>
                </form>
            </div>
        </div>
    </div>
    <div class='popup_detail'>
        <div class="dim_detail">
          <div class='popup_main_detail'>
                <form name="upDelForm" class="upDelForm">
                    <header class="title">일정 수정</header>
        			<input type="hidden" name=cal_num>
                    <div>
                        <div>일정 이름</div>
                        <div><input type="text" name="subject"></div>
                    </div>
                    <div>
                        <div>기간</div>
                        <div><input type="datetime-local" name="schedule_start_date">
                                ~ <input type="datetime-local" name="schedule_end_date"></div>
                    </div>
                    <div>
                        <div>내용</div>
                        <div>
                        <textarea name="summary" rows="5" cols="110">
						</textarea>
                        </div>
                    </div>
                    <div>
                        <div>장소</div>
                        <div><input type="text" name="location"></div>
                    </div>
                    <div>
                        <div>표시색상</div>
                        <div>
                            <select name="color">
                                <option></option>
                                <option style="background-color:#fe4d4d" value="#fe4d4d">빨강</option>
                                <option style="background-color:#fefca4" value="#fefca4">노랑</option>
                                <option style="background-color:#8fefa4" value="#8fefa4">초록</option>
                                <option style="background-color:#92ddfb" value="#92ddfb">파랑</option>
                                <option style="background-color:#dac5fb" value="#dac5fb">보라</option>
                                <option style="background-color:#fdd7ea" value="#fdd7ea">분홍</option>
                            </select>
                        </div>
                    </div>
                    <span onclick="update()" name="update" class="update" style="cursor: pointer;">수정</span>
                    <span onclick="cal_delete()" name="delete" class="delete" style="cursor: pointer;">삭제</span>
                    <span onclick="closePopup()" name="cancel" class="cancel" style="cursor: pointer;">취소</span>
                </form>
            </div>
        </div>
    </div>
</body>

</html>