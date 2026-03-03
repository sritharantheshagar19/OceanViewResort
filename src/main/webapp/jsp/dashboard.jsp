<%@ page import="model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if(user == null){
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
    <h2>Welcome, <%= user.getUsername() %>!</h2>
<ul>
    <li><a href="<%=request.getContextPath()%>/jsp/addReservation.jsp">Add Reservation</a></li>
    <li><a href="<%=request.getContextPath()%>/jsp/viewReservation.jsp">View Reservations</a></li>
    <li><a href="<%=request.getContextPath()%>/jsp/logout.jsp">Logout</a></li>
</ul>
</body>
</html>