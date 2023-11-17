<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF8"%>
<%
//1. addSawon.jsp에서 전달받은 수정한 데이터들 한글처리
request.setCharacterEncoding("UTF-8");
//2. addSawon.jsp에서 전달 받은 수정한 데이터들 request영역에서 꺼내와서 각각의 변수저장
String a_id = request.getParameter("a_id");
String a_name = request.getParameter("a_name");
String a_pass = request.getParameter("a_pass");
String a_age = request.getParameter("a_age");
String a_addr = request.getParameter("a_addr");
String a_extension = request.getParameter("a_extension");
String a_dept = request.getParameter("a_dept");

 
//3. DB작업을 위한 java.sql 패키지에 있는 삼총사 객체중 2개
Connection con = null;
PreparedStatement pstmt = null;

 
//4. 연결할 DB정보를 변수에 저장
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:XE";
String id = "c##scott", pw="tiger";
 
//5. 오류확인을 위해 try문으로 구성
try {
    //1단계 Driver클래스 로드
    Class.forName(driver);
    
    //2단계 DB연결 시도(DB접속)
    con = DriverManager.getConnection(url, id, pw);
    
    //3단계 DB의 row값을 구하는 명령, 추가하는거니까 +1해줌
    Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
    ResultSet rs = stmt.executeQuery("SELECT id, no FROM t_sawon");
    rs.last(); //커서의 위치를 제일 뒤로 이동
    int rowCount = rs.getRow(); //현재 커서의 Row Index 값을 저장
    int a_no = rowCount+1; //구한 row값에 1증가시켜주기
    
    //4단계 DB에서 실행할 명령sql생성 및 addSawon.jsp에서 얻은값을 DB로 넣어줄 값 정리
    String sql = "INSERT INTO t_sawon  (id, pass, name, age, addr, dept, extension, no) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"; 
    
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, a_id);
    pstmt.setString(2, a_pass);
    pstmt.setString(3, a_name);
    pstmt.setString(4, a_age);
    pstmt.setString(5, a_addr);
    pstmt.setString(6, a_dept);
    pstmt.setString(7, a_extension);
    pstmt.setInt(8, a_no);


    
    //5단계 UPDATE 실행하고 끝낸다.
    pstmt.executeUpdate();
%>
    <script>
        alert("새로운 사원이 등록되었습니다");
        location.href="index.jsp"; //이동 
    </script>
<%    
}catch(Exception e){
    System.out.println("addSawon_proc.jsp에서 오류 : " + e);
    %>
    <script>
        alert("잘못 입력하셨습니다. 다시입력 부탁드립니다.");
        location.href="addSawon.jsp"; //이동 
    </script>
    <%   
}finally{
    //자원해제
    if(pstmt != null) pstmt.close();
    if(con != null) con.close();
}
 
%>