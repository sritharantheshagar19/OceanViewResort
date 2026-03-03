<%@ page import="model.Reservation" %>
<%@ page session="true" %>
<%
    Reservation r = (Reservation) request.getAttribute("reservation");
    if (r == null) {
        response.sendRedirect("ReservationServlet?action=list");
        return;
    }

    long days = java.time.temporal.ChronoUnit.DAYS.between(
        r.getCheckIn().toLocalDate(),
        r.getCheckOut().toLocalDate()
    );
%>
<!DOCTYPE html>
<html>
<head>
    <title>Invoice - Ocean View Resort</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f7f8; padding: 20px; }
        .invoice-box { max-width: 800px; margin: auto; padding: 30px; background: #fff; border: 1px solid #eee; box-shadow: 0 0 10px rgba(0,0,0,0.15);}
        h1 { text-align: center; color: #333; }
        table { width: 100%; line-height: inherit; text-align: left; border-collapse: collapse; margin-top: 20px; }
        table td, table th { padding: 10px; border-bottom: 1px solid #eee; }
        table th { background: #2980b9; color: white; }
        .total { font-weight: bold; }
        .right { text-align: right; }
        .center { text-align: center; }
        .print-btn { margin-top: 20px; padding: 10px 20px; background: #27ae60; color: white; border: none; border-radius: 5px; cursor: pointer; }
    </style>
</head>
<body>
<div class="invoice-box">
    <h1>Ocean View Resort</h1>
    <p class="center">Reservation Invoice</p>

    <table>
        <tr>
            <th>Guest Name</th>
            <td><%= r.getGuestName() %></td>
        </tr>
        <tr>
            <th>Contact</th>
            <td><%= r.getContactNumber() %></td>
        </tr>
        <tr>
            <th>Address</th>
            <td><%= r.getAddress() %></td>
        </tr>
        <tr>
            <th>Room Type</th>
            <td><%= r.getRoomType() %></td>
        </tr>
        <tr>
            <th>Check-In</th>
            <td><%= r.getCheckIn() %></td>
        </tr>
        <tr>
            <th>Check-Out</th>
            <td><%= r.getCheckOut() %></td>
        </tr>
        <tr>
            <th>Number of Days</th>
            <td><%= days %></td>
        </tr>
        <tr>
            <th>Total Bill (Rs.)</th>
            <td><%= r.getTotalBill() %></td>
        </tr>
        <tr>
            <th>Status</th>
            <td><%= r.getStatus() %></td>
        </tr>
    </table>

    <div class="center">
        <button class="print-btn" onclick="window.print()">Print Invoice</button>
    </div>
</div>
</body>
</html>