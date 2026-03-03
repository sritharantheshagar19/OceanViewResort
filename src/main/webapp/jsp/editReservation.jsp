<%@ page import="model.Reservation" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Reservation reservation = (Reservation) request.getAttribute("reservation");
    if (reservation == null) {
        response.sendRedirect("ReservationServlet?action=list");
        return;
    }

    String[] roomTypes = (String[]) request.getAttribute("roomTypes");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Reservation - Ocean View Resort</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f4f7f8; margin: 0; padding: 0; }
        header { background-color: #2c3e50; color: white; padding: 20px; text-align: center; font-size: 24px; }
        .container { padding: 20px; max-width: 600px; margin: auto; background: white; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        h2 { text-align: center; margin-bottom: 20px; }
        form { display: flex; flex-direction: column; gap: 15px; }
        label { font-weight: bold; }
        input, select { padding: 8px; border-radius: 5px; border: 1px solid #ccc; width: 100%; box-sizing: border-box; }
        button { padding: 10px; border: none; border-radius: 5px; background-color: #3498db; color: white; font-weight: bold; cursor: pointer; }
        button:hover { background-color: #217dbb; }
        .top-links { text-align: center; margin-bottom: 20px; }
        .top-links a { text-decoration: none; padding: 8px 12px; background-color: #2980b9; color: white; border-radius: 5px; margin: 0 5px; }
        .top-links a:hover { background-color: #1c5980; }
        .error { color: red; text-align: center; }
    </style>
</head>
<body>
<header>Edit Reservation</header>

<div class="container">

    <div class="top-links">
        <a href="ReservationServlet?action=list">Back to Reservations</a>
    </div>

    <h2>Edit Reservation #<%= reservation.getReservationId() %></h2>

    <form action="ReservationServlet" method="post">
        <input type="hidden" name="action" value="updateBooking">
        <input type="hidden" name="id" value="<%= reservation.getReservationId() %>">

        <label for="guest_name">Guest Name:</label>
        <input type="text" id="guest_name" name="guest_name" value="<%= reservation.getGuestName() %>" required>

        <label for="address">Address:</label>
        <input type="text" id="address" name="address" value="<%= reservation.getAddress() %>" required>

        <label for="contact_number">Contact Number:</label>
        <input type="text" id="contact_number" name="contact_number" value="<%= reservation.getContactNumber() %>" required>

        <label for="room_type">Room Type:</label>
        <select id="room_type" name="room_type" required>
            <% for (String type : roomTypes) { %>
                <option value="<%= type %>" <%= type.equals(reservation.getRoomType()) ? "selected" : "" %>><%= type %></option>
            <% } %>
        </select>
        <label for="check_in">Check-In Date:</label>
        <input type="date" name="check_in" id="check_in" required
       value="<%= reservation.getCheckIn() %>"
       min="<%= java.time.LocalDate.now() %>">
       
       <label for="check_out">Check-Out Date:</label>
		<input type="date" name="check_out" id="check_out" required
       value="<%= reservation.getCheckOut() %>"
       min="<%= java.time.LocalDate.now().plusDays(1) %>">


        <button type="submit">Update Reservation</button>
    </form>

</div>
</body>
</html>