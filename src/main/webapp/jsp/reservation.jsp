<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Add Reservation - Ocean View Resort</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 600px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form label {
            display: block;
            margin: 15px 0 5px;
            font-weight: bold;
        }
        form input, form select {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }
        .btn {
            margin-top: 20px;
            background: #007bff;
            color: #fff;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background: #0056b3;
        }
        .message {
            margin-top: 20px;
            padding: 12px;
            border-radius: 5px;
            text-align: center;
        }
        .success {
            background: #d4edda;
            color: #155724;
        }
        .error {
            background: #f8d7da;
            color: #721c24;
        }
        .bill {
            margin-top: 15px;
            padding: 10px;
            background: #e2e3e5;
            border-radius: 5px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add Reservation</h2>

        <!-- Success / Error Messages -->
        <% if(request.getAttribute("success") != null) { %>
            <div class="message success"><%= request.getAttribute("success") %></div>
        <% } %>

        <% if(request.getAttribute("error") != null) { %>
            <div class="message error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="ReservationServlet" method="post">
            <input type="hidden" name="action" value="add">

            <label>Guest Name:</label>
            <input type="text" name="guest_name" required>

            <label>Address:</label>
            <input type="text" name="address">

            <label>Contact Number:</label>
            <input type="text" name="contact_number" required>

            <label>Room Type:</label>
            <select name="room_type" required>
                <% 
                    String[] roomTypes = (String[]) request.getAttribute("roomTypes");
                    if(roomTypes != null){
                        for(String rt : roomTypes){ 
                %>
                            <option value="<%= rt %>"><%= rt %></option>
                <% 
                        } 
                    } 
                %>
            </select>
            <label>Check-in Date:</label>
            <input type="date" name="check_in" id="check_in" required
       		min="<%= java.time.LocalDate.now() %>">
       		
       		<label>Check-out Date:</label>
			<input type="date" name="check_out" id="check_out" required
       min="<%= java.time.LocalDate.now().plusDays(1) %>">


            <button type="submit" class="btn">Add Reservation</button>
        </form>
    </div>
</body>
</html>