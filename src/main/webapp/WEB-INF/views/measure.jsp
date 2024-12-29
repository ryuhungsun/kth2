<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <title>신체 측정</title>
  </head>
  <body>
  <br>
  <div style="width:100%;display: flex; justify-content: flex-end">
 	<input type="text" id="uploadYn" value="N"/>
   	<button type="button" class="btn btn-secondary btn-sm" onclick="clearCanvas()">지우기</button>&nbsp;&nbsp;
   	<button type="button" class="btn btn-primary btn-sm" onclick="saveMeasure()">저장</button>
  </div>	
  <table>
  	<tr>
  		
  		<td width="150px"style =' vertical-align : top '>
  			<select class="custom-select" id="companySelect" onchange =changeCompany(this.value)>
			  <option value="" selected>회사</option>			  
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<option value="<c:out value="${result.companyNo}"/>"><c:out value="${result.companyName}"/></option>			
				</c:forEach>
			</select>
  		</td>
  		<td width="120px" style =' vertical-align : top '>
  			<select class="custom-select" id="measurerSelect" onChange="changeMeasurerSelect(this.value)">
			  <option value="" selected>측정자</option>
			</select>
  		</td>
  		<td width="120px"style =' vertical-align : top '>
  			<input type="text" id="measureDate" placeholder="측정일" class="form-control" value="">
  		</td>
  		
  		<td width="180px">
  		<div class="input-group mb-3">
		  <div class="input-group-prepend">
		    <span class="input-group-text" id="basic-addon1">기준각도</span>
		  </div>
		  <input type="text" id="baseAngle" value="45" class="form-control" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1">
		</div>
  		</td>
  		<td width="150px">
  		<div class="input-group mb-3">
		  <input type="text" id="position1" class="form-control" placeholder="좌표1" readonly>
		</div>
  		</td>
  		<td width="150px">
  		<div class="input-group mb-3">
		  <input type="text" id="position2" class="form-control" placeholder="좌표2" readonly>
		</div>
  		</td>
  		<td width="100px">
  		<div class="input-group mb-3">
		  <input type="text" id="angle" class="form-control" placeholder="측정각도" readonly>
		</div>
  		</td>
  		<td width="100px">
  		<div class="input-group mb-3">
		  <input type="file" id="uploadFile" class="form-control" placeholder="첨부파일" readonly onchange="fileUpdoad()">
		</div>
  		</td>
  	</tr>
  </table>

<div width="100%" style="overflow: scroll;">
	<table>
		      <tr>
		        <td>
		          <canvas
		            id="myCanvas"
		            width="600"
		            height="450"
		            style="border: 1px solid #000000;margin:30;px"
		          >
		            Sorry, your browser does not support canvas.
		          </canvas>
		        </td>
		        <td style="vertical-align: top; padding: 10px; width: 1800" >
		          
		          <table class="table table-hover table-dark"id="measureTable" style="width:52	0px;border:1px solid blue;">
					  <thead>
					    <tr bgcolor='green'>
					      <th scope="col" width="120">날짜</th>
					      <th scope="col" width="200">목</th>
					      <th scope="col" width="200">어깨</th>
					      <th scope="col" width="60">각도</th>
					    </tr>
					  </thead>
					  <tbody>
					    <!-- <tr>
					      <th scope="row">1</th>
					      <td>Mark</td>
					      <td>Otto</td>
					      <td>@mdo</td>
					    </tr>
					    <tr>
					      <th scope="row">2</th>
					      <td>Jacob</td>
					      <td>Thornton</td>
					      <td>@fat</td>
					    </tr>
					    <tr>
					      <th scope="row">3</th>
					      <td colspan="2">Larry the Bird</td>
					      <td>@twitter</td>
					    </tr> -->
					  </tbody>
					</table>
		        </td>
		      </tr>
		    </table>
</div>
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
   <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   <script>
	
   $(document).ready(function() {
       //input을 datepicker로 선언
       $("#measureDate").datepicker({
           dateFormat: 'yy-mm-dd' //달력 날짜 형태
           ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
           ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
           ,changeYear: true //option값 년 선택 가능
           ,changeMonth: true //option값  월 선택 가능                
           //,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
           //,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
           ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
           ,buttonText: "선택" //버튼 호버 텍스트              
           ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
           ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
           ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
           ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
           ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
           ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
       });                    
       
       //초기값을 오늘 날짜로 설정해줘야 합니다.
       $('#measureDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
   });

    var measurerArray;// 측정자리스트 배열
    var measureArray;// 측정리스트 배열
    $(document).ready(function(){
		 init();
		 /* $('#measureDate').datepicker({
				dateFormat: "yy-mm-dd", 	//데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )

			});//datepicker end

			$('#measureDate').datepicker('setDate', 'today'); */
	})
      
      const canvas = document.getElementById("myCanvas");
      const ctx = canvas.getContext("2d");

      const unsplash = "data:image/jpeg;base64,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";
     //const unsplash ="https://mdn.github.io/shared-assets/images/examples/rhino.jpg"
     // const unsplash ="C:\Users\topma\OneDrive\사진\다운로드.png";
     //onst unsplash ="/images/egovframework/example/btn_bg_l.gif";
      const image = new Image();
      image.src = unsplash;
      image.onload = () => {
        ctx.drawImage(image, 0, 0, canvas.width, canvas.height);
      };
      var cnt = 0;
      var position1x = 0;
      var position1y = 0;
      var position2x = 0;
      var position2y = 0;
      canvas.addEventListener(
        "click",
        function (evt) {
          const ctx = canvas.getContext("2d");

          var mousePos = getMousePos(canvas, evt);
          cnt++;
          //   alert(mousePos.x + "," + mousePos.y + " || " + (cnt % 2));
          //   alert(position1x);

          if (cnt % 2 == 1) {
            position1x = mousePos.x;
            position1y = mousePos.y;

            point(mousePos.x, mousePos.y, ctx);
            // return;
          } else {
            position2x = mousePos.x;
            position2y = mousePos.y;

            point(mousePos.x, mousePos.y, ctx);
          }

          if (position1x == 0 || position2x == 0) {
            // alert("true : " + position1x + ", " + position2x);

            return false;
          } else {
            // alert("false : " + position1x + ", " + position2x);
          }

          ctx.beginPath();
          ctx.moveTo(position1x, position1y);
          ctx.lineTo(position2x, position2y); 

          ctx.moveTo(position1x, position2y);
          ctx.lineTo(mousePos.x, mousePos.y);
          ctx.lineWidth = 2;
          ctx.strokeStyle = "red";
          ctx.stroke();
          //각도
          const angle = 90 +
            ((Math.atan2(position2x - position1x, position2y - position1y) *
              180) /
              Math.PI) *
            -1;

          ctx.font = "13px serif";
          ctx.fillStyle = "black";
          if (position1x < position2x) {
            ctx.fillText(
              angle.toFixed(2) + "˚",
              position2x - 20,
              position2y - 10
            );
          } else {
            ctx.fillText(
              angle.toFixed(2) + "˚",
              position2x + 20,
              position2y - 10
            );
          }
          
          
          ///////////////////////////////////////////////////////////
         
          const baseAngle = -((document.getElementById("baseAngle").value /180) * Math.PI * -1);
          //alert(document.getElementById("baseAngle").value+"=========="+baseAngle);
        const x = Math.cos(baseAngle) * 100;
        const y = Math.sin(baseAngle) * 100;

        ctx.beginPath();
        ctx.moveTo(position1x, position1y); 
        ctx.lineTo(position1x + x, position1y + y)
        
        ctx.moveTo(position1x, position1y + y); 
        ctx.lineTo(position1x + x, position1y + y)
        ctx.strokeStyle = "blue";
        ctx.stroke()

        ctx.fillStyle = "white";
        ctx.fillRect(50, 35, 120, 20);
        ctx.fillRect(50, 65, 120, 20);
    
        ctx.fillStyle = "blue";
        ctx.fillText(//기준각도 표시
       "기준 각도 : "+document.getElementById("baseAngle").value + "˚",
            50,
            50
        );
        ctx.fillStyle = "red";
        ctx.fillText( //각도표시
            "각        도 : "+angle.toFixed(2) + "˚",
            50,
            80
        );

          //좌표출력
          document.getElementById("position1").value =
             + position1x.toFixed(2) + ", " + position1y.toFixed(2);
          document.getElementById("position1").style.color = "red";
          document.getElementById("position2").value =
             + position2x.toFixed(2) + ", " + position2y.toFixed(2);
          document.getElementById("position2").style.color = "red";
          document.getElementById("angle").value = angle.toFixed(4);
          document.getElementById("angle").style.color = "red";


          position1x = 0;
          position1y = 0;
          position2x = 0;
          position2y = 0;
        },
        false
      );

      //마우스 위치
      function getMousePos(canvas, evt) {
        var rect = canvas.getBoundingClientRect();
        return {
          x: evt.clientX - rect.left,
          y: evt.clientY - rect.top,
        };
      }

      //측정점 표시
      function point(x, y, canvas) {
        canvas.beginPath();
        canvas.arc(x, y, 5, 0, 2 * Math.PI, true);
        canvas.fillStyle = "blue"; //"red";
        canvas.fill();
      }

      //화면 지우기
      function clearCanvas() {
        // canvas
        var cnvs = document.getElementById("myCanvas");
        // context
        var ctx = canvas.getContext("2d");

        // 픽셀 정리
        ctx.clearRect(0, 0, cnvs.width, cnvs.height);


        //이미지 불러오기
        const unsplash =
            "data:image/jpeg;base64,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";

        const image = new Image();
        image.src = unsplash;
        image.onload = () => {
            ctx.drawImage(image, 0, 0, canvas.width, canvas.height);
        };
        // 컨텍스트 리셋
        ctx.beginPath();
      }
      //저장
      function saveMeasure() {
        //alert($('#companySelect').val()+"----"+$('#measurerSelect').find(":selected").val()+"----"+$('#measureDate').val()+"----"+$('#baseAngle').val()+"----"+$('#position1').val()+"----"+$('#position2').val()+"----"+$('#angle').val());
        
        $.ajax({
  		  url : "./saveMeasure",
  		  //dataType : 'json',
  		  data : {
  			measurerNo : $('#measurerSelect').find(":selected").val(),
    		measureDate : $('#measureDate').val(),
  		  	baseAngle : $('#baseAngle').val(),
  		  	position1 : $('#position1').val(),
  		  	position2 : $('#position2').val(),
  		  	angle : $('#angle').val(),
  		    uploadYn : $('uploadYn').val()
  		  },
  		  success : function(data) { 
  			  if(data=='success'){
  				alert("성공적으로 저장되었습니다.");
  				changeMeasurerSelect($("#measurerSelect").find(":selected").val());
  			  }else{
  				  alert("저장에 실패하였습니다.");
  			  }
			  
  		  }, 
  		  error:function(request,status,error){        
  			  /* alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 
  			  console.debug("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);    */    
  			alert("저장에 실패하였습니다.\n 데이터를 확인해 주세요.");
  		  }    		  
  	});
        
      }

      function init() { 
        var subHtml = "";
        
      }
      //측정목록 선택시
      function measureSelect(obj, cnt) {//alert(measureArray.length);
        for (i = 0; i < measureArray.length; i++) {
          //$("#measure" + i).style.backgroundColor = "#ffffff";
          $("#measure" + i).css('backgroundColor', '#000000')

        }
        obj.style.backgroundColor = "#777777";
        
        //clearCanvas();//화면지우기
        //이미지 불러오기
        const canvas = document.getElementById("myCanvas");
        const ctx = canvas.getContext("2d");

        const unsplash =
            "data:image/jpeg;base64,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";

        const image = new Image();
        image.src = unsplash;
        image.onload = () => {
            ctx.drawImage(image, 0, 0, canvas.width, canvas.height);
        };

        //시간조절
        setTimeout(() => measureDraw(cnt), 100)
      }
      
      //선택된 측정값 각도표시
      function measureDraw(cnt){//alert(cnt+"--"+measureArray[cnt].position1);
        position1x = measureArray[cnt].position1.split(", ")[0];
        position1y = measureArray[cnt].position1.split(", ")[1];
        position2x = measureArray[cnt].position2.split(", ")[0];
        position2y = measureArray[cnt].position2.split(", ")[1];
        baseAngle = measureArray[cnt].baseAngle;
        angle = measureArray[cnt].angle;
        measureDate = measureArray[cnt].measureDate;
        
        baseAngle2 = -((baseAngle /180) * Math.PI * -1);
        const canvas = document.getElementById("myCanvas");
        const ctx = canvas.getContext("2d");
        // alert("|"+position1x+"|"+"|"+position1y+"|");
        ctx.beginPath();
        ctx.moveTo(position1x, position1y);
        ctx.lineTo(position2x, position2y);

        ctx.moveTo(position1x, position2y);
        ctx.lineTo(position2x, position2y);
        ctx.lineWidth = 2;
        ctx.strokeStyle = "red";
        ctx.stroke();
        
        //기준각도 표시
        const x = Math.cos(baseAngle2) * 100;
        const y = Math.sin(baseAngle2	) * 100;
        ctx.beginPath();
        ctx.moveTo(parseFloat(position1x), parseFloat(position1y)); 
        ctx.lineTo(parseFloat(position1x) + x, parseFloat(position1y) + y)
        ctx.moveTo(parseFloat(position1x), parseFloat(position1y) + y); 
        ctx.lineTo(parseFloat(position1x) + x, parseFloat(position1y) +y )
        //ctx.lineTo(0,0	 )
        ctx.strokeStyle = "blue";
        ctx.stroke();
        
        angle = measureArray[cnt].angle;

        ctx.font = "13px serif";
        ctx.fillStyle = "white";
        ctx.fillRect(50, 35, 120, 20);
        ctx.fillRect(50, 65, 120, 20);
        
        ctx.fillStyle = "blue";
        ctx.fillText(//기준각도 표시
       "기준 각도 : "+ baseAngle + "˚",
            50,
            50
        );
        ctx.fillStyle = "red";
        ctx.fillText( //각도표시
            "각        도 : "+ angle + "˚",
            50,
            80
        );
          
        //   //좌표출력
        //   document.getElementById("position1").value =
        //      + position1x.toFixed(4) + ", " + position1y.toFixed(4);
        //   document.getElementById("position1").style.color = "red";
        //   document.getElementById("position2").value =
        //      + position2x.toFixed(4) + ", " + position2y.toFixed(4);
        //   document.getElementById("position2").style.color = "red";
        //   document.getElementById("angle").value = angle.toFixed(4);
        //   document.getElementById("angle").style.color = "red";
        //좌표출력
          document.getElementById("position1").value =
             + Number.parseFloat(position1x).toFixed(2) + ", " + Number.parseFloat(position1y).toFixed(2);
          document.getElementById("position1").style.color = "red";
          document.getElementById("position2").value =
             + Number.parseFloat(position2x).toFixed(2) + ", " + Number.parseFloat(position2y).toFixed(2);
          document.getElementById("position2").style.color = "red";
          document.getElementById("angle").value = Number.parseFloat(angle).toFixed(2);
          document.getElementById("angle").style.color = "red";
          document.getElementById("baseAngle").value = Number.parseFloat(baseAngle).toFixed(2);
          document.getElementById("measureDate").value = measureDate;

          
          position1x = 0;
          position1y = 0;
          position2x = 0;
          position2y = 0;
      }
      
      //회사영 선택시
      function changeCompany(no){
    	  $.ajax({
    		  url : "./selectMeasurer",
    		  dataType : 'json',
    		  data : {
    		    companyNo : no
    		  },
    		  success : function(data) {
    			  /* alert("dddd "+JSON.stringify(data));
    			  alert("list "+data.list);
    			   for(var i=0 in data.list){                                                        
    				  alert(i+"----33----"+data.list[i].companyName);
    			  }  */
    			  var measurerSelectHtml ="<option value='' selected>측정자</option>";
    			  data.list.forEach((element) => {
    				  //alert(element.measurerName);
    				  measurerSelectHtml +="<option value='"+element.measurerNo+"'>"+element.measurerName+"</option>";
    			  });	
    			  
    			  $("#measurerSelect").html(measurerSelectHtml);
    			  
    			  measurerArray = Array.from(data.list);
    			  //alert(measurerArray[0].measurerName);
    		  }, 
    		  error:function(request,status,error){        
    			  alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 
    			  console.debug("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       
    		  }    		  
    	});
      }
      //측정자 선택시
      function changeMeasurerSelect(no){
    	  $.ajax({
    		  url : "./measureList",
    		  dataType : 'json',
    		  data : {
    			  measurerNo : no
    		  },
    		  success : function(data) {
    			  //alert(data.list.length);
    			  var i=0;
    			  var measureListHtml =" <tr bgcolor='green'>"
							          +"    <td width='160'>날짜</td>"
							          +"    <td width='200'>목</td>"
							          +"    <td width='200'>어깨</td>"
							          +"    <td width='60'>각도</td>"
							          +"  </tr>";
    			  data.list.forEach((element) => {
    				  measureListHtml +="<tr onclick='measureSelect(this, "+i+")' id='measure"+i+"' >"
    				                  +"	<td>"+element.measureDate+"</td>"
    				                  +"	<td>"+element.position1+"</td>"
    				                  +"	<td>"+element.position2+"</td>"
    				                  +"	<td>"+element.angle+"</td>"
    				                  +"</tr>"
    				  i++;
    			  });	
    			  
    			  $("#measureTable").html(measureListHtml);
    			  measureArray = Array.from(data.list);  //측정목록 배열 세팅
    			  //measurerArray = Array.from(data.list);
    			  //alert(measurerArray[0].measurerName);
    		  }, 
    		  error:function(request,status,error){        
    			  alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 
    			  console.debug("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       
    		  }
    		  
    	});
      }
      
      function fileUpdoad(){
    	  
			var form = new FormData();
	        form.append( "file1", $("#uploadFile")[0].files[0] );
	        
	         jQuery.ajax({
	             url : "./fileUpload"
	           , type : "POST"
	           , dataType:"json"
	           , processData : false
	           , contentType : false
	           , data : form
	           , success:function(response) {
	               alert(response+" : 성공하였습니다. : "+response.file);  
	               console.log(response);
	               const canvas = document.getElementById("myCanvas");
	               const ctx = canvas.getContext("2d");

	               //const unsplash = "data:image/jpeg;base64,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";
	              //const unsplash ="https://mdn.github.io/shared-assets/images/examples/rhino.jpg"
	              // const unsplash ="C:\Users\topma\OneDrive\사진\다운로드.png";
	               const unsplash ="/upload/tmp/"+response.file;
	               const image = new Image();
	               image.src = unsplash;
	               image.onload = () => {
	                 ctx.drawImage(image, 0, 0, canvas.width, canvas.height);
	               };
	               
	               $('#uploadYn').val("Y");
	           }
	           ,error: function (jqXHR) 
	           { 
	               alert(jqXHR.responseText); 
	           }
	       });
      }
      
      
    </script>
  </body>
</html>