<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사원정보 변경</title>
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
 
    
    //5. select한 결과 값은 resultSet에 저장된다.
    //  resultSet에 저장된 하나의 레코드중!!! 각각의 컬럼에 있는 데이터를 담을 변수들 준비
    String s_id = null, s_name=null, s_pass=null, s_age=null, s_addr=null,
           s_extension = null, s_dept = null;
    
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
            s_id = rs.getString("id");
            s_name = rs.getString("name");
            s_pass = rs.getString("pass");
            s_age = String.valueOf(rs.getInt("age"));             
            s_addr = rs.getString("addr");
            s_extension = rs.getString("extension");
            s_dept = rs.getString("dept");
        }    
    }catch(Exception err){
        System.out.println("modifySawon.jsp에서 쿼리오류 :" + err);
    }finally{
        //자원해제 
        if(rs != null) rs.close();
        if(stmt != null) stmt.close();
        if(con != null) con.close();
    }
%>
<%--7. 수정전 직원정보를 뿌려주면서... 수정할 정보가 있으면 입력후 실제  직원정보 수정을 위한 DB작업할 modifySawon_proc.jsp페이지에 요청 --%>
    <form action="modifySawon_proc.jsp" method="post">
    
        <%--수정할 직원 번호  hidden으로  input태그가 보이지 않고 값만 전달 --%>
        <input type="hidden" name="no" value="<%=no%>">
    
        <div align="center">
            <h1>직원수정</h1>
            <table>
                <tr>
                    <th>아이디</th>
                    <td><input type="text" name="s_id" value="<%=s_id%>"></td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td><input type="text" name="s_name" value="<%=s_name%>"></td>
                </tr>
                <tr>
                    <th>패스워드</th>
                    <td><input type="text" name="s_pass" value="<%=s_pass%>"></td>
                </tr>
                <tr>
                    <th>나이</th>
                    <td><input type="text" name="s_age" value="<%=s_age%>"></td>
                </tr>
                <tr>
                    <th>근무지</th>
                    <td>
                        <select name="s_addr">
                            <option value="서울"<%if(s_addr.equals("서울")){%>selected<%}%>>서울</option>
                            <option value="경기"<%if(s_addr.equals("경기")){%>selected<%}%>>경기</option>
                            <option value="인천"<%if(s_addr.equals("인천")){%>selected<%}%>>인천</option>
                            <option value="수원"<%if(s_addr.equals("수원")){%>selected<%}%>>수원</option>
                        </select>                    
                    </td>
                </tr>
                <tr>
                    <th>내선번호</th>
                    <td><input type="text" name="s_extension" value="<%=s_extension%>"></td>
                </tr>
                <tr>
                    <th>부서명</th>
                    <td>
                        <select name="s_dept">
                            <option value="영업" <%if(s_dept.equals("영업")){%>selected<%} %>>영업</option>
                            <option value="기술" <%if(s_dept.equals("기술")){%>selected<%} %>>기술</option>
                            <option value="기획" <%if(s_dept.equals("기획")){%>selected<%} %>>기획</option>
                            <option value="개발" <%if(s_dept.equals("개발")){%>selected<%} %>>개발</option>
                        </select>                    
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="회원수정 ">&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="reset" value="원래대로">&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="button" value="회원목록" onclick="location.href='index.jsp'">
                    </td>
                </tr>
            </table>        
        </div>        
    </form>
</body>
</html>
 