<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사원들 목록보기</title>
<script type="text/javascript">
    //직원데이터 삭제시 한번 더 물어보는 함수
    function fnDel(no) {
        //메세지 박스에 "확인", "취소" 중에서 선택했을때 true 또는 false 리턴받는다.
        var result = confirm("데이터를 정말로 삭제하시겠습니까?");
        
        //"확인" 버튼을 클릭했으면? delSawon.jsp삭제페이지로 이동. 이동시 삭제할 직원 넘버를 넘겨주기.
        if(result == true){
            location.href="delSawon.jsp?no=" + no;
        }        
    } 
</script>
</head>
<body>
<%
    //한글처리
    request.setCharacterEncoding("UTF-8");
    //<검색기능> FORM태그에서 요청받은 검색기준값, 검색어 전달받아 저장
    String search = request.getParameter("search");
    String searchText = request.getParameter("searchText");
%>
 
<%--순서1. --%>
<h1>직원 정보 리스트</h1>
 
<%--직원 추가(회원가입)페이지로 이동하는 링크 --%>
<a href="addSawon.jsp">직원추가(회원가입)</a>
 
<%--검색기능 : 검색기준값 + 검색어 --%>
<form action="index.jsp" method="post">
    <select name="search">
        <option value="id">id</option>
        <option value="addr">근무지</option>
        <option value="dept">부서명</option>
    </select>
    <input type="text" name="searchText"/>
    <input type="submit" value="검색"/>
</form>
 
<%--직원 정보 리스트 --%>
<table border="1">
    <tr>
        <th>ID</th><th>이름</th><th>나이</th><th>근무지</th><th>부서명</th><th>내선번호</th>
        <th>수정</th><th>삭제</th>
    </tr>
    
<%--DB 작업 --%>
<%
//순서2. DB작업을 위한 java.sql패키지에 있는 삼총사 객체 저장할 변수 준비 및 DB접속정보 변수 준비
 
//1.DB연결을 위한 객체를 담을 변수
Connection con = null;
//2.DB연결 후 DB에 sql쿼리 실행할 객체를 담을 변수
Statement stmt = null;
 
//3.ResultSet 객체
// - DB로부터 실행된 결과값을 임시로 저장하는 객체 공간
// - 단! 하나의 테이블을 저장할 수 있는 구조
// - 반드시 처음에는 데이터를 가리키는 포인터를 한칸 이동시켜야 함.
ResultSet rs = null;
 
//연결할 DB주소, DB접속 id, pw
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:XE";
String id = "c##scott", pw="tiger";
 
 
//순서3. select SQL구문 준비 : 검색어가 입력되었다면? 입력되지 않았다면?
        
//SQL구문을 작성해서 저장할 변수
String sql = "";
 
try{
    //검색어가 입력 되지 않았다면? .. 모든 직원 정보 검색
    if(searchText.isEmpty()){
        sql = "select * from t_sawon";
                
    }else{//검색어가 입력 되었다면? .. 검색기준필드에 해당하는 검색어인 직원 정보를 모두 검색
        
        sql = "select * from t_sawon where " + search + " like '%" + searchText + "%'";
        
    }
    
}catch(NullPointerException e){ //처음에 검색어가 입력되지 않았을 때, 모든 직원 정보 리스트 뿌려주기 예외처리
    
    sql = "select * from t_sawon";
 
}
 
//순서4.
try{
    //1단계 JDBC드라이버 로딩
    Class.forName(driver);
 
    //2단계 DB연결  
    //DriverManager클래스의 getConnection메소드를 이용하여 접속할 DB정보를 전달한 후 DB와 연결한 정보를 지니고 있는 Connection객체를 얻는다.
    con = DriverManager.getConnection(url, id, pw);
    
    //3단계 DB에 sql구문을 전달 및 sql구문을 실행하는 객체 저장
    stmt = con.createStatement();
    
    //DB에
    //SQL SELECT 구문을 실행한 결과값은 Resultset객체에 담긴다.
    rs = stmt.executeQuery(sql);
    
    //4단계
    
    while(rs.next()){//테이블의 컬럼명을 커서 포인터로 가리키므로 반드시 한번은 next()메서드를 사용해줘야함.
        /*하나의 직원 정보 ResultSet(rs)에서 꺼내오기*/
        //DB로부터 select 한 결과값 중.
        //ResultSet객체에 저장된 하나의 DB레코드 정보중 no값을 꺼내와서 저장.
//         int no = rs.getInt("no"); //1
        String no = String.valueOf(rs.getInt("no")); // "1"
        
        //ResultSet객체에 저장된 하나의 DB레코드 정보중 id값을 꺼내와서 저장.
        String s_id = rs.getString("id");
//         String s_id = rs.getString(2); //getString(int columnindex)는 순서로 사용
        
        //ResultSet객체에 저장된 하나의 DB레코드 정보중 name값을 꺼내와서 저장.
        String s_name = rs.getString("name");        
        
        //ResultSet객체에 저장된 하나의 DB레코드 정보중 pass값을 꺼내와서 저장.
        String s_pass = rs.getString("pass");
        
        //ResultSet객체에 저장된 하나의 DB레코드 정보중 age값을 꺼내와서 저장.
        String s_age = rs.getString("age");
        
        //ResultSet객체에 저장된 하나의 DB레코드 정보중 addr값을 꺼내와서 저장.
        String s_addr = rs.getString("addr");
        
        //ResultSet객체에 저장된 하나의 DB레코드 정보중 dept값을 꺼내와서 저장.
        String s_dept = rs.getString("dept");
        
        //ResultSet객체에 저장된 하나의 DB레코드 정보중 extension값을 꺼내와서 저장.
        String s_extension = rs.getString("extension");
%>        
    <%--한사람씩 직원 정보 뿌려주기 --%>
    <tr>
    <th><%=s_id %></th>
    <th><%=s_name %></th>
    <th><%=s_age %></th>
    <th><%=s_addr %></th>
    <th><%=s_dept %></th>
    <th><%=s_extension %></th>
    <th><a href="modifySawon.jsp?no=<%=no%>">수정</a></th>
    <%--직원 삭제 페이지로 이동시 삭제할 직원 넘버를 넘겨주는데 정말로 삭제하시겠습니까? 한번 더 물어보기 --%>
    <th><a href="javascript:fnDel(<%=no%>)">삭제</a></th>
    </tr>
<%    
    
    }//While문
    
}catch(Exception err){
    
    System.out.println("index.jsp에서 오류 : " + err);
    
}finally{
    //자원해제
    if(rs != null) rs.close();
    if(stmt != null) stmt.close();
    if(con != null) con.close();
}
 
%>
    
</table>
</body>
</html>
