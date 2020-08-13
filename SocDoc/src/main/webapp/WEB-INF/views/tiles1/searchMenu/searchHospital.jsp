<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        
<%	String ctxPath = request.getContextPath();%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>속닥 - 병원 찾기</title>


</head>
<style>


	.container{
		width:1080px;
		margin: 100px auto;
	}
	
	.content{
		width:90%;
		margin:0px auto;
		min-width: 864px;
	}
		
	.select{
		width: 250px;
		height: 30px;
		border: 1px solid #999999;
		border-radius: .25em; 
		margin-right: 10px;
		margin-bottom: 5px;
	}
	
	.selectMap{
		width: 150px;
		height: 30px;
		border: 1px solid #999999;
		border-radius: .25em; 
		margin-right: 10px;
		margin-bottom: 5px;
	}
	
	
	ul.tabs{
		margin: 0px;
		padding: 0px;
		list-style: none;
	}
	
	ul.tabs li{
		background: none;
		display: inline-block;
 		padding: 10px 15px;
 		width:49.7%;
 		margin:0px;
		border: solid 1px #ddd;
		text-align: center;
		cursor: pointer;		
	}
	
	ul.tabs li.current{
		background: #0080ff;
		color: #fff;
		font-weight: 1000;
	}
	
	.tab-content{
		display: none;
	}
	
	.tab-content.current{
		display: inherit;
	}
	
	.tabGeneral{
		margin : 10px auto;
		background-color: #f2f2f2;
		padding:20px 35px;
	}
	
	.btnSearch{
  		padding: 0 .75em; 
 		height:30px;
		background-color: #bfbfbf; 
		cursor: pointer; 
		border: 1px solid #999999; 
		border-radius: .25em; 
		margin-left: -10px;	
	}
	
	.box1{
		padding-top: 20px;
	}
	
	.mapSelect{
		display:inline-block; 
		width:63%; 
		height:40px;
	}
	
	.mapSearch{
		display:inline-block; 
		width:35%; 
		height:40px;
		float:right;
		text-align:right;
	}
	
	.contentMap{
		float:clear;
		width:100%;
		height:800px;
	}
	
	.map{
		display:inline-block;
		width:63%;
		height:100%;
		margin-right: 10px;
	}
	
	.mapList{
		display:inline-block;
		background-color: #efefef; 
		float:right;
		width:35%;		
		height:100%;
		padding: 10px 20px;
		overflow : auto;
	}		
	
	.hospitalList{
		border-bottom : 1px solid #999999;
		padding: 10px 25px 20px 25px;
	}
	
	.mabListTable{
		width:100%;
		font-size: 10pt;
	}
	
	.mabListTable td{
		border-bottom: 1px solid #999999;	
		width:100%;	
		padding: 20px 0;	
	}
	
	.mHospitalName{
		font-size : 11pt;
		color:#0080ff; 
		font-weight: bolder;
		margin-bottom: 5px;
	}
	
	.hospitalName{
		font-weight: 900;
		font-size: 13pt;
		margin:0 10px 10px 0;
	}
	
	.btnDetail{
		border-radius: .25em; 
		cursor: pointer; 
		border: 1px solid #999999; 
	}
	
	.info{
		margin:0px;
	}
	
	
	.infoWindowCSS{
		padding:10px;
		border-radius: .25em;
		border: 1px solid #999999;  
		font-size: 9pt;
		background-color: #fff;
	}
	
	
	.hospitalListJSON{
		padding:10px;
		border-bottom: solid 1px #999999;
	}
	
	
	
	
	
	
	
	.wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 15px; font-weight: bold;}
    .info .close {position: absolute;top: 7px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 10px; height: 75px;}
    .desc .ellipsis {overflow: hidden; text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
    
    
    
    
    
    
	
	
	
	   
</style>

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b7fa563027be4561a627edb8c3c2821f"></script>
<script src=""></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/util/common.js" charset="utf-8"></script>
<script type="text/javascript">

	var mCurrentPage = 1;
	var mTotalPage = 1;
	var gCurrentPage = 1;
	var gTotalPage = 1;
	
	$(document).ready(function(){
		
		//지도
		var mapContainer = document.getElementById('map');		

		var options = {
			center: new kakao.maps.LatLng(37.56602747782394, 126.98265938959321), // 지도의 중심좌표.
			level: 3 // 지도의 레벨(확대, 축소 정도). 숫자가 적을수록 확대된다.
		};

		// 지도 생성 및 생성된 지도객체 리턴
		var mapobj = new kakao.maps.Map(mapContainer, options);		
		
		// 일반 or 스카이뷰 전환
		var mapTypeControl = new kakao.maps.MapTypeControl();
		mapobj.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

		// 지도 확대 축소를 제어컨트롤
		var zoomControl = new kakao.maps.ZoomControl(); 
		mapobj.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

		
		if (navigator.geolocation) {
			
			navigator.geolocation.getCurrentPosition(function(position) {
				var latitude = position.coords.latitude;   //위도
				var longitude = position.coords.longitude; //경도	
				var locPosition = new kakao.maps.LatLng(latitude, longitude);
				printMap(mapobj,locPosition);
				goSearch(mCurrentPage, latitude,longitude);

			});
		}
		else {

			var latitude= 37.56602747782394;
			var longitude = 126.98265938959321;	   	
			var locPosition = new kakao.maps.LatLng(latitude, longitude);
			printMap(mapobj,locPosition);
			goSearch(mCurrentPage, latitude,longitude);

		} 
		
		var imageSrcHere = "/socdoc/resources/images/locationPinHere.png";
		var imageSizeHere = new kakao.maps.Size(30, 50);
	    var imageOptionHere = {offset: new kakao.maps.Point(15, 35)};
	    var markerImageHere = new kakao.maps.MarkerImage(imageSrcHere, imageSizeHere, imageOptionHere);
		
		var markerHere = new kakao.maps.Marker({ 
			map:mapobj,
		    image:markerImageHere
		});
		
		
		
 		kakao.maps.event.addListener(mapobj, 'click', function(mouseEvent) {        
		    

			var latitude = mouseEvent.latLng.getLat();
			var longitude = mouseEvent.latLng.getLng();  
			var locPosition = new kakao.maps.LatLng(latitude, longitude);
			
			markerHere.setPosition(locPosition);
			mapobj.panTo(locPosition);
 
		});
		
 		var distanceKiloMeter = getDistance(37.504198, 127.047967, 37.501025, 127.037701, "kilometer");
		 
		$('#tabMap').click(function(){
			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');
			
			$('#tabMap').addClass('current');
			$('#contentMapTab').addClass('current');
			
			printMap(mapobj);
			goSearch(mapobj,mCurrentPage);
			
		})
		
		
		$('#tabGeneral').click(function(){
			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');
			
			$('#tabGeneral').addClass('current');
			$('#contentGeneralTab').addClass('current');
			
			printGeneral(gCurrentPage);
			
		})
		
		
	})
	
	
//--------------------------------------------------------------------------------------------------------------------------
	

	// 지도
	function printMap(mapobj,locPosition){
		
		mapobj.setCenter(locPosition);      

		$.ajax({ 
			url: "/socdoc/mapHospital.sd",
			async: false, //지도 비동기
			dataType: "JSON",
			success: function(json){ 
				
				var imageSrc = "/socdoc/resources/images/locationPinBlueG.png";       

				$.each(json, function(index, item){ 
				
					
					var latitude = item.latitude;
					var longitude = item.longitude;	
				
					var content = '<div class="wrap">' + 
		            '    <div class="info">' + 
		            '        <div class="title">' + 
		            	item.hpName + 
		            '            <div class="close" id="close" title="닫기"></div>' + 
		            '        </div>' + 
		            '        <div class="body">' + 
		            '            <div class="desc">' + 
		            '                <div class="ellipsis">' + item.address + 
		            '                <div class="jibun ellipsis">' + item.phone + 
		            '                <div><a href="" class="link">상세이동</a>' +
		            '				 <a href="https://map.kakao.com/link/map/현위치(약간틀림),'+latitude+','+longitude+'" style="color:blue;" target="_blank">큰지도</a>' +
		            '				 <a href="https://map.kakao.com/link/to/현위치,'+latitude+','+longitude+'" style="color:blue" target="_blank">길찾기</a></div>'+ 
		            '            </div>' +
		            '        </div>' + 
		            '    </div>' +    
		            '</div>';
		           
					displayMarker(mapobj, latitude, longitude, content, imageSrc);
		       		
				});	
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }
			
		});
		
	
	};
	
	
	var markers = [];

	// 마커 & 인포윈도우 표시 함수
	function displayMarker(mapobj, latitude, longitude, content, imageSrc) {
		
		var locPosition = new kakao.maps.LatLng(latitude, longitude);
		
		var imageSize = new kakao.maps.Size(30, 50);
	    var imageOption = {offset: new kakao.maps.Point(15, 35)};
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
	    
		var marker = new kakao.maps.Marker({ 
			map: mapobj, 
	        position: locPosition,
	        image: markerImage,
	        clickable: true
		}); 
	    
	    markers.push(marker);

		var overlay = new kakao.maps.CustomOverlay({
		    content: content,
		    position: locPosition,  
		    clickable: true
		}); 
		
		marker.ov = overlay;
		
 	    mapobj.setCenter(locPosition);   
 	    kakao.maps.event.addListener(marker, 'click', function() {
 			overlay.setMap(mapobj);
 			
 			$.each(markers, function(index, item){
 				if(item != marker){
 					item.ov.setMap(null);
 				}
 			}) 
 			mapobj.panTo(this.k);
 		});		
 	 
 	   $(document).on("click",".close",function(){
 	    	overlay.setMap(null);
 	   	})
		

 	    
 	
	} 
	
	 
	
	// 검색
	function goSearch(mCurrentPage,latitude,longitude){
		 
		 var content = "";
		 var pagebarM="";
		 var latitude0="";
		 var longitude0="";
			
		 $.ajax({ 
				url: "/socdoc/mapHospitalList.sd",
				data:{"city":$('#cityM').val(),"county":$('#countyM').val(),"district":$('#districtM').val()
					,"dept":$('#deptM').val()
					,"searchWord":$('#searchWordM').val(),"currentPage":mCurrentPage,"totalPage":mTotalPage
					,"latitudeHere":latitude,"longitudeHere":longitude},				
				dataType: "JSON",
				success: function(json){ 
					
					$.each(json, function(index, item){ 					
						/* 
						var latitude = item.latitude;
						var longitude = item.longitude;	 */
					
						content += "<tr><td>"
				      			+		"<div id='mHospitalName' class='mHospitalName'>"+item.hpName+"</div>"
				      			+		"<div id='mHospitaldept'>"+item.hpDept+"<span>"+item.distance+"</span></div>"
				      			+		"<div id='mHospitalTel'>"+item.phone+"</div>"
				      			+		"<div id='mHospitalAddress'>"+item.address+"</div>"
				      			+	"</td><tr>";
				      			
		      			if(index  == 0) {
							pagebarM = item.pageBarM;
							latitude0 = item.latitude;
							longitude0 = item.longitude;
						}
		      			
					});	
					
					var locPosition = new kakao.maps.LatLng(latitude0, longitude0);
				//	printMap(mapobj,locPosition);
					$(".mabListTable").html(content);
					$('#pageBarM').html(pagebarM);
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
				
			});
		 
		 
	}
	
	 
	// 거리계산
	function getDistance(lat1, lon1, lat2, lon2, unit) {
        
        theta = lon1 - lon2;
        dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
         
        dist = Math.acos(dist);
        dist = rad2deg(dist);
        dist = dist * 60 * 1.1515;
         
        if (unit == "kilometer") {
            dist = dist * 1.609344;
        } else if(unit == "meter"){
            dist = dist * 1609.344;
        }
 
        return (dist);
    }	 
	
	function deg2rad(deg) {
        return (deg * Math.PI / 180.0);
    }
     
    function rad2deg(rad) {
        return (rad * 180 / Math.PI);
    }
	
    
    
    

	// 일반탭 리스트
	function printGeneral(gCurrentPage){
			
		var html="";
		var pagebar="";
		
		$.ajax({
			
			url:"/socdoc/generalHospital.sd",
			data:{"city":$('#cityG').val(),"county":$('#countyG').val(),"district":$('#districtG').val()
				,"dept":$('#deptG').val(),"searchWord":$('#searchWordG').val(),"currentPage":gCurrentPage,"totalPage":gTotalPage},
			dataType:"JSON",
			success:function(json){
				
				$.each(json, function(index,item){							
				
				 	html+="<div class='hospitalListJSON'><span class='hospitalName'>"+item.hpName+"</span>"
				 		+"<button type='button' class='btnDetail' onClick='goDetail();'>상세보기</button>"
				 		+'<p class="info">'+item.hpdept+'</p>'
						+'<p class="info">'+item.phone+'</p>'
						+'<p class="info">'+item.address+'</p></div>';
						
					if(index  == 0) {
						pagebar = item.pageBar;		
					}
				})
					        	
				
				$(".hospitalList").html(html);					
				$('#pageBar').html(pagebar);
				printMap();
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    }
			
			
			
		});
	
		
	}
		
	
	
	
	
</script>



<body>

	<div class="container">
	
		<div class="content">
		
			<ul class="tabs">
				<li class="tab-link current" id="tabMap">지도</li>
				<li class="tab-link" id="tabGeneral">일반</li>
			</ul>
		
			<!-- 지도 -->
			<div id="contentMapTab" class="tab-content current">
				  <div class="box1">
				      <div class="mapSelect">
				         <select id="cityM" name="cityM" class="selectMap" onChange="cat1_change(this.value,countyM)">
				            <option value="">시도</option>  
							<option value='서울'>서울</option>
							<option value='부산'>부산</option>
							<option value='대구'>대구</option>
							<option value='인천'>인천</option>
							<option value='광주'>광주</option>
							<option value='대전'>대전</option>
							<option value='울산'>울산</option>
							<option value='강원'>강원</option>
							<option value='경기'>경기</option>
							<option value='경남'>경남</option>
							<option value='경북'>경북</option>
							<option value='전남'>전남</option>
							<option value='전북'>전북</option>
							<option value='제주'>제주</option>
							<option value='충남'>충남</option>
							<option value='충북'>충북</option>				                                           
				         </select>
				         <select id="countyM" name="countyM" class="selectMap" onChange="cat2_change(this.value,districtM)">
				            <option value="">군</option>                                 
				         </select>      
				         <select id="districtM" name="districtM" class="selectMap">
				            <option value="">구</option>                                 
				         </select>
				         <select id="deptM" name="deptM" class="selectMap">
				            <option value="">진료과</option> 
				            <option value="내과">내과</option> 
				            <option value="이비인후과">이비인후과</option>
				            <option value="정형외과">정형외과</option>
				            <option value="안과">안과</option>
				            <option value="치과">치과</option> 
				            <option value="외과">외과</option> 
				            <option value="성형외과">성형외과</option>   
				            <option value="정신건강의학과">정신건강의학과</option>
				            <option value="피부과">피부과</option>                              
				         </select>             
				      </div>
				      
				      <div class="mapSearch">
				         <input type="text" id="searchWordM" name="searchWordM" class="select" style="width:60%;">
				         <button type="button" class="btnSearch" onclick="goSearch(mCurrentPage);" >검색</button>
				      </div>
				 </div>
				   
				 <div class="contentMap">
				      <div id="map" class="map"></div>
				      <div class="mapList">
				      		<table class="mabListTable">				      			
				      		</table>	
				      		<div id="pageBarM" class="pageBar"></div>			      
				      </div>
				 </div>				
			</div>
			
			<!-- 일반 -->			
			<div id="contentGeneralTab" class="tab-content">
				<div>
					<div class="box1">
						<select id="cityG" name="city" class="select">
							<option value="">시</option>
						</select>
						<select id="countyG" name="county" class="select">
							<option value="">군</option>
						</select>
						<select id="districtG" name="district" class="select">
							<option value="">구</option>
						</select>
					</div>
					<div>
						<select id="deptG" name="dept" class="select">
							<option value="">진료과목</option>
						</select>
						<input type="text" id ="searchWordG" name="searchWordG" class="select"/>	
						<button type="button" class="btnSearch" onclick="goSearch();">검색</button>
					</div>					
				</div>
				
				<hr style="width:100%; border:solid 1px #999999; margin: 20px 0;">
				
				<div class="hospitalList">
								
				</div>
				
				<div id="pageBar" class="pageBar">${pageBar}</div>
				
			</div>
			
			
			
		</div>
		
	</div>

</body>