<%@ page session="true" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Room - Ocean View Resort</title>
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
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #34495e;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 5px;
            font-weight: bold;
            color: #34495e;
        }
        input[type="text"], input[type="number"] {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        .btn {
            padding: 12px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn:hover {
            background-color: #1c5980;
        }
        .back-link {
            display: block;
            margin-top: 15px;
            text-align: center;
            color: #2980b9;
            text-decoration: none;
            font-weight: bold;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <header>Ocean View Resort - Add New Room</header>
    <div class="container">
        <h2>Add New Room Type</h2>

        <form action="RoomServlet" method="post">
            <input type="hidden" name="action" value="add">

            <label for="room_type">Room Type</label>
            <input type="text" name="room_type" id="room_type" placeholder="Enter room type" required>

            <label for="price_per_night">Price Per Night (Rs.)</label>
            <input type="number" name="price_per_night" id="price_per_night" placeholder="Enter price" step="0.01" min="0" required>

            <button type="submit" class="btn">Add Room</button>
        </form>

        <a href="RoomServlet?action=list" class="back-link">← Back to Room List</a>
    </div>
</body>
</html>