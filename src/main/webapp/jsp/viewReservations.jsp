<%@ page import="java.util.List" %>
<%@ page import="model.Reservation" %>
<%@ page import="model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }

    List<Reservation> reservations =
        (List<Reservation>) request.getAttribute("reservationList");
    if(reservations == null) reservations = new java.util.ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Reservations - Ocean View Resort</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f4f7f8; margin: 0; padding: 0; }
        header { background-color: #2c3e50; color: white; padding: 20px; text-align: center; font-size: 24px; }
        .container { padding: 20px; }
        h2 { text-align: center; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; background: white; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        th, td { padding: 12px; border-bottom: 1px solid #ddd; text-align: center; }
        th { background-color: #2980b9; color: white; }
        tr:hover { background-color: #f1f1f1; }
        .status { padding: 5px 10px; border-radius: 5px; color: white; font-weight: bold; }
        .ACTIVE { background-color: #27ae60; }
        .CANCELED { background-color: #e74c3c; }
        .COMPLETE { background-color: #f39c12; }
        .action-btn { padding: 5px 10px; border: none; border-radius: 5px; cursor: pointer; margin: 2px; font-weight: bold; }
        .primary { background-color: #3498db; color: white; }
        .bill { background-color: #2ecc71; color: white; }
        .disabled { background-color: #bdc3c7; color: white; cursor: not-allowed; }
        .top-links { margin-bottom: 20px; text-align: center; }
        .top-links a { text-decoration: none; padding: 10px 15px; background-color: #2980b9; color: white; border-radius: 5px; margin: 0 5px; }
        .top-links a:hover { background-color: #1c5980; }
        .locked { color: gray; font-weight: bold; }
    </style>
</head>
<body>
<header>Ocean View Resort - Reservations</header>

<div class="container">

    <div class="top-links">
        <a href="<%=request.getContextPath()%>/ReservationServlet?action=add">
            Add Reservation
        </a>
        <a href="<%=request.getContextPath()%>/jsp/dashboard.jsp">
    Back to Dashboard</a>
    </div>

    <h2>All Reservations</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Guest Name</th>
            <th>Address</th>
            <th>Contact</th>
            <th>Room Type</th>
            <th>Check-In</th>
            <th>Check-Out</th>
            <th>Days</th>
            <th>Total Bill (Rs.)</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>

        <%
            for(Reservation r : reservations){
                long days = java.time.temporal.ChronoUnit.DAYS.between(
                    r.getCheckIn().toLocalDate(),
                    r.getCheckOut().toLocalDate()
                );
        %>

        <tr>
            <td><%= r.getReservationId() %></td>
            <td><%= r.getGuestName() %></td>
            <td><%= r.getAddress() %></td>
            <td><%= r.getContactNumber() %></td>
            <td><%= r.getRoomType() %></td>
            <td><%= r.getCheckIn() %></td>
            <td><%= r.getCheckOut() %></td>
            <td><%= days %></td>
            <td><%= r.getTotalBill() %></td>
            <td>
                <span class="status <%= r.getStatus() %>">
                    <%= r.getStatus() %>
                </span>
            </td>

            <td>

                <% if("ACTIVE".equals(r.getStatus())) { %>

                    <!-- UPDATE STATUS -->
                    <form style="display:inline;"
                          action="ReservationServlet"
                          method="post">
                        <input type="hidden" name="action" value="updateStatus">
                        <input type="hidden" name="id"
                               value="<%= r.getReservationId() %>">

                        <select name="status">
                            <option value="ACTIVE" selected>ACTIVE</option>
                            <option value="COMPLETE">COMPLETE</option>
                            <option value="CANCELED">CANCELED</option>
                        </select>

                        <button type="submit"
                                class="action-btn primary">
                            Update
                        </button>
                    </form>

                    <!-- EDIT BUTTON -->
                    <form style="display:inline;"
                          action="ReservationServlet"
                          method="get">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id"
                               value="<%= r.getReservationId() %>">

                        <button type="submit"
                                class="action-btn primary">
                            Edit
                        </button>
                    </form>

                <% } else { %>

                    <span class="locked">Locked</span>

                <% } %>

                <!-- BILL BUTTON (ALWAYS ENABLED) -->
                <form style="display:inline;"
                      action="<%=request.getContextPath()%>/BillServlet"
                      method="get"
                      target="_blank">
                    <input type="hidden" name="id"
                           value="<%= r.getReservationId() %>">

                    <button type="submit"
                            class="action-btn bill">
                        Bill
                    </button>
                </form>

            </td>
        </tr>

        <% } %>

    </table>

</div>
</body>
</html>