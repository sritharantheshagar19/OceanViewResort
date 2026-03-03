<%@ page session="true" %>
<%@ page import="model.User, java.util.List, model.Room" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
    List<Room> rooms = (List<Room>) request.getAttribute("rooms");
    if(rooms == null) rooms = new java.util.ArrayList<>();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Room Management - Ocean View Resort</title>
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
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #34495e;
        }
        .add-btn {
            display: inline-block;
            padding: 10px 20px;
            margin-bottom: 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background 0.2s;
        }
        .add-btn:hover {
            background-color: #1c5980;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #2980b9;
            color: white;
            text-transform: uppercase;
            font-size: 14px;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .action-btn {
            padding: 6px 12px;
            margin: 0 2px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.2s;
        }
        .edit-btn {
            background-color: #27ae60;
            color: white;
        }
        .edit-btn:hover {
            background-color: #1f8a4d;
        }
        .delete-btn {
            background-color: #e74c3c;
            color: white;
        }
        .delete-btn:hover {
            background-color: #c0392b;
        }
        @media (max-width: 600px) {
            th, td {
                padding: 10px;
                font-size: 12px;
            }
            .add-btn {
                padding: 8px 15px;
                font-size: 14px;
            }
            .action-btn {
                padding: 5px 10px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <header>Ocean View Resort - Room Management</header>
    <div class="container">
        <a href="RoomServlet?action=add" class="add-btn">Add New Room Type</a>
        <table>
            <tr>
                <th>Room Type</th>
                <th>Price Per Night (Rs.)</th>
                <th>Actions</th>
            </tr>
            <% for(Room r : rooms) { %>
            <tr>
                <td><%= r.getRoomType() %></td>
                <td><%= r.getPricePerNight() %></td>
                <td>
                    <a href="RoomServlet?action=edit&room_type=<%= r.getRoomType() %>" class="action-btn edit-btn">Edit</a>
                    <form action="RoomServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="room_type" value="<%= r.getRoomType() %>">
                        <button type="submit" class="action-btn delete-btn"
                                onclick="return confirm('Delete this room?');">Delete</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</body>
</html>