<%@ page import="model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Ocean View Resort</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7f8;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 24px;
        }
        .welcome {
            text-align: center;
            margin: 20px 0;
            font-size: 20px;
        }
        .container {
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
            padding: 20px;
        }
        .card {
            background-color: white;
            width: 220px;
            height: 120px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }
        .card a {
            text-decoration: none;
            color: #2c3e50;
            font-weight: bold;
            font-size: 18px;
        }
        .logout {
            display: block;
            width: 120px;
            margin: 30px auto;
            padding: 10px;
            text-align: center;
            background-color: #e74c3c;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            transition: background 0.2s;
        }
        .logout:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
    <header>Ocean View Resort - Dashboard</header>
    <div class="welcome">Welcome, <strong><%= user.getUsername() %></strong>!</div>

    <div class="container">
        <div class="card">
            <a href="<%=request.getContextPath()%>/ReservationServlet?action=add">Add Reservation</a>
        </div>
        <div class="card">
            <a href="<%=request.getContextPath()%>/ReservationServlet?action=list">View Reservations</a>
        </div>
        <div class="card">
            <a href="<%=request.getContextPath()%>/RoomServlet?action=list">Room Management</a>
        </div>
    </div>

    <a class="logout" href="<%=request.getContextPath()%>/jsp/logout.jsp">Logout</a>
</body>
</html>