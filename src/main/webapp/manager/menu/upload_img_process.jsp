<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="업로드 된 파일의 처리"
    %>
<%
//1. 업로드 저장 디렉토리 설정
File saveDir = new File("C:/dev/workspace/paik_prj/src/main/webapp/manager/common/image");

//2. 최대 파일 크기 설정 
int fileSize = 1024*1024*600; // 600Mbyte

//3. 파일 업로드 Component 생성
MultipartRequest mr 
= new MultipartRequest(request, saveDir.getAbsolutePath(), fileSize, "UTF-8", 
		new DefaultFileRenamePolicy());

//4. 파일명 받기
String fileSystemName = mr.getFilesystemName("profile");

File readFile = new File(saveDir.getAbsolutePath()+fileSystemName);	// file 이름 얻기
//최대 파일 크기 비교
int maxSize = 1024*1024*10;
boolean uploadflag = readFile.length() > maxSize;
if(uploadflag) {//업로드 제한 크기 초과시 해당 파일 삭제
	readFile.delete();
}//end if

//5. 응답 화면 생성
JSONObject jsonObj = new JSONObject();
jsonObj.put("uploadflag",uploadflag);
out.print(jsonObj.toJSONString());

%>