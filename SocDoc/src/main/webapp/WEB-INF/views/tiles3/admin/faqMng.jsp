<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	h2 {
		font-weight: bold;
		padding-top: 30px;
	}
	
    
    table {
		width: 100%;
		border-collapse: collapse;
		margin-top: 25px;
	}
	
    th {
		font-size: 14px;
	    font-weight: bold;
	    color: #222222;
	    text-align: center;
	    padding: 17px 3px;
	    border-top: 1px solid #333333;
	    border-bottom: 1px solid #333333;
	}
	
	td {
		font-size: 14px;
	    color: #666666;
	    text-align: center;
	    padding: 17px 0;
	    border-bottom: 1px solid #dddddd;
	    line-height: 1.8;
	
	}
	
	th {
		text-align: center;
	}
	
	#faqList {
		width: 1000px;
		margin-left: auto;
		margin-right: auto;
	}
	
	#faqList:after {
		content: '';
		clear: both;
		display: block;
	}
	
	.faqTbl{
      width:100%;   
      margin: 30px 0;   
   }   
   
   td{
      border-top: 1px solid #999999;
      border-bottom: 1px solid #999999; 
      padding:25px !important;      
   }
   
   .answer {      
      background-color: #e6f5ff;
   }
   
   .addBtn {
      background-color: #0080ff;
      color:#fff;
      cursor: pointer;   
      border: 1px solid #dddddd;       
      padding: 0.25em .75em;    
      border-radius: .25em;       
      font-weight: 500;
      font-size: 10pt;  
      margin-bottom: 30px; 
   }
   
   .deleteBtn {
      background-color: #efefef;
      cursor: pointer;   
      border: 1px solid #dddddd;       
      padding: 0.25em .75em;    
      border-radius: .25em;       
      font-weight: 500;
      font-size: 10pt;   
      margin-right: 1
   }
	
    #ckAll {
      background-color: #efefef;
      cursor: pointer;   
      float: left;
      border: 1px solid #dddddd;       
      padding: 0.25em .75em;    
      border-radius: .25em;       
      font-weight: 500;
      font-size: 10pt;   
      margin-right: 1
    }


</style>

	<div id="container" style="min-height: 70vh;">
		
		<div id="faqList">
		
		   <h2>FAQ관리</h2>
			
		   <form name="deleteFrm">	
			   <table class="faqTbl">
			      <c:forEach var="faqvo" items="${faqvoList}">
				      <tr class="question">
				         <td><input type="checkbox" name="faqck" class="faqck" value="${faqvo.faqSeq}" /></td>
				         <td >${faqvo.question}</td>
				      </tr>
			      
				      <tr class="answer">
				         <td></td>
				         <td>${faqvo.answer}</td>
				      </tr>
				 </c:forEach>          
			   </table>
			   	<input type="hidden" id="faqJoin" name="faqJoin" />
           </form>
		   
		   <button type="button" id="ckAll" class="ckAll"> 전체선택 </button>
		   
		   <div align="right">
		      <button type="button" id="addBtn" class="addBtn" onclick="location.href='<%= ctxPath%>/faqWrite.sd'"> 추가 </button>
		      <button type="button" id="deleteBtn" class="deleteBtn"> 삭제 </button>   
		   </div>
            
		</div>
	
	</div>
	
	
<script type="text/javascript">
	$(document).ready(function($){	
		
		$("#ckAll").click(function(){
			
			if($("input:checkbox[name=faqck]").is(":checked")==true) {
	
				$("input[name=faqck]:checkbox").attr("checked", false);
			}
			else {
				$("input[name=faqck]:checkbox").attr("checked", true);
			}
			
		});
		
		$("#deleteBtn").click(function() {
			goDel();
		});
		
		
	});	 // end of $(document).ready(function($){}) ----------------------------
	
	
	function goDel() {
	    
	    var cnt = $("input[name='faqck']:checked").length;
	    
	    var arr = new Array();
	   
	    $("input[name='faqck']:checked").each(function() {
	        arr.push($(this).attr('id'));
	    });
	    
	    if(cnt == 0){
	        alert("선택된 글이 없습니다.");
	    }
	    else{
	       var con = confirm("삭제하시겠습니까?");
	       
	       var allCnt = $("input[name='faqck']").length;
	       
	       var faqArr = new Array();
	       
	       for(var i=0; i<allCnt; i++) {
	    	   
	    	   if($("input:checkbox[class=faqck]").eq(i).is(":checked")) {
	    		   	faqArr.push($("input:checkbox[class=faqck]").eq(i).val());   
	    	   }
	       }
	
	       var faqJoin = faqArr.join();
	       
	       $("#faqJoin").val(faqJoin);
	       
	    // alert(faqJoin);
	       
	       if(con == true) {
	          var frm = document.deleteFrm;
	          frm.method = "POST";
	          frm.action = "<%= request.getContextPath()%>/faqDel.sd"
	          frm.submit();
	       }
	       else if(con == false){ 
	          location.href="history.back()";
	
	       }
	    } 
	       
	 }

</script>