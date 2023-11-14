<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<title>스케줄러</title>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/boardList.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" integrity="sha512-5A8nwdMOWrSz20fDsjczgUidUBR8liPYU+WymTZP1lmY9G6Oc7HlZv156XqnsgNUzTyMefFTcsFH/tnJE/+xBg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script>
	
	function showAddPopUp(){
		
	}
	
	function add(){
		ajax(
				"/boardList.do"
				,"post"
				,$("[name='boardSearchForm']")
				,function(responseHtml){
					var obj = $(responseHtml);
					var searchResultCnt = obj.find(".searchResultCnt").html();
					var searchResult = obj.find(".search_list").html();
					var pageNos = obj.find(".pageNos").html();

					var html = 
					'<div class="isEmpty"><i class="fa fa-search" aria-hidden="true"></i>검색 결과가 없습니다.</div>';

					$(".searchResultCnt").html( searchResultCnt );
					$(".search_list").html( searchResult );
					$(".pageNos").html( pageNos );
					$('.searchResultCnt, .pageNos').show();

					if($('.impect').text() == 0 || $('.impect').text() == '0') {
						$(".search_list").html( html );
						$('.searchResultCnt, .pageNos').hide();
					}
				}
		);
	}
</script>
</head>
<body>
	<form name="schedulerForm" class="schedulerForm">
		<header>스케줄러</header>
				<input class="add_btn" type="button" value="add schedule" onclick="showAddPopUp()">
				
		<div class="search_list">	
			<div>
				<c:forEach var="board" items="${requestScope.boardMap.boardList}" varStatus="vs">
					<div onClick="goBoardDetailForm(${board.b_no})" class="search_con">
						<div class="b_no">${requestScope.boardMap.begin_serialNo_desc-vs.index}</div> 
						<div class="subject">${board.subject}</div>
						<div class="writer">${board.writer}</div>
						<div class="view_i">
							<div class="reg_date list_reg">
								<i class="fa fa-calendar-o" aria-hidden="true"></i>
                <span class="reg_date">${board.reg_date}</span>
							</div>
							<div class="readcount">
								<i class="fa fa-eye" aria-hidden="true"></i>
                <span>${board.readcount}</span>
							</div> 
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="pageNos"> 
			<span onClick="pageNoClick(1)"><i class="fa fa-angle-left" aria-hidden="true"></i><i class="fa fa-angle-left" aria-hidden="true"></i></span>
			<span onClick="pageNoClick(${requestScope.boardMap.selectPageNo}-1)"><i class="fa fa-angle-left" aria-hidden="true"></i></span>
			<c:forEach var="pageNo" begin="${requestScope.boardMap.begin_pageNo}" end="${requestScope.boardMap.end_pageNo}">
				<c:if test="${requestScope.boardMap.selectPageNo==pageNo}">
					<span class="isClick">${pageNo}</span>
				</c:if>
				<c:if test="${requestScope.boardMap.selectPageNo!=pageNo}">
					<span class="unClick" onClick="pageNoClick(${pageNo})">${pageNo}</span>
				</c:if>
			</c:forEach>
			<span onClick="pageNoClick(${requestScope.boardMap.selectPageNo}+1)"><i class="fa fa-angle-right" aria-hidden="true"></i></span>
			<span onClick="pageNoClick(${requestScope.boardMap.last_pageNo})"><i class="fa fa-angle-right" aria-hidden="true"></i><i class="fa fa-angle-right" aria-hidden="true"></i></span>
		</div>
	</form>

	<div>
		<form name="boardDetailForm" action="/boardDetailForm.do" post="post">
			<input type="hidden" name="b_no">
		</form>
	</div>
</body>
</html>