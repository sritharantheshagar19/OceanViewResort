<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Room" %>
<%
    Room room = (Room) request.getAttribute("room");
    if (room == null) {
        response.sendRedirect("RoomServlet?action=list");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Room</title>
    <style>
        /* ======= Reset & Body ======= */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
        body { background: #f4f6f8; padding: 20px; }

        /* ======= Container ======= */
        .container {
            max-width: 500px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        h2 { text-align: center; margin-bottom: 20px; color: #333; }

        /* ======= Form Styling ======= */
        form { display: flex; flex-direction: column; gap: 15px; }

        label { font-weight: bold; color: #555; }
        input[type="text"], input[type="number"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            width: 100%;
            font-size: 1rem;
        }

        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        /* ======= Buttons ======= */
        .btn-group { display: flex; justify-content: space-between; margin-top: 20px; }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            font-size: 1rem;
            transition: background 0.3s ease;
        }
        .btn-save { background: #28a745; color: #fff; }
        .btn-save:hover { background: #218838; }
        .btn-cancel { background: #dc3545; color: #fff; }
        .btn-cancel:hover { background: #c82333; }

        /* ======= Responsive ======= */
        @media (max-width: 600px) {
            .container { padding: 20px; margin: 20px; }
            .btn-group { flex-direction: column; gap: 10px; }
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Edit Room</h2>
    <form action="RoomServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="old_room_type" value="<%= room.getRoomType() %>">

        <div>
            <label for="room_type">Room Type</label>
            <input type="text" id="room_type" name="room_type" value="<%= room.getRoomType() %>" required>
        </div>

        <div>
            <label for="price_per_night">Price Per Night ($)</label>
            <input type="number" id="price_per_night" name="price_per_night" step="0.01"
                   value="<%= room.getPricePerNight() %>" required>
        </div>

        <div class="btn-group">
            <button type="submit" class="btn btn-save">Save Changes</button>
            <a href="RoomServlet?action=list" class="btn btn-cancel">Cancel</a>
        </div>
    </form>
</div>

</body>
</html>