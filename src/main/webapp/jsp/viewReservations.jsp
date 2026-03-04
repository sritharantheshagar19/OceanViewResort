<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
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
    
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Reservations - Ocean View Resort</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: #f0f2f5;
        }

        /* Navbar */
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-brand {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .nav-brand i {
            font-size: 2rem;
            color: white;
        }

        .nav-brand span {
            color: white;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .nav-user {
            display: flex;
            align-items: center;
            gap: 20px;
            background: rgba(255,255,255,0.2);
            padding: 8px 20px;
            border-radius: 50px;
        }

        .nav-user i {
            color: white;
            font-size: 1.2rem;
        }

        .nav-user span {
            color: white;
            font-weight: 500;
        }

        /* Main Container */
        .main-container {
            padding: 30px;
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Page Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 20px;
        }

        .header-left h1 {
            color: #2c3e50;
            font-size: 2rem;
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
        }

        .header-left h1 i {
            color: #667eea;
        }

        .header-left p {
            color: #7f8c8d;
            font-size: 1rem;
        }

        .header-actions {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 25px;
            border-radius: 10px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            font-weight: 500;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(102,126,234,0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102,126,234,0.4);
        }

        .btn-secondary {
            background: white;
            color: #667eea;
            padding: 12px 25px;
            border-radius: 10px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            font-weight: 500;
            transition: all 0.3s;
            border: 2px solid #667eea;
        }

        .btn-secondary:hover {
            background: #667eea;
            color: white;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .stat-icon i {
            font-size: 1.5rem;
            color: white;
        }

        .stat-info h3 {
            color: #7f8c8d;
            font-size: 0.9rem;
            font-weight: 500;
            margin-bottom: 5px;
        }

        .stat-info .number {
            color: #2c3e50;
            font-size: 1.5rem;
            font-weight: 700;
        }

        /* Search and Filter Bar */
        .filter-bar {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
            justify-content: space-between;
        }

        .search-box {
            flex: 1;
            min-width: 250px;
            position: relative;
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #95a5a6;
        }

        .search-box input {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s;
            outline: none;
        }

        .search-box input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.1);
        }

        .filter-options {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .filter-select {
            padding: 12px 25px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            outline: none;
            cursor: pointer;
            background: white;
            min-width: 150px;
        }

        .filter-select:focus {
            border-color: #667eea;
        }

        /* Table Container */
        .table-container {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            overflow-x: auto;
        }

        .reservation-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1200px;
        }

        .reservation-table th {
            background: #f8fafc;
            color: #2c3e50;
            font-weight: 600;
            font-size: 0.9rem;
            padding: 15px;
            text-align: left;
            border-bottom: 2px solid #e0e0e0;
        }

        .reservation-table th i {
            margin-right: 8px;
            color: #667eea;
            font-size: 0.9rem;
        }

        .reservation-table td {
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
            color: #2c3e50;
            font-size: 0.95rem;
        }

        .reservation-table tbody tr {
            transition: all 0.3s;
        }

        .reservation-table tbody tr:hover {
            background: #f8fafc;
            transform: scale(1.01);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        /* Status Badges */
        .status-badge {
            padding: 6px 12px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .status-badge i {
            font-size: 0.8rem;
        }

        .status-ACTIVE {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }

        .status-COMPLETE {
            background: #fff3cd;
            color: #856404;
            border-left: 4px solid #ffc107;
        }

        .status-CANCELED {
            background: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        /* Room Type Badge */
        .room-type {
            background: #e8f0fe;
            color: #667eea;
            padding: 4px 10px;
            border-radius: 5px;
            font-weight: 500;
            font-size: 0.85rem;
            display: inline-block;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .action-btn {
            padding: 8px 12px;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.85rem;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s;
            text-decoration: none;
        }

        .btn-update {
            background: #3498db;
            color: white;
        }

        .btn-update:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }

        .btn-edit {
            background: #f39c12;
            color: white;
        }

        .btn-edit:hover {
            background: #e67e22;
            transform: translateY(-2px);
        }

        .btn-bill {
            background: #27ae60;
            color: white;
        }

        .btn-bill:hover {
            background: #229954;
            transform: translateY(-2px);
        }

        .locked-badge {
            background: #bdc3c7;
            color: #7f8c8d;
            padding: 8px 12px;
            border-radius: 8px;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        /* Status Update Form */
        .status-form {
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .status-select {
            padding: 6px 10px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 0.85rem;
            outline: none;
            cursor: pointer;
        }

        .status-select:focus {
            border-color: #667eea;
        }

        /* Amount Styling */
        .amount {
            font-weight: 600;
            color: #27ae60;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 50px;
            color: #95a5a6;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #2c3e50;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .main-container {
                padding: 20px;
            }
            
            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .header-actions {
                width: 100%;
            }
            
            .btn-primary, .btn-secondary {
                flex: 1;
                justify-content: center;
            }
            
            .filter-bar {
                flex-direction: column;
            }
            
            .search-box {
                width: 100%;
            }
            
            .filter-options {
                width: 100%;
            }
            
            .filter-select {
                flex: 1;
            }
        }

        /* Animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .fade-in {
            animation: fadeIn 0.5s ease;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="nav-brand">
            <i class="fas fa-hotel"></i>
            <span>Ocean View Resort</span>
        </div>
        <div class="nav-user">
            <i class="fas fa-user-circle"></i>
            <span><%= user.getUsername() %></span>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="main-container fade-in">
        <!-- Page Header -->
        <div class="page-header">
            <div class="header-left">
                <h1>
                    <i class="fas fa-calendar-check"></i>
                    Reservations Management
                </h1>
                <p>
                    <i class="fas fa-info-circle"></i>
                    Manage all guest reservations, update status, and generate bills
                </p>
            </div>
            <div class="header-actions">
                <a href="<%=request.getContextPath()%>/ReservationServlet?action=add" class="btn-primary">
                    <i class="fas fa-plus-circle"></i>
                    New Reservation
                </a>
                <a href="<%=request.getContextPath()%>/jsp/dashboard.jsp" class="btn-secondary">
                    <i class="fas fa-arrow-left"></i>
                    Back to Dashboard
                </a>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-tasks"></i>
                </div>
                <div class="stat-info">
                    <h3>Total Reservations</h3>
                    <div class="number"><%= reservations.size() %></div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-info">
                    <h3>Active</h3>
                    <div class="number">
                        <%= reservations.stream().filter(r -> "ACTIVE".equals(r.getStatus())).count() %>
                    </div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-info">
                    <h3>Completed</h3>
                    <div class="number">
                        <%= reservations.stream().filter(r -> "COMPLETE".equals(r.getStatus())).count() %>
                    </div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-times-circle"></i>
                </div>
                <div class="stat-info">
                    <h3>Canceled</h3>
                    <div class="number">
                        <%= reservations.stream().filter(r -> "CANCELED".equals(r.getStatus())).count() %>
                    </div>
                </div>
            </div>
        </div>

        <!-- Search and Filter Bar -->
        <div class="filter-bar">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search by guest name, contact, or room..." onkeyup="filterTable()">
            </div>
            <div class="filter-options">
                <select class="filter-select" id="statusFilter" onchange="filterTable()">
                    <option value="all">All Status</option>
                    <option value="ACTIVE">Active</option>
                    <option value="COMPLETE">Complete</option>
                    <option value="CANCELED">Canceled</option>
                </select>
                <select class="filter-select" id="roomFilter" onchange="filterTable()">
                    <option value="all">All Room Types</option>
                    <option value="STANDARD">Standard</option>
                    <option value="DELUXE">Deluxe</option>
                    <option value="SUITE">Suite</option>
                    <option value="FAMILY">Family</option>
                    <option value="BEACH_VIEW">Beach View</option>
                </select>
            </div>
        </div>

        <!-- Reservations Table -->
        <div class="table-container">
            <% if (reservations.isEmpty()) { %>
                <div class="empty-state">
                    <i class="fas fa-calendar-times"></i>
                    <h3>No Reservations Found</h3>
                    <p>Start by adding a new reservation</p>
                    <a href="<%=request.getContextPath()%>/ReservationServlet?action=add" class="btn-primary" style="display: inline-flex; margin-top: 20px;">
                        <i class="fas fa-plus-circle"></i>
                        Add New Reservation
                    </a>
                </div>
            <% } else { %>
                <table class="reservation-table" id="reservationTable">
                    <thead>
                        <tr>
                            <th><i class="fas fa-hashtag"></i> ID</th>
                            <th><i class="fas fa-user"></i> Guest Name</th>
                            <th><i class="fas fa-map-marker-alt"></i> Address</th>
                            <th><i class="fas fa-phone"></i> Contact</th>
                            <th><i class="fas fa-bed"></i> Room Type</th>
                            <th><i class="fas fa-calendar-alt"></i> Check-In</th>
                            <th><i class="fas fa-calendar-alt"></i> Check-Out</th>
                            <th><i class="fas fa-clock"></i> Days</th>
                            <th><i class="fas fa-dollar-sign"></i> Total Bill</th>
                            <th><i class="fas fa-tag"></i> Status</th>
                            <th><i class="fas fa-cog"></i> Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for(Reservation r : reservations){
                                long days = java.time.temporal.ChronoUnit.DAYS.between(
                                    r.getCheckIn().toLocalDate(),
                                    r.getCheckOut().toLocalDate()
                                );
                                String statusClass = "status-" + r.getStatus();
                        %>
                        <tr>
                            <td><strong>#<%= r.getReservationId() %></strong></td>
                            <td>
                                <div style="font-weight: 500;"><%= r.getGuestName() %></div>
                            </td>
                            <td><%= r.getAddress().length() > 30 ? r.getAddress().substring(0, 30) + "..." : r.getAddress() %></td>
                            <td><%= r.getContactNumber() %></td>
                            <td>
                                <span class="room-type">
                                    <i class="fas fa-door-open"></i>
                                    <%= r.getRoomType() %>
                                </span>
                            </td>
                            <td><%= r.getCheckIn().toLocalDate().format(dateFormatter) %></td>
                            <td><%= r.getCheckOut().toLocalDate().format(dateFormatter) %></td>
                            <td><strong><%= days %></strong> nights</td>
                            <td class="amount">LKR <%= String.format("%,.2f", r.getTotalBill()) %></td>
                            <td>
                                <span class="status-badge <%= statusClass %>">
                                    <i class="fas fa-<%= "ACTIVE".equals(r.getStatus()) ? "check-circle" : 
                                                      "COMPLETE".equals(r.getStatus()) ? "check-double" : 
                                                      "times-circle" %>"></i>
                                    <%= r.getStatus() %>
                                </span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <% if("ACTIVE".equals(r.getStatus())) { %>
                                        <!-- Status Update Form -->
                                        <form class="status-form" action="ReservationServlet" method="post">
                                            <input type="hidden" name="action" value="updateStatus">
                                            <input type="hidden" name="id" value="<%= r.getReservationId() %>">
                                            <select name="status" class="status-select">
                                                <option value="ACTIVE" <%= "ACTIVE".equals(r.getStatus()) ? "selected" : "" %>>Active</option>
                                                <option value="COMPLETE" <%= "COMPLETE".equals(r.getStatus()) ? "selected" : "" %>>Complete</option>
                                                <option value="CANCELED" <%= "CANCELED".equals(r.getStatus()) ? "selected" : "" %>>Canceled</option>
                                            </select>
                                            <button type="submit" class="action-btn btn-update" title="Update Status">
                                                <i class="fas fa-sync-alt"></i>
                                            </button>
                                        </form>

                                        <!-- Edit Button -->
                                        <form style="display:inline;" action="ReservationServlet" method="get">
                                            <input type="hidden" name="action" value="edit">
                                            <input type="hidden" name="id" value="<%= r.getReservationId() %>">
                                            <button type="submit" class="action-btn btn-edit" title="Edit Reservation">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                        </form>
                                    <% } else { %>
                                        <span class="locked-badge" title="Reservation is locked">
                                            <i class="fas fa-lock"></i>
                                            Locked
                                        </span>
                                    <% } %>

                                    <!-- Bill Button (Always Enabled) -->
                                    <form style="display:inline;" action="<%=request.getContextPath()%>/BillServlet" method="get" target="_blank">
                                        <input type="hidden" name="id" value="<%= r.getReservationId() %>">
                                        <button type="submit" class="action-btn btn-bill" title="Generate Bill">
                                            <i class="fas fa-file-invoice"></i>
                                            Bill
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>
    </div>

    <script>
        // Search and Filter Function
        function filterTable() {
            const searchInput = document.getElementById('searchInput').value.toLowerCase();
            const statusFilter = document.getElementById('statusFilter').value;
            const roomFilter = document.getElementById('roomFilter').value;
            const table = document.getElementById('reservationTable');
            const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');

            for (let row of rows) {
                let showRow = true;
                
                // Search filter
                if (searchInput) {
                    const guestName = row.cells[1].textContent.toLowerCase();
                    const contact = row.cells[3].textContent.toLowerCase();
                    const roomType = row.cells[4].textContent.toLowerCase();
                    
                    if (!guestName.includes(searchInput) && 
                        !contact.includes(searchInput) && 
                        !roomType.includes(searchInput)) {
                        showRow = false;
                    }
                }
                
                // Status filter
                if (showRow && statusFilter !== 'all') {
                    const status = row.cells[9].textContent.trim();
                    if (!status.includes(statusFilter)) {
                        showRow = false;
                    }
                }
                
                // Room type filter
                if (showRow && roomFilter !== 'all') {
                    const roomType = row.cells[4].textContent.trim();
                    if (!roomType.includes(roomFilter)) {
                        showRow = false;
                    }
                }
                
                row.style.display = showRow ? '' : 'none';
            }
        }

        // Export to CSV function
        function exportToCSV() {
            const table = document.getElementById('reservationTable');
            const rows = table.getElementsByTagName('tr');
            let csv = [];
            
            for (let row of rows) {
                const cells = row.getElementsByTagName('td');
                const rowData = [];
                for (let cell of cells) {
                    rowData.push('"' + cell.textContent.trim() + '"');
                }
                if (rowData.length > 0) {
                    csv.push(rowData.join(','));
                }
            }
            
            const csvContent = csv.join('\n');
            const blob = new Blob([csvContent], { type: 'text/csv' });
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'reservations.csv';
            a.click();
        }

        // Add keyboard shortcut for search (Ctrl+F)
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey && e.key === 'f') {
                e.preventDefault();
                document.getElementById('searchInput').focus();
            }
        });
    </script>
</body>
</html>