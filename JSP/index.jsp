<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/bootstrap.css">
	<title>JSP AJAX</title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript">
		var searchRequest = new XMLHttpRequest();
		var registerRequest = new XMLHttpRequest();
		function searchFunction(){
			//post; 값 보내기
			searchRequest.open("Post", "./UserSearchServlet?userName=" + encodeURIComponent(document.getElementById("userName").value), true);//서버와 통신할때는 URI
			searchRequest.onreadystatechange = searchProcess;//성공적으로 요청하는 동작이 끝났다면 searchProcess 실행할 수 있도록
			searchRequest.send(null);
			
		}
	
		function searchProcess(){
			var table = document.getElementById("ajaxTable");//ajaxTable이라는 id 가지는 테이블 가져오겠다.
			table.innerHTML = "";//안에 들은 내용을 빈공간으로 만들겠다.
			if(searchRequest.readyState == 4 && searchRequest.status == 200){//성공적으로 통신 이루어졌는지
				var object = eval('(' + searchRequest.responseText + ')');
				var result = object.result;//json(회원들의 정보가 담긴 배열)을 result로 받겠다.
				for(var i = 0; i < result.length; i++) {
					var row = table.insertRow(0);
					for(var j = 0; j < result[i].length; j++){//하나의 배열의 값이 끝날때까지
						var cell = row.insertCell(j);//해당 행에 하나의 셀 추가//이름, 나이, 성별 등
						cell.innerHTML = result[i][j].value;
					}
				}//사용자 데이터의 갯수만큼 행이 만들어지고 각각의 값으로 사용자의 정보가 들어가게 된다.
			}
		}
		function registerFunction(){
			registerRequest.open("Post", "./UserRegisterServlet?userName=" + encodeURIComponent(document.getElementById("registerName").value) +
										"&userAge="  + encodeURIComponent(document.getElementById("registerAge").value) +
										"&userGender="  + encodeURIComponent($('input[name=registerGender]:checked').val()) +
										"&userEmail="  + encodeURIComponent(document.getElementById("registerEmail").value), true);
			registerRequest.onreadystatechange = registerProcess;
			registerRequest.send(null);
		}
		function registerProcess(){
			if(registerRequest.readyState == 4 && registerRequest.status ==200){
				var result = registerRequest.responseText;
				if(result !=1){
					alert('등록이 실패했습니다.');
				}
				else{
					var userName = document.getElementById("userName");
					var registerName = document.getElementById("registerName");
					var registerAge = document.getElementById("registerAge");
					var registerEmail = document.getElementById("registerEmail");
					userName.value = "";//등록에 성공하면 공백으로 만들어준다.
					registerName.value = "";
					registerAge.value = "";
					registerEmail.value = "";
					searchFunction();
				}
			}
		}
		window.onload = function(){//모든 사용자의 정보가 목록으로 출력된다.
			searchFunction();
		}
		
	</script>
</head>
<body>
	<br>
	<div class="container">
		<div class="form-group row pull-right">
			<div class="col-xs-8">
				<input class="form-control" id="userName" onkeyup="searchFunction()"  type="text" size="20"><!-- onkeyup;입력할때마다 searchFunction 실행 -->
			</div>
			<div class="col-xs-2">
				<button class="btn btn-primary" onclick="searchFunction();" type="button">검색</button>
			</div>
		</div>
		<table class="table" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th style="background-color: #fafafa; text-align: center;">이름</th>
					<th style="background-color: #fafafa; text-align: center;">나이</th>
					<th style="background-color: #fafafa; text-align: center;">성별</th>
					<th style="background-color: #fafafa; text-align: center;">이메일</th>
				</tr>
			</thead>
			<tbody id="ajaxTable"></tbody> <!-- id값을 지정해줌으로써 자바스크립트가 일을 처리할 수 있도록 -->
		</table>
	</div>
	<div class="container">
		<table class="table" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="2" style="background-color: #fafafa; text-align:center;">회원등록</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="background-color: #fafafa; text-align:center;"><h5>이름</h5></td>
					<td><input class="form-control" type="text" id="registerName" size="20"></td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; text-align:center;"><h5>나이</h5></td>
					<td><input class="form-control" type="text" id="registerAge" size="20"></td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; text-align:center;"><h5>성별</h5></td>
					<td>
						<div class="form-group" style="text-align: center; margin: 0 auto;">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-primary active">
									<input type="radio" name="registerGender" autocomplete="off" value="남자" checked>남자
								</label>
								<label class="btn btn-primary">
									<input type="radio" name="registerGender" autocomplete="off" value="여자">여자
								</label>
								
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; text-align:center;"><h5>이메일</h5></td>
					<td><input class="form-control" type="text" id="registerEmail" size="20"></td>
				</tr>
				<tr>
					<td colspan="2"><button class="btn btn-primary pull-rigth" onclick="registerFunction();" type="button">등록</button></td>
				</tr>
			</tbody>
		</table>
	</div>

</body>
</html>