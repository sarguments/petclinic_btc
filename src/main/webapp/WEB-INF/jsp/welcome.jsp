<%@ page session="true" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="petclinic" tagdir="/WEB-INF/tags" %>

<petclinic:layout pageName="home">
    <h2><fmt:message key="welcome"/></h2>
    <div class="row">
        <div class="col-md-12">
            <spring:url value="/resources/images/severcat.jpg" htmlEscape="true" var="severcat"/>
            <img class="img-responsive" alt="A cat and a dog" src="${petsImage}"/>
        </div>
    </div>
    <div class="server-info">
        <h3>Server and System Information</h3>
        <ul>
            <c:set var="inet" value="${pageContext.request.remoteHost}" />
            <li>Host Name: ${inet}</li>
        </ul>
    </div>

    <div class="client-info">
        <h3>Client Information</h3>
        <ul>
            <li>Client IP: ${pageContext.request.remoteAddr}</li>
            <c:choose>
                <c:when test="${not empty pageContext.request.getHeader('x-forwarded-for')}">
                    <li>Client IP (X-Forwarded-For): ${pageContext.request.getHeader('x-forwarded-for')}</li>
                </c:when>
                <c:otherwise>
                    <li>Client IP (X-Forwarded-For): None</li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>

    <div class="http-info">
        <h3>HTTP Request Information</h3>
        <ul>
            <li>HTTP Method: ${pageContext.request.method}</li>
            <li>Request URI: ${pageContext.request.requestURI}</li>
            <li>Protocol: ${pageContext.request.protocol}</li>
        </ul>
    </div>

    <div class="headers-info">
        <h3>All HTTP Headers</h3>
        <ul>
            <c:forEach var="headerName" items="${pageContext.request.headerNames}">
                <li><strong>${headerName}</strong>: ${pageContext.request.getHeader(headerName)}</li>
            </c:forEach>
        </ul>
    </div>
</petclinic:layout>
