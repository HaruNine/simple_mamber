<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF8"%>
    <%@page import="java.sql.*"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>새로운 사원추가</title>
<style type="text/css">
    table {
        border-style: solid; border-width: 10px; 
        border-color: #1e90ff; width 300px;
     }
    th {
        background-color: #00ffff;
    }
    th, td {
        border-bottom-width: 5px;
        border-bottom-color: #1e90ff;
        border-bottom-style: dotted;
    }
 
</style>
</head>
<body>
 <%
    //1.index.jsp에서 전달한 수정할 직원번호 받아오기
    String no = request.getParameter("no");    
    
    //2.받아온 수정할 직원번호에 해당하는 직원레코드 검색 SELECT구문 작성
    String sql = "select * from t_sawon where no=" + no;
    
    //3.DB작업을 위한 java.sql패키지에 있는 삼총사 객체를 저장할 변수 선언
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    //4.연결할 DB정보를 변수에 저장
    //연결할 DB주소, DB접속id, pw
    String driver = "oracle.jdbc.driver.OracleDriver";
    String url = "jdbc:oracle:thin:@localhost:1521:XE";
    String id = "c##scott", pw="tiger";
 
    
    //addSawon_proc.jsp에 보낼 변수생성
    String a_id = null, a_name=null, a_pass=null, a_age=null, a_addr=null,
           a_extension = null, a_dept = null;
    
    //6. DB연결 , Statement객체 리턴,  select실행한 결과값을 ResultSet rs변수에 담기
    //   rs변수에 담긴 ResultSet에서 각각의 컬럼데이터 들을 꺼내와서  위5번 변수에 각각 담기
    try{
        //1단계  JDBC드라이버 로딩
        Class.forName(driver);
 
        //2단계  DB연결
        //DriverManager클래스의  getConnection메소드를 이용하여  접속할 DB정보를 전달한후   DB와연결한 정보를 지니고 있는 Connection객체를 얻는다.
        con = DriverManager.getConnection(url, id, pw);
        
        //3단계 DB에 sql구문을 전달 및 sql구문을 실행하는 객체 저장
        stmt = con.createStatement();
        
        //DB에 
        //SQL SELECt구문을 실행후 검색한 결과값은 ResultSet객체에 담긴다.
        rs = stmt.executeQuery(sql);
        
        if(rs.next()){
            a_id = rs.getString("id");
            a_name = rs.getString("name");
            a_pass = rs.getString("pass");
            a_age = String.valueOf(rs.getInt("age"));             
            a_addr = rs.getString("addr");
            a_extension = rs.getString("extension");
            a_dept = rs.getString("dept");
        }    
    }catch(Exception err){
        System.out.println("addSawon.jsp에서 쿼리오류 :" + err);
    }finally{
        //자원해제 
        if(rs != null) rs.close();
        if(stmt != null) stmt.close();
        if(con != null) con.close();
    }
%>
    <form action="addSawon_proc.jsp" method="post">
        <div align="center">
            <h1>직원추가</h1>
            <table>
                <tr>
                    <th>아이디</th>
                    <td><input type="text" name="a_id"></td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td><input type="text" name="a_name"></td>
                </tr>
                <tr>
                    <th>패스워드</th>
                    <td><input type="text" name="a_pass"></td>
                </tr>
                <tr>
                    <th>나이</th>
                    <td><input type="text" name="a_age"></td>
                </tr>        
                <tr>
                    <th>근무지</th>
                    <td>
                        <select name="a_addr">
                            <option value="서울">서울</option>
                            <option value="경기도">경기도</option>
                            <option value="인천">인천</option>        
                            <option value="수원">수원</option>        
                        </select>                    
                    </td>
                </tr>
                <tr>
                    <th>내선번호</th>
                    <td><input type="text" name="a_extension"></td>
                </tr>    
                <tr>
                    <th>부서명</th>
                    <td>
                        <select name="a_dept">
                            <option value="영업">영업</option>
                            <option value="기술">기술</option>
                            <option value="기획">기획</option>        
                            <option value="개발">개발</option>        
                        </select>                    
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="회원추가">&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="reset" value="초기화">&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="button" value="회원목록" onclick="location.href='index.jsp'">
                    </td>        
                </tr>    
            </table>        
        </div>
    </form>
</body>
</html>
