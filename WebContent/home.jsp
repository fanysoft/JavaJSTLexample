<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

	
	<c:import url="header.jsp">	
		<c:param name="title" value="Home"></c:param>
	</c:import>
	

	<center>
	
	<table class="images" border=0>
	<c:set var="tablewidth" value="6" />
	
	
	<!-- Varianta 1 : definice JDBC spojeni je v Tomcat / context.xml
		<Resource name="jdbc/webshopDB" auth="Container" type="javax.sql.DataSource" maxActive="100" maxIdle="30" maxWait="10000" 
		username="root" password="" driverClassName="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/webshop"/>
	<sql:setDataSource var="ds" dataSource="jdbc/webshopDB" />	-->
	
	<!-- Varianta 2 : definice v jsp / localhost 
		<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
     	url="jdbc:mysql://localhost:3306/webshop" user="root"  password="***" /> -->
    
    <!-- Varianta 3 : definice v jsp / cloud -->
    	<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
     	url="jdbc:mysql://wh19.farma.gigaserver.cz:3306/vancura_cz_" user="***"  password="***" />
  
	
	
	<sql:query dataSource="${ds}" sql="select * from demo_jstl_images order by average_ranking desc" var="results" />
	
		<c:forEach var="db_record" items="${results.rows}" varStatus="row">
			
		    <c:if test="${row.index % tablewidth == 0}">
		        <tr>
      		</c:if>
      		
			<td>
				<center>
				<div class="img">
					<a href="<c:url value="/gallery?action=image&image_id=${db_record.id}" />">
                	<img width="80" src="${pageContext.request.contextPath}/pics/${db_record.name}.jpg" /></a>
                    
			    <div class="desc">
			    	<font size=1><b>${db_record.name}</b> <br>
			    	Rating <fmt:formatNumber value="${db_record.average_ranking}" maxFractionDigits="1"/><br>
			    	Rated ${db_record.rankings}x
			    	</font> 
			    </div>
			    </div>
			</td>
		  
		    <c:if test="${row.index + 1 % tablewidth == 0}">
				</tr>
			</c:if>
			
		
		</c:forEach>
		
	</table>
	
	
	</center>
	
	<c:import url="footer.jsp">	</c:import>
