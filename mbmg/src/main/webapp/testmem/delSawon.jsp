<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//1. index.jsp의 fnDel()함수에서 전달한 삭제할 직원 번호 받아오기
String no = request.getParameter("no");
 
//2. 전달받은 삭제할 직원 번호에 해당하는 직원 레코드 삭제 SQL구문 작성
String sql = "DELETE FROM t_sawon WHERE no=" + no; 
 
//3. DB작업을 위한 삼총사 객체중 2개 Connection 과 Statement 담을 변수 준비
Connection con = null;
Statement stmt = null;
 
//4. DB연결정보 저장 변수 만들기
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:XE";
String id = "c##scott", pw="tiger";
 
 
//5. DB연결
try{
    //5.1 Driver로드
    Class.forName(driver);
    //5.2 DB연결 객체 저장
    con = DriverManager.getConnection(url, id, pw);
    //5.3 Statement객체 리턴
    stmt = con.createStatement();
    //5.4 delete 구문실행
    stmt.executeUpdate(sql);
%>
    <script>
        alert("잘 삭제 되었습니다.");
        location.href="index.jsp"; //이동 
    </script>
<%        
}catch(Exception e){
    
}finally{
        //자원해제
        if(stmt != null) stmt.close();
        if(con != null) con.close();
}
%>