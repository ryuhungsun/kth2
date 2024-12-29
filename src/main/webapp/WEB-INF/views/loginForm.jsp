<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" />
<style>
   
   html,
   body {
     height: 100%;
   }
   
   body {
     display: flex;
     align-items: center;
     padding-top: 40px;
     padding-bottom: 40px;
     background-color: #f5f5f5;
   }
   
   .form-signin {
     width: 100%;
     max-width: 330px;
     padding: 15px;
     margin: auto;
   }
   
   .form-signin .checkbox {
     font-weight: 400;
   }
   
   .form-signin .form-floating:focus-within {
     z-index: 2;
   }
   
   .form-signin input[type="email"] {
     margin-bottom: -1px;
     border-bottom-right-radius: 0;
     border-bottom-left-radius: 0;
   }
   
   .form-signin input[type="password"] {
     margin-bottom: 10px;
     border-top-left-radius: 0;
     border-top-right-radius: 0;
   }

</style>
<script>
<c:if test="${null ne error}"> 
		alert("<c:out value='${error}'/>");
	</c:if>
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</head>
<body class="text-center" style="background-color:#ffffff">
   <main  class="form-signin">
   	<div  style="background-color:#f5f5f5" align="center">	
      <form action="login" method="post"><br/>
         <%-- <img class="mb-4" src="${pageContext.request.contextPath}/images/bootstrap-logo.svg" alt="" width="72" height="57"> --%>
         <h1 class="h3 mb-3 fw-normal">로그인 페이지<c:out value="${login}"/></h1>
         
         <div class="form-floating">
            <input type="text" class="form-control" id="id" name="id" placeholder="아이디 입력..." style="width:80%;">
            <!-- <label for="id">아이디</label> -->
         </div>
         <br/>
         <div class="form-floating">
            <input type="password" class="form-control" id="pwd" name="pwd" placeholder="Password"  style="width:80%;">
            <!-- <label for="pwd">비밀번호</label> -->
         </div>
         
         <div class="checkbox mb-3">
            <label>
               <input type="checkbox" value="remember-me"> 아이디 저장
            </label>
         </div>
         <button class="w-50 btn btn-lg btn-primary" type="submit" style="width: 50px;" >로그인</button>
         <br/>
         <p class="mt-5 mb-3 text-muted">&copy; copy right by JuSung Info.</p>
      </form>
      </div>
   </main>
</body>
</html>