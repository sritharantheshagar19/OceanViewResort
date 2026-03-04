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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Management - Ocean View Resort</title>
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }

        /* Navbar */
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
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
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
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

        /* Header Card */
        .header-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            display: flex;
            justify-content: space-between;
            align-items: center;
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
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .header-left p i {
            color: #27ae60;
        }

        .add-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 14px 30px;
            border-radius: 12px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 12px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(102,126,234,0.3);
            border: none;
            cursor: pointer;
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102,126,234,0.4);
        }

        .add-btn i {
            font-size: 1.2rem;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            gap: 15px;
            transition: all 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
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

        .stat-info .sub-text {
            color: #95a5a6;
            font-size: 0.85rem;
            margin-top: 5px;
        }

        /* Table Container */
        .table-container {
            background: white;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow-x: auto;
        }

        /* Search Bar */
        .search-bar {
            margin-bottom: 20px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
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
            font-size: 0.95rem;
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
        }

        .filter-select {
            padding: 12px 25px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 0.95rem;
            outline: none;
            cursor: pointer;
            background: white;
        }

        .filter-select:focus {
            border-color: #667eea;
        }

        /* Table Styles */
        .room-table {
            width: 100%;
            border-collapse: collapse;
        }

        .room-table th {
            background: #f8fafc;
            color: #2c3e50;
            font-weight: 600;
            font-size: 0.9rem;
            padding: 15px;
            text-align: left;
            border-bottom: 2px solid #e0e0e0;
        }

        .room-table th i {
            margin-right: 8px;
            color: #667eea;
        }

        .room-table td {
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
            color: #2c3e50;
            font-size: 0.95rem;
        }

        .room-table tbody tr {
            transition: all 0.3s;
        }

        .room-table tbody tr:hover {
            background: #f8fafc;
            transform: scale(1.01);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        /* Room Type Badge */
        .room-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 6px 15px;
            border-radius: 50px;
            font-weight: 500;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .room-badge i {
            font-size: 0.9rem;
        }

        /* Price Tag */
        .price-tag {
            font-weight: 600;
            color: #27ae60;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .price-tag i {
            color: #f39c12;
            font-size: 1rem;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .action-btn {
            padding: 8px 15px;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.85rem;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
            text-decoration: none;
        }

        .edit-btn {
            background: #27ae60;
            color: white;
        }

        .edit-btn:hover {
            background: #1f8a4d;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(39, 174, 96, 0.3);
        }

        .delete-btn {
            background: #e74c3c;
            color: white;
            border: none;
        }

        .delete-btn:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
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

        .empty-state p {
            margin-bottom: 20px;
        }

        /* Footer Links */
        .footer-links {
            margin-top: 25px;
            text-align: center;
        }

        .footer-links a {
            color: white;
            text-decoration: none;
            font-size: 0.95rem;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: rgba(255,255,255,0.2);
            border-radius: 50px;
            transition: all 0.3s;
        }

        .footer-links a:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-2px);
        }

        .footer-links a i {
            font-size: 1rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .header-card {
                flex-direction: column;
                text-align: center;
            }
            
            .search-bar {
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
            
            .room-table td, .room-table th {
                padding: 10px;
                font-size: 0.85rem;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .action-btn {
                width: 100%;
                justify-content: center;
            }
        }

        /* Delete Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .modal.show {
            display: flex;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .modal-content {
            background: white;
            border-radius: 15px;
            padding: 30px;
            max-width: 400px;
            width: 90%;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .modal-content h3 {
            color: #2c3e50;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .modal-content h3 i {
            color: #e74c3c;
        }

        .modal-content p {
            color: #7f8c8d;
            margin-bottom: 25px;
        }

        .modal-buttons {
            display: flex;
            gap: 15px;
        }

        .modal-btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .modal-btn.cancel {
            background: #95a5a6;
            color: white;
        }

        .modal-btn.cancel:hover {
            background: #7f8c8d;
        }

        .modal-btn.delete {
            background: #e74c3c;
            color: white;
        }

        .modal-btn.delete:hover {
            background: #c0392b;
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
    <div class="main-container">
        <!-- Header Card -->
        <div class="header-card">
            <div class="header-left">
                <h1>
                    <i class="fas fa-door-open"></i>
                    Room Management
                </h1>
                <p>
                    <i class="fas fa-info-circle"></i>
                    Manage room types and their pricing
                </p>
            </div>
            <a href="RoomServlet?action=add" class="add-btn">
                <i class="fas fa-plus-circle"></i>
                Add New Room Type
            </a>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-bed"></i>
                </div>
                <div class="stat-info">
                    <h3>Total Room Types</h3>
                    <div class="number"><%= rooms.size() %></div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-tag"></i>
                </div>
                <div class="stat-info">
                    <h3>Price Range</h3>
                    <div class="number">
                        <% 
                            if(!rooms.isEmpty()) {
                                double min = Double.MAX_VALUE;
                                double max = Double.MIN_VALUE;
                                for(Room r : rooms) {
                                    min = Math.min(min, r.getPricePerNight());
                                    max = Math.max(max, r.getPricePerNight());
                                }
                        %>
                            LKR <%= String.format("%,.0f", min) %> - <%= String.format("%,.0f", max) %>
                        <% } else { %>
                            No rooms
                        <% } %>
                    </div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-star"></i>
                </div>
                <div class="stat-info">
                    <h3>Most Expensive</h3>
                    <div class="number">
                        <% 
                            if(!rooms.isEmpty()) {
                                Room maxRoom = rooms.stream()
                                    .max((r1, r2) -> Double.compare(r1.getPricePerNight(), r2.getPricePerNight()))
                                    .orElse(null);
                                if(maxRoom != null) {
                        %>
                            <%= maxRoom.getRoomType() %>
                        <% }} %>
                    </div>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-info">
                    <h3>Last Updated</h3>
                    <div class="number">
                        <%= new java.text.SimpleDateFormat("dd MMM yyyy").format(new java.util.Date()) %>
                    </div>
                </div>
            </div>
        </div>

        <!-- Table Container -->
        <div class="table-container">
            <!-- Search Bar -->
            <div class="search-bar">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search by room type..." onkeyup="filterTable()">
                </div>
                <div class="filter-options">
                    <select class="filter-select" id="priceFilter" onchange="filterTable()">
                        <option value="all">All Prices</option>
                        <option value="0-5000">Below 5,000</option>
                        <option value="5000-10000">5,000 - 10,000</option>
                        <option value="10000-15000">10,000 - 15,000</option>
                        <option value="15000+">Above 15,000</option>
                    </select>
                </div>
            </div>

            <!-- Rooms Table -->
            <% if(rooms.isEmpty()) { %>
                <div class="empty-state">
                    <i class="fas fa-door-closed"></i>
                    <h3>No Room Types Found</h3>
                    <p>Start by adding a new room type to the system</p>
                    <a href="RoomServlet?action=add" class="add-btn" style="display: inline-flex;">
                        <i class="fas fa-plus-circle"></i>
                        Add New Room Type
                    </a>
                </div>
            <% } else { %>
                <table class="room-table" id="roomTable">
                    <thead>
                        <tr>
                            <th><i class="fas fa-tag"></i> Room Type</th>
                            <th><i class="fas fa-dollar-sign"></i> Price Per Night</th>
                            <th><i class="fas fa-cog"></i> Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Room r : rooms) { %>
                        <tr>
                            <td>
                                <span class="room-badge">
                                    <i class="fas fa-bed"></i>
                                    <%= r.getRoomType() %>
                                </span>
                            </td>
                            <td>
                                <span class="price-tag">
                                    <i class="fas fa-tag"></i>
                                    LKR <%= String.format("%,.2f", r.getPricePerNight()) %>
                                </span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="RoomServlet?action=edit&room_type=<%= r.getRoomType() %>" 
                                       class="action-btn edit-btn">
                                        <i class="fas fa-edit"></i>
                                        Edit
                                    </a>
                                    <button onclick="showDeleteModal('<%= r.getRoomType() %>')" 
                                            class="action-btn delete-btn">
                                        <i class="fas fa-trash"></i>
                                        Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>

        <!-- Footer Links -->
        <div class="footer-links">
            <a href="<%=request.getContextPath()%>/jsp/dashboard.jsp">
                <i class="fas fa-arrow-left"></i>
                Back to Dashboard
            </a>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal" id="deleteModal">
        <div class="modal-content">
            <h3>
                <i class="fas fa-exclamation-triangle"></i>
                Confirm Delete
            </h3>
            <p>Are you sure you want to delete this room type? This action cannot be undone.</p>
            <div class="modal-buttons">
                <button class="modal-btn cancel" onclick="hideDeleteModal()">
                    <i class="fas fa-times"></i>
                    Cancel
                </button>
                <form id="deleteForm" action="RoomServlet" method="post" style="flex: 1;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="room_type" id="deleteRoomType">
                    <button type="submit" class="modal-btn delete">
                        <i class="fas fa-trash"></i>
                        Delete
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Search and Filter Function
        function filterTable() {
            const searchInput = document.getElementById('searchInput').value.toLowerCase();
            const priceFilter = document.getElementById('priceFilter').value;
            const table = document.getElementById('roomTable');
            
            if (!table) return;
            
            const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');

            for (let row of rows) {
                let showRow = true;
                
                // Search filter
                if (searchInput) {
                    const roomType = row.cells[0].textContent.toLowerCase();
                    if (!roomType.includes(searchInput)) {
                        showRow = false;
                    }
                }
                
                // Price filter
                if (showRow && priceFilter !== 'all') {
                    const priceText = row.cells[1].textContent;
                    const price = parseFloat(priceText.replace(/[^0-9.-]+/g, ''));
                    
                    switch(priceFilter) {
                        case '0-5000':
                            if (price > 5000) showRow = false;
                            break;
                        case '5000-10000':
                            if (price < 5000 || price > 10000) showRow = false;
                            break;
                        case '10000-15000':
                            if (price < 10000 || price > 15000) showRow = false;
                            break;
                        case '15000+':
                            if (price < 15000) showRow = false;
                            break;
                    }
                }
                
                row.style.display = showRow ? '' : 'none';
            }
        }

        // Delete Modal Functions
        function showDeleteModal(roomType) {
            document.getElementById('deleteRoomType').value = roomType;
            document.getElementById('deleteModal').classList.add('show');
        }

        function hideDeleteModal() {
            document.getElementById('deleteModal').classList.remove('show');
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('deleteModal');
            if (event.target == modal) {
                hideDeleteModal();
            }
        }

        // Keyboard shortcut for search (Ctrl+F)
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey && e.key === 'f') {
                e.preventDefault();
                document.getElementById('searchInput').focus();
            }
        });

        // Export functionality (optional)
        function exportToCSV() {
            const table = document.getElementById('roomTable');
            if (!table) return;
            
            const rows = table.getElementsByTagName('tr');
            let csv = ['Room Type,Price Per Night (LKR)'];
            
            for (let i = 1; i < rows.length; i++) {
                const cells = rows[i].getElementsByTagName('td');
                const roomType = cells[0].textContent.trim();
                const price = cells[1].textContent.replace(/[^0-9.-]+/g, '');
                csv.push(`"${roomType}",${price}`);
            }
            
            const csvContent = csv.join('\n');
            const blob = new Blob([csvContent], { type: 'text/csv' });
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'room_types.csv';
            a.click();
        }
    </script>
</body>
</html>