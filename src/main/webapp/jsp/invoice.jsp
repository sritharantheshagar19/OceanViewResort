<%@ page import="model.Reservation" %>
<%@ page import="model.User" %>
<%@ page session="true" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }

    Reservation r = (Reservation) request.getAttribute("reservation");
    if (r == null) {
        response.sendRedirect("ReservationServlet?action=list");
        return;
    }

    long days = java.time.temporal.ChronoUnit.DAYS.between(
        r.getCheckIn().toLocalDate(),
        r.getCheckOut().toLocalDate()
    );
    
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd MMMM yyyy");
    String checkInFormatted = r.getCheckIn().toLocalDate().format(dateFormatter);
    String checkOutFormatted = r.getCheckOut().toLocalDate().format(dateFormatter);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice #<%= r.getReservationId() %> - Ocean View Resort</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 30px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .invoice-container {
            max-width: 900px;
            width: 100%;
            background: white;
            border-radius: 25px;
            box-shadow: 0 30px 70px rgba(0,0,0,0.3);
            overflow: hidden;
            animation: slideUp 0.5s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .invoice-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px 50px;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .invoice-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            position: relative;
            z-index: 1;
        }

        .hotel-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .hotel-info i {
            font-size: 3rem;
            color: white;
        }

        .hotel-info h1 {
            font-size: 2.2rem;
            font-weight: 700;
            line-height: 1.2;
        }

        .hotel-info p {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .invoice-badge {
            background: rgba(255,255,255,0.2);
            padding: 12px 25px;
            border-radius: 50px;
            text-align: center;
            backdrop-filter: blur(5px);
        }

        .invoice-badge .label {
            font-size: 0.85rem;
            opacity: 0.9;
            display: block;
            margin-bottom: 5px;
        }

        .invoice-badge .number {
            font-size: 1.5rem;
            font-weight: 700;
            letter-spacing: 2px;
        }

        .header-bottom {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            position: relative;
            z-index: 1;
        }

        .date-info {
            display: flex;
            gap: 30px;
        }

        .date-item {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .date-item .label {
            font-size: 0.85rem;
            opacity: 0.9;
        }

        .date-item .value {
            font-size: 1.1rem;
            font-weight: 600;
        }

        .status-badge {
            background: white;
            color: #667eea;
            padding: 8px 25px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .invoice-body {
            padding: 40px 50px;
        }

        .guest-card {
            background: #f8fafc;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
            border: 1px solid #e0e0e0;
        }

        .guest-avatar {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2.5rem;
        }

        .guest-details {
            flex: 1;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .detail-item .label {
            color: #7f8c8d;
            font-size: 0.85rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .detail-item .value {
            color: #2c3e50;
            font-size: 1.1rem;
            font-weight: 600;
        }

        .detail-item .value i {
            color: #667eea;
            margin-right: 8px;
            width: 20px;
        }

        .room-card {
            background: linear-gradient(135deg, #667eea10 0%, #764ba210 100%);
            border: 2px dashed #667eea40;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .room-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.8rem;
        }

        .room-info {
            flex: 1;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .room-type {
            font-size: 1.3rem;
            font-weight: 700;
            color: #2c3e50;
        }

        .room-type span {
            background: #667eea20;
            color: #667eea;
            padding: 5px 15px;
            border-radius: 50px;
            font-size: 0.9rem;
            margin-left: 10px;
        }

        .room-dates {
            display: flex;
            gap: 20px;
            color: #7f8c8d;
        }

        .room-dates i {
            color: #667eea;
            margin-right: 5px;
        }

        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        .invoice-table th {
            background: #f8fafc;
            color: #2c3e50;
            font-weight: 600;
            font-size: 0.95rem;
            padding: 15px;
            text-align: left;
            border-bottom: 2px solid #e0e0e0;
        }

        .invoice-table th i {
            color: #667eea;
            margin-right: 8px;
        }

        .invoice-table td {
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
            color: #2c3e50;
        }

        .invoice-table tfoot td {
            border-bottom: none;
            padding-top: 20px;
        }

        .text-right {
            text-align: right;
        }

        .text-center {
            text-align: center;
        }

        .amount {
            font-weight: 600;
            color: #27ae60;
        }

        .summary-box {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 15px;
            padding: 25px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .summary-left h3 {
            font-size: 1rem;
            font-weight: 400;
            opacity: 0.9;
            margin-bottom: 10px;
        }

        .summary-left .total-amount {
            font-size: 2.5rem;
            font-weight: 700;
        }

        .summary-left .total-amount small {
            font-size: 1rem;
            font-weight: 400;
            opacity: 0.8;
            margin-left: 10px;
        }

        .summary-right {
            text-align: right;
        }

        .summary-right .days {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .summary-right .rate {
            font-size: 1rem;
            opacity: 0.9;
        }

        .invoice-footer {
            margin-top: 40px;
            text-align: center;
            padding-top: 20px;
            border-top: 2px dashed #e0e0e0;
        }

        .footer-text {
            color: #7f8c8d;
            font-size: 0.9rem;
            margin-bottom: 20px;
        }

        .footer-text i {
            color: #667eea;
            margin: 0 5px;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin: 20px 0;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
            text-decoration: none;
        }

        .btn-print {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(102,126,234,0.3);
        }

        .btn-print:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102,126,234,0.4);
        }

        .btn-back {
            background: #95a5a6;
            color: white;
        }

        .btn-back:hover {
            background: #7f8c8d;
            transform: translateY(-2px);
        }

        .btn-email {
            background: #3498db;
            color: white;
        }

        .btn-email:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }

        @media print {
            body {
                background: white;
                padding: 0;
            }
            
            .invoice-container {
                box-shadow: none;
                border-radius: 0;
            }
            
            .invoice-header {
                background: #667eea !important;
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }
            
            .summary-box {
                background: #667eea !important;
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }
            
            .action-buttons {
                display: none !important;
            }
            
            .guest-avatar, .room-icon {
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }
        }

        @media (max-width: 768px) {
            .invoice-header {
                padding: 30px 20px;
            }
            
            .invoice-body {
                padding: 30px 20px;
            }
            
            .header-top {
                flex-direction: column;
                gap: 20px;
                text-align: center;
            }
            
            .header-bottom {
                flex-direction: column;
                gap: 20px;
                align-items: center;
            }
            
            .date-info {
                flex-direction: column;
                gap: 10px;
                text-align: center;
            }
            
            .guest-card {
                flex-direction: column;
                align-items: center;
                text-align: center;
            }
            
            .room-info {
                flex-direction: column;
                text-align: center;
            }
            
            .summary-box {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }
            
            .summary-right {
                text-align: center;
            }
            
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="invoice-container">
        <div class="invoice-header">
            <div class="header-top">
                <div class="hotel-info">
                    <i class="fas fa-hotel"></i>
                    <div>
                        <h1>Ocean View Resort</h1>
                        <p>Galle, Sri Lanka</p>
                    </div>
                </div>
                <div class="invoice-badge">
                    <span class="label">Invoice Number</span>
                    <span class="number">#<%= String.format("%06d", r.getReservationId()) %></span>
                </div>
            </div>
            <div class="header-bottom">
                <div class="date-info">
                    <div class="date-item">
                        <span class="label">Check-In</span>
                        <span class="value"><i class="fas fa-calendar-alt"></i> <%= checkInFormatted %></span>
                    </div>
                    <div class="date-item">
                        <span class="label">Check-Out</span>
                        <span class="value"><i class="fas fa-calendar-alt"></i> <%= checkOutFormatted %></span>
                    </div>
                </div>
                <div class="status-badge">
                    <i class="fas fa-<%= "ACTIVE".equals(r.getStatus()) ? "check-circle" : 
                                      "COMPLETE".equals(r.getStatus()) ? "check-double" : 
                                      "times-circle" %>"></i>
                    <%= r.getStatus() %>
                </div>
            </div>
        </div>

        <div class="invoice-body">
            <div class="guest-card">
                <div class="guest-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div class="guest-details">
                    <div class="detail-item">
                        <span class="label">Guest Name</span>
                        <span class="value"><i class="fas fa-user"></i> <%= r.getGuestName() %></span>
                    </div>
                    <div class="detail-item">
                        <span class="label">Contact Number</span>
                        <span class="value"><i class="fas fa-phone"></i> <%= r.getContactNumber() %></span>
                    </div>
                    <div class="detail-item">
                        <span class="label">Address</span>
                        <span class="value"><i class="fas fa-map-marker-alt"></i> <%= r.getAddress() %></span>
                    </div>
                </div>
            </div>

            <div class="room-card">
                <div class="room-icon">
                    <i class="fas fa-bed"></i>
                </div>
                <div class="room-info">
                    <div>
                        <span class="room-type">
                            <%= r.getRoomType() %>
                            <span><%= days %> Night<%= days > 1 ? "s" : "" %></span>
                        </span>
                    </div>
                    <div class="room-dates">
                        <span><i class="fas fa-sign-in-alt"></i> <%= checkInFormatted %></span>
                        <span><i class="fas fa-sign-out-alt"></i> <%= checkOutFormatted %></span>
                    </div>
                </div>
            </div>

            <table class="invoice-table">
                <thead>
                    <tr>
                        <th><i class="fas fa-bed"></i> Description</th>
                        <th class="text-center"><i class="fas fa-clock"></i> Nights</th>
                        <th class="text-right"><i class="fas fa-tag"></i> Rate/Night</th>
                        <th class="text-right"><i class="fas fa-calculator"></i> Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong><%= r.getRoomType() %> Room</strong><br>
                            <small style="color: #7f8c8d;">Accommodation for <%= days %> night<%= days > 1 ? "s" : "" %></small>
                        </td>
                        <td class="text-center"><%= days %></td>
                        <td class="text-right">LKR <%= String.format("%,.2f", r.getTotalBill() / days) %></td>
                        <td class="text-right amount">LKR <%= String.format("%,.2f", r.getTotalBill()) %></td>
                    </tr>
                </tbody>
            </table>

            <div class="summary-box">
                <div class="summary-left">
                    <h3>Total Amount</h3>
                    <div class="total-amount">
                        LKR <%= String.format("%,.2f", r.getTotalBill()) %>
                        <small>LKR</small>
                    </div>
                </div>
                <div class="summary-right">
                    <div class="days"><%= days %> Night<%= days > 1 ? "s" : "" %></div>
                    <div class="rate">LKR <%= String.format("%,.2f", r.getTotalBill() / days) %> per night</div>
                </div>
            </div>

            <div class="action-buttons">
                <button class="btn btn-print" onclick="window.print()">
                    <i class="fas fa-print"></i>
                    Print Invoice
                </button>
                <button class="btn btn-email" onclick="sendEmail()">
                    <i class="fas fa-envelope"></i>
                    Email Invoice
                </button>
                <a href="ReservationServlet?action=list" class="btn btn-back">
                    <i class="fas fa-arrow-left"></i>
                    Back to Reservations
                </a>
            </div>

            <div class="invoice-footer">
                <div class="footer-text">
                    <i class="fas fa-credit-card"></i> 
                    This is a computer generated invoice. No signature is required.
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="footer-text">
                    <i class="fas fa-clock"></i>
                    Generated on <%= new java.text.SimpleDateFormat("dd MMMM yyyy, hh:mm a").format(new java.util.Date()) %>
                </div>
                <div class="footer-text" style="font-size: 0.85rem;">
                    <i class="fas fa-map-marker-alt"></i>
                    Ocean View Resort, Galle, Sri Lanka | 
                    <i class="fas fa-phone"></i> +94 123 456 789 |
                    <i class="fas fa-envelope"></i> info@oceanviewresort.com
                </div>
            </div>
        </div>
    </div>

    <script>
        function sendEmail() {
            alert('Invoice has been sent to guest\'s email address.');
        }
    </script>
</body>
</html>