<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF8"%>
<%
//1. modifySawon.jsp에서 전달받은 수정한 데이터들 한글처리
request.setCharacterEncoding("UTF-8");
//2. modifySawon.jsp에서 전달 받은 수정한 데이터들 request영역에서 꺼내와서 각각의 변수저장
String no = request.getParameter("no");
String s_id = request.getParameter("s_id");
String s_name = request.getParameter("s_name");
String s_pass = request.getParameter("s_pass");
String s_age = request.getParameter("s_age");
String s_addr = request.getParameter("s_addr");
String s_extension = request.getParameter("s_extension");
String s_dept = request.getParameter("s_dept");
 
//3. hidden으로 넘겨받은 직원번호에 해당하는 직원 정보 업데이트 처리 SQL구문 작성
String sql = "UPDATE t_sawon set id='"+s_id+"',name='"+s_name+"',pass='"+s_pass+"',age='"+s_age+"',addr='"+s_addr+"',extension='"+s_extension+"',dept='"+s_dept+"' where no="+no; 
 
//4. DB작업을 위한 java.sql 패키지에 있는 삼총사 객체중 2개
Connection con = null;
Statement stmt = null;
 
//5. 연결할 DB정보를 변수에 저장
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:XE";
String id = "c##scott", pw="tiger";
 
 
//6.
try {
    //1단계 Driver클래스 로드
    Class.forName(driver);
    
    //2단계 DB연결 시도(DB접속)
    con = DriverManager.getConnection(url, id, pw);
    
    //3단계 DB에 UPDATE구문을 실행할 Statement객체 리턴 받아오기
    stmt = con.createStatement();
    
    //4단계 UPDATE 실행하고 끝낸다.
    stmt.executeUpdate(sql);
%>
    <script>
        alert("잘 수정 되었습니다.");
        location.href="index.jsp"; //이동 
    </script>
<%    
}catch(Exception e){
    System.out.println("modifySawon_proc.jsp에서 오류 : " + e);
}finally{
    //자원해제
    if(stmt != null) stmt.close();
    if(con != null) con.close();
}
 
%>
 