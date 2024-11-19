<%@ page session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="petclinic" tagdir="/WEB-INF/tags" %>

<%@ page import="java.net.InetAddress" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>

<petclinic:layout pageName="home">
    <h2><fmt:message key="welcome"/></h2>
    <div class="row">
        <div class="col-md-12">
            <spring:url value="/resources/images/pets.png" htmlEscape="true" var="petsImage"/>
            <img class="img-responsive" alt="A cat and a dog" src="${petsImage}"/>
        </div>
    </div>
    <div class="server-info">
        <h3>Server and System Information</h3>
        <ul>
            <%
                // 서버의 IP 주소 및 호스트 이름
                InetAddress inet = InetAddress.getLocalHost();
                String hostName = inet.getHostName();
                String hostAddress = inet.getHostAddress();

                // 우분투 기반 시스템 정보 명령어 실행
                String osVersion = "";
                String cpuInfo = "";
                String memoryInfo = "";

                try {
                    // OS 버전
                    Process osProcess = Runtime.getRuntime().exec("lsb_release -d");
                    BufferedReader osReader = new BufferedReader(new InputStreamReader(osProcess.getInputStream()));
                    osVersion = osReader.readLine().split(":")[1].trim();
                    osReader.close();

                    // CPU 정보
                    Process cpuProcess = Runtime.getRuntime().exec("lscpu | grep 'Model name'");
                    BufferedReader cpuReader = new BufferedReader(new InputStreamReader(cpuProcess.getInputStream()));
                    cpuInfo = cpuReader.readLine().split(":")[1].trim();
                    cpuReader.close();

                    // 메모리 정보
                    Process memProcess = Runtime.getRuntime().exec("free -h | grep 'Mem:'");
                    BufferedReader memReader = new BufferedReader(new InputStreamReader(memProcess.getInputStream()));
                    memoryInfo = memReader.readLine().replaceAll("\\s+", " ");
                    memReader.close();
                } catch (Exception e) {
                    osVersion = "Unable to fetch OS version";
                    cpuInfo = "Unable to fetch CPU info";
                    memoryInfo = "Unable to fetch memory info";
                }

                // JVM 및 OS 정보
                String javaVersion = System.getProperty("java.version");
                String javaVendor = System.getProperty("java.vendor");
                String osName = System.getProperty("os.name");
                String osArch = System.getProperty("os.arch");
            %>
            <li>Host Name: <%= hostName %></li>
            <li>Host Address: <%= hostAddress %></li>
            <li>OS Version: <%= osVersion %></li>
            <li>CPU Info: <%= cpuInfo %></li>
            <li>Memory Info: <%= memoryInfo %></li>
            <li>Java Version: <%= javaVersion %></li>
            <li>Java Vendor: <%= javaVendor %></li>
            <li>Operating System: <%= osName %> (<%= osArch %>)</li>
        </ul>
    </div>

    <div class="client-info">
        <h3>Client Information</h3>
        <ul>
            <%
                // 클라이언트 IP 정보
                String clientIp = request.getRemoteAddr();
                String xForwardedFor = request.getHeader("x-forwarded-for");
            %>
            <li>Client IP: <%= clientIp %></li>
            <li>Client IP (X-Forwarded-For): <%= xForwardedFor != null ? xForwardedFor : "None" %></li>
        </ul>
    </div>

    <div class="session-info">
        <h3>Session Information</h3>
        <ul>
            <%
                // 세션 정보
                javax.servlet.http.HttpSession session = request.getSession(false);
                if (session != null) {
            %>
            <li>Session ID: <%= session.getId() %></li>
            <li>Creation Time: <%= new java.util.Date(session.getCreationTime()) %></li>
            <li>Last Accessed Time: <%= new java.util.Date(session.getLastAccessedTime()) %></li>
            <%
                } else {
            %>
            <li>No active session</li>
            <%
                }
            %>
        </ul>
    </div>

    <div class="http-info">
        <h3>HTTP Request Information</h3>
        <ul>
            <li>HTTP Method: <%= request.getMethod() %></li>
            <li>Request URI: <%= request.getRequestURI() %></li>
            <li>Protocol: <%= request.getProtocol() %></li>
        </ul>
    </div>

    <div class="headers-info">
        <h3>All HTTP Headers</h3>
        <ul>
            <%
                // 모든 HTTP 헤더 출력
                Enumeration<String> headerNames = request.getHeaderNames();
                while (headerNames.hasMoreElements()) {
                    String headerName = headerNames.nextElement();
                    String headerValue = request.getHeader(headerName);
            %>
            <li><strong><%= headerName %></strong>: <%= headerValue %></li>
            <%
                }
            %>
        </ul>
    </div>
</petclinic:layout>
