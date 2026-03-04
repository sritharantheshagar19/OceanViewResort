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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Ocean View Resort</title>
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

        /* Welcome Banner */
        .welcome-banner {
            background: white;
            margin: 30px 30px 20px 30px;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
        }

        .welcome-banner::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(102,126,234,0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .welcome-content {
            position: relative;
            z-index: 1;
        }

        .welcome-content h1 {
            font-size: 2.2rem;
            color: #2c3e50;
            margin-bottom: 10px;
        }

        .welcome-content h1 i {
            color: #667eea;
            margin-right: 10px;
        }

        .welcome-content p {
            color: #7f8c8d;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .welcome-content p i {
            color: #27ae60;
        }

        .date-time {
            position: absolute;
            top: 40px;
            right: 40px;
            text-align: right;
            z-index: 1;
        }

        .date {
            color: #7f8c8d;
            font-size: 1rem;
            margin-bottom: 5px;
        }

        .time {
            color: #2c3e50;
            font-size: 2rem;
            font-weight: 700;
        }

        /* Stats Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(102,126,234,0.1) 0%, transparent 70%);
            opacity: 0;
            transition: opacity 0.3s;
        }

        .stat-card:hover::before {
            opacity: 1;
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
        }

        .stat-icon i {
            font-size: 1.8rem;
            color: white;
        }

        .stat-details h3 {
            color: #7f8c8d;
            font-size: 0.95rem;
            font-weight: 500;
            margin-bottom: 10px;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 5px;
        }

        .stat-change {
            color: #27ae60;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* Main Container for Cards */
        .container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin: 30px;
        }

        .card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .card:hover::before {
            transform: scaleX(1);
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }

        .card-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
        }

        .card-icon i {
            font-size: 2.5rem;
            color: white;
        }

        .card h3 {
            color: #2c3e50;
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .card p {
            color: #7f8c8d;
            font-size: 0.95rem;
            margin-bottom: 20px;
            line-height: 1.5;
        }

        .card a {
            text-decoration: none;
            color: #667eea;
            font-weight: 600;
            font-size: 1rem;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: gap 0.3s;
        }

        .card a:hover {
            gap: 12px;
        }

        /* Logout Button */
        .logout-wrapper {
            text-align: center;
            margin: 40px 30px;
        }

        .logout-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: #e74c3c;
            color: white;
            padding: 12px 35px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }

        .logout-btn:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(231, 76, 60, 0.4);
        }

        .logout-btn i {
            font-size: 1.1rem;
        }

        /* Quick Actions Section */
        .quick-actions {
            margin: 30px;
        }

        .section-title {
            color: #2c3e50;
            font-size: 1.5rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            color: #667eea;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .welcome-banner {
                margin: 20px;
                padding: 30px;
            }
            
            .date-time {
                position: static;
                text-align: left;
                margin-top: 20px;
            }
            
            .stats-container {
                margin: 20px;
            }
            
            .container {
                margin: 20px;
            }
        }

        /* Loading Animation */
        @keyframes shimmer {
            0% { background-position: -1000px 0; }
            100% { background-position: 1000px 0; }
        }

        .loading {
            animation: shimmer 2s infinite linear;
            background: linear-gradient(to right, #f0f2f5 4%, #e0e0e0 25%, #f0f2f5 36%);
            background-size: 1000px 100%;
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

    <!-- Welcome Banner -->
    <div class="welcome-banner">
        <div class="date-time">
            <div class="date" id="currentDate"></div>
            <div class="time" id="currentTime"></div>
        </div>
        <div class="welcome-content">
            <h1>
                <i class="fas fa-hand-wave"></i>
                Welcome back, <%= user.getUsername() %>!
            </h1>
            <p>
                <i class="fas fa-calendar-check"></i>
                You have <strong>5 pending reservations</strong> to review today
            </p>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-bed"></i>
            </div>
            <div class="stat-details">
                <h3>Total Rooms</h3>
                <div class="stat-number">45</div>
                <div class="stat-change">
                    <i class="fas fa-arrow-up"></i>
                    12 available
                </div>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-user-check"></i>
            </div>
            <div class="stat-details">
                <h3>Current Guests</h3>
                <div class="stat-number">28</div>
                <div class="stat-change">
                    <i class="fas fa-arrow-up"></i>
                    8 checked in today
                </div>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-clock"></i>
            </div>
            <div class="stat-details">
                <h3>Pending Check-outs</h3>
                <div class="stat-number">12</div>
                <div class="stat-change">
                    <i class="fas fa-arrow-down"></i>
                    3 due today
                </div>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-dollar-sign"></i>
            </div>
            <div class="stat-details">
                <h3>Today's Revenue</h3>
                <div class="stat-number">LKR 45,200</div>
                <div class="stat-change">
                    <i class="fas fa-arrow-up"></i>
                    +15% from yesterday
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions Section -->
    <div class="quick-actions">
        <h2 class="section-title">
            <i class="fas fa-bolt"></i>
            Quick Actions
        </h2>
    </div>

    <!-- Main Menu Cards -->
    <div class="container">
        <div class="card">
            <div class="card-icon">
                <i class="fas fa-plus-circle"></i>
            </div>
            <h3>Add Reservation</h3>
            <p>Create a new booking for guests, assign rooms, and manage check-in details</p>
            <a href="<%=request.getContextPath()%>/ReservationServlet?action=add">
                Add Now <i class="fas fa-arrow-right"></i>
            </a>
        </div>

        <div class="card">
            <div class="card-icon">
                <i class="fas fa-list"></i>
            </div>
            <h3>View Reservations</h3>
            <p>View, search, and manage all existing reservations and guest details</p>
            <a href="<%=request.getContextPath()%>/ReservationServlet?action=list">
                View All <i class="fas fa-arrow-right"></i>
            </a>
        </div>

        <div class="card">
            <div class="card-icon">
                <i class="fas fa-door-open"></i>
            </div>
            <h3>Room Management</h3>
            <p>Manage room availability, room types, and view room status</p>
            <a href="<%=request.getContextPath()%>/RoomServlet?action=list">
                Manage <i class="fas fa-arrow-right"></i>
            </a>
        </div>

        <!-- Help Card (replaced Billing) -->
        <div class="card">
            <div class="card-icon">
                <i class="fas fa-question-circle"></i>
            </div>
            <h3>Help Guide</h3>
            <p>Get assistance with using the system, FAQs, and contact support for help</p>
            <a href="<%=request.getContextPath()%>/jsp/help.jsp">
                Get Help <i class="fas fa-arrow-right"></i>
            </a>
        </div>
    </div>

    <!-- Recent Activity Section -->
    <div style="margin: 30px;">
        <h2 class="section-title">
            <i class="fas fa-history"></i>
            Recent Activity
        </h2>
        <div style="background: white; border-radius: 15px; padding: 25px; box-shadow: 0 5px 20px rgba(0,0,0,0.05);">
            <div style="display: flex; align-items: center; gap: 15px; padding: 10px 0; border-bottom: 1px solid #f0f0f0;">
                <div style="width: 40px; height: 40px; background: #e8f0fe; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                    <i class="fas fa-check" style="color: #27ae60;"></i>
                </div>
                <div style="flex: 1;">
                    <div style="color: #2c3e50; font-weight: 500;">New reservation added for Room 204</div>
                    <div style="color: #95a5a6; font-size: 0.85rem;">5 minutes ago</div>
                </div>
            </div>
            <div style="display: flex; align-items: center; gap: 15px; padding: 10px 0; border-bottom: 1px solid #f0f0f0;">
                <div style="width: 40px; height: 40px; background: #e8f0fe; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                    <i class="fas fa-sign-out-alt" style="color: #e74c3c;"></i>
                </div>
                <div style="flex: 1;">
                    <div style="color: #2c3e50; font-weight: 500;">Guest checked out from Room 101</div>
                    <div style="color: #95a5a6; font-size: 0.85rem;">15 minutes ago</div>
                </div>
            </div>
            <div style="display: flex; align-items: center; gap: 15px; padding: 10px 0;">
                <div style="width: 40px; height: 40px; background: #e8f0fe; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                    <i class="fas fa-dollar-sign" style="color: #f39c12;"></i>
                </div>
                <div style="flex: 1;">
                    <div style="color: #2c3e50; font-weight: 500;">Payment received - LKR 25,000</div>
                    <div style="color: #95a5a6; font-size: 0.85rem;">30 minutes ago</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Logout Button -->
    <div class="logout-wrapper">
        <a class="logout-btn" href="<%=request.getContextPath()%>/LogoutServlet">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </div>

    <script>
        // Update date and time
        function updateDateTime() {
            const now = new Date();
            
            const dateOptions = { 
                weekday: 'long', 
                year: 'numeric', 
                month: 'long', 
                day: 'numeric' 
            };
            document.getElementById('currentDate').textContent = 
                now.toLocaleDateString('en-US', dateOptions);
            
            const timeOptions = { 
                hour: '2-digit', 
                minute: '2-digit', 
                second: '2-digit',
                hour12: true 
            };
            document.getElementById('currentTime').textContent = 
                now.toLocaleTimeString('en-US', timeOptions);
        }
        
        updateDateTime();
        setInterval(updateDateTime, 1000);
    </script>
</body>
</html>