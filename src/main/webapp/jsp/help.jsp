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
    <title>Help Guide - Ocean View Resort</title>
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
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
            background: rgba(255,255,255,0.2);
            padding: 8px 20px;
            border-radius: 50px;
            color: white;
        }

        .user-info i {
            font-size: 1.2rem;
        }

        .user-info .role {
            background: rgba(255,255,255,0.3);
            padding: 4px 10px;
            border-radius: 50px;
            font-size: 0.75rem;
            margin-left: 10px;
        }

        /* Main Content */
        .main-content {
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

        /* Header */
        .help-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            padding: 40px;
            color: white;
            margin-bottom: 30px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(102,126,234,0.3);
        }

        .help-header::before {
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

        .help-header h1 {
            font-size: 2.5rem;
            margin-bottom: 15px;
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .help-header p {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
            max-width: 600px;
        }

        /* Search Bar */
        .search-container {
            margin-bottom: 30px;
        }

        .search-box {
            position: relative;
            max-width: 600px;
            margin: 0 auto;
        }

        .search-box i {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #95a5a6;
            font-size: 1.2rem;
        }

        .search-box input {
            width: 100%;
            padding: 15px 20px 15px 55px;
            border: none;
            border-radius: 50px;
            font-size: 1rem;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            outline: none;
            border: 2px solid transparent;
            transition: all 0.3s;
        }

        .search-box input:focus {
            border-color: #667eea;
            box-shadow: 0 10px 30px rgba(102,126,234,0.2);
        }

        /* Quick Links */
        .quick-links {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-bottom: 40px;
        }

        .quick-link {
            background: white;
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            text-decoration: none;
            color: #2c3e50;
            transition: all 0.3s;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }

        .quick-link:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(102,126,234,0.2);
            color: #667eea;
        }

        .quick-link i {
            font-size: 2rem;
            color: #667eea;
            margin-bottom: 10px;
        }

        .quick-link span {
            display: block;
            font-weight: 500;
        }

        /* Help Categories */
        .categories-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .category-card {
            background: white;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            transition: all 0.3s;
        }

        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
        }

        .category-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }

        .category-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
        }

        .category-header h2 {
            color: #2c3e50;
            font-size: 1.3rem;
        }

        .help-list {
            list-style: none;
        }

        .help-item {
            margin-bottom: 15px;
            border-bottom: 1px solid #f0f0f0;
            padding-bottom: 15px;
        }

        .help-item:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .help-question {
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            color: #2c3e50;
            font-weight: 500;
            transition: color 0.3s;
        }

        .help-question:hover {
            color: #667eea;
        }

        .help-question i {
            color: #667eea;
            transition: transform 0.3s;
        }

        .help-question.active i {
            transform: rotate(180deg);
        }

        .help-answer {
            display: none;
            padding: 15px 0 5px;
            color: #7f8c8d;
            line-height: 1.6;
            font-size: 0.95rem;
        }

        .help-answer.show {
            display: block;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .help-answer ul, .help-answer ol {
            margin-left: 20px;
            margin-top: 10px;
        }

        .help-answer li {
            margin-bottom: 5px;
        }

        .help-answer code {
            background: #f0f2f5;
            padding: 2px 6px;
            border-radius: 4px;
            font-family: monospace;
            color: #e74c3c;
        }

        .note-box {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
            color: #856404;
        }

        .note-box i {
            margin-right: 10px;
        }

        .tip-box {
            background: #d4edda;
            border-left: 4px solid #28a745;
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
            color: #155724;
        }

        .tip-box i {
            margin-right: 10px;
        }

        /* FAQ Section */
        .faq-section {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 40px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }

        .section-title {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #2c3e50;
            margin-bottom: 25px;
            font-size: 1.5rem;
        }

        .section-title i {
            color: #667eea;
        }

        .faq-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }

        .faq-item {
            background: #f8fafc;
            border-radius: 12px;
            padding: 20px;
            transition: all 0.3s;
        }

        .faq-item:hover {
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .faq-item h4 {
            color: #2c3e50;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .faq-item h4 i {
            color: #667eea;
            font-size: 1.1rem;
        }

        .faq-item p {
            color: #7f8c8d;
            font-size: 0.95rem;
            line-height: 1.6;
        }

        /* Contact Support */
        .support-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            padding: 40px;
            color: white;
            text-align: center;
            margin-bottom: 30px;
            position: relative;
            overflow: hidden;
        }

        .support-section::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        .support-content {
            position: relative;
            z-index: 1;
        }

        .support-content h3 {
            font-size: 2rem;
            margin-bottom: 15px;
        }

        .support-content p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 25px;
        }

        .contact-buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .contact-btn {
            padding: 15px 35px;
            border: none;
            border-radius: 50px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
            text-decoration: none;
        }

        .btn-email {
            background: white;
            color: #667eea;
        }

        .btn-email:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        .btn-chat {
            background: rgba(255,255,255,0.2);
            color: white;
            backdrop-filter: blur(5px);
        }

        .btn-chat:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-2px);
        }

        /* Back to Dashboard */
        .back-link {
            text-align: center;
            margin: 30px 0;
        }

        .back-link a {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 30px;
            background: white;
            color: #667eea;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        }

        .back-link a:hover {
            background: #667eea;
            color: white;
            transform: translateX(-5px);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 15px;
            }
            
            .help-header h1 {
                font-size: 2rem;
            }
            
            .categories-grid {
                grid-template-columns: 1fr;
            }
            
            .contact-buttons {
                flex-direction: column;
            }
            
            .contact-btn {
                width: 100%;
                justify-content: center;
            }
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
            <div class="user-info">
                <i class="fas fa-user-circle"></i>
                <span><%= user.getUsername() %></span>
                <span class="role">STAFF</span>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Help Header -->
        <div class="help-header">
            <h1>
                <i class="fas fa-question-circle"></i>
                Help & Support Guide
            </h1>
            <p>Find answers to common questions and learn how to use the Ocean View Resort management system effectively.</p>
        </div>

        <!-- Search Bar -->
        <div class="search-container">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="helpSearch" placeholder="Search for help topics..." onkeyup="searchHelp()">
            </div>
        </div>

        <!-- Quick Links -->
        <div class="quick-links">
            <a href="#" class="quick-link" onclick="scrollToSection('getting-started')">
                <i class="fas fa-rocket"></i>
                <span>Getting Started</span>
            </a>
            <a href="#" class="quick-link" onclick="scrollToSection('reservations')">
                <i class="fas fa-calendar-check"></i>
                <span>Reservations</span>
            </a>
            <a href="#" class="quick-link" onclick="scrollToSection('rooms')">
                <i class="fas fa-bed"></i>
                <span>Rooms</span>
            </a>
            <a href="#" class="quick-link" onclick="scrollToSection('billing')">
                <i class="fas fa-file-invoice"></i>
                <span>Billing</span>
            </a>
            <a href="#" class="quick-link" onclick="scrollToSection('faq')">
                <i class="fas fa-question"></i>
                <span>FAQ</span>
            </a>
            <a href="#" class="quick-link" onclick="scrollToSection('support')">
                <i class="fas fa-headset"></i>
                <span>Contact Support</span>
            </a>
        </div>

        <!-- Help Categories -->
        <div class="categories-grid">
            <!-- Getting Started -->
            <div class="category-card" id="getting-started">
                <div class="category-header">
                    <div class="category-icon">
                        <i class="fas fa-rocket"></i>
                    </div>
                    <h2>Getting Started</h2>
                </div>
                <ul class="help-list">
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>How do I log in to the system?</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>To log in to the Ocean View Resort system:</p>
                            <ol>
                                <li>Navigate to the login page</li>
                                <li>Enter your username and password</li>
                                <li>Click the "Login" button</li>
                            </ol>
                            <div class="note-box">
                                <i class="fas fa-info-circle"></i>
                                Default credentials: Username: <code>admin</code>, Password: <code>admin123</code>
                            </div>
                        </div>
                    </li>
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>What can I do from the dashboard?</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>The dashboard provides:</p>
                            <ul>
                                <li>Overview of resort statistics</li>
                                <li>Quick access to all major functions</li>
                                <li>Recent activity feed</li>
                                <li>Room status summary</li>
                                <li>Revenue chart</li>
                            </ul>
                        </div>
                    </li>
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>How do I log out safely?</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>Always log out properly:</p>
                            <ul>
                                <li>Click the "Logout" button at the bottom of the dashboard</li>
                                <li>Never close the browser without logging out</li>
                                <li>The system will redirect you to the login page</li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>

            <!-- Reservations -->
            <div class="category-card" id="reservations">
                <div class="category-header">
                    <div class="category-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <h2>Reservation Management</h2>
                </div>
                <ul class="help-list">
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>How do I create a new reservation?</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>To add a new reservation:</p>
                            <ol>
                                <li>Click "Add Reservation" on the dashboard</li>
                                <li>Fill in guest details (name, address, contact)</li>
                                <li>Select room type from the dropdown</li>
                                <li>Choose check-in and check-out dates</li>
                                <li>Click "Add Reservation" to save</li>
                            </ol>
                            <div class="tip-box">
                                <i class="fas fa-lightbulb"></i>
                                The reservation number is automatically generated.
                            </div>
                        </div>
                    </li>
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>How do I view all reservations?</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>To view reservations:</p>
                            <ul>
                                <li>Click "View Reservations" from the dashboard</li>
                                <li>Use the search bar to filter by guest name or contact</li>
                                <li>Filter by status using the dropdown</li>
                                <li>Click on any reservation to see details</li>
                            </ul>
                        </div>
                    </li>
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>How do I update a reservation status?</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>To update status:</p>
                            <ol>
                                <li>Go to "View Reservations"</li>
                                <li>Find the reservation in the table</li>
                                <li>Use the status dropdown in the Actions column</li>
                                <li>Select new status (ACTIVE, COMPLETE, CANCELED)</li>
                                <li>Click "Update" to save changes</li>
                            </ol>
                        </div>
                    </li>
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>How do I edit a reservation?</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>To edit reservation details:</p>
                            <ol>
                                <li>Go to "View Reservations"</li>
                                <li>Click the "Edit" button for the reservation</li>
                                <li>Modify the required fields</li>
                                <li>Click "Update Reservation" to save</li>
                            </ol>
                            <div class="note-box">
                                <i class="fas fa-info-circle"></i>
                                Only ACTIVE reservations can be edited.
                            </div>
                        </div>
                    </li>
                </ul>
            </div>

            <!-- Room Management -->
            <div class="category-card" id="rooms">
                <div class="category-header">
                    <div class="category-icon">
                        <i class="fas fa-bed"></i>
                    </div>
                    <h2>Room Management</h2>
                </div>
                <ul class="help-list">
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>How do I add a new room type?</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>To add a new room type:</p>
                            <ol>
                                <li>Go to "Room Management" from dashboard</li>
                                <li>Click "Add New Room Type"</li>
                                <li>Enter room type name (e.g., DELUXE, SUITE)</li>
                                <li>Set price per night</li>
                                <li>Click "Add Room" to save</li>
                            </ol>
                        </div>
                    </li>
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>How do I update room prices?</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>To edit room details:</p>
                            <ol>
                                <li>Go to "Room Management"</li>
                                <li>Click "Edit" for the room type</li>
                                <li>Modify room type or price</li>
                                <li>Click "Save Changes"</li>
                            </ol>
                        </div>
                    </li>
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>How do I delete a room type?</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>To delete a room type:</p>
                            <ol>
                                <li>Go to "Room Management"</li>
                                <li>Click "Delete" for the room type</li>
                                <li>Confirm deletion in the popup</li>
                            </ol>
                            <div class="note-box">
                                <i class="fas fa-exclamation-triangle"></i>
                                Cannot delete room types that have active reservations.
                            </div>
                        </div>
                    </li>
                </ul>
            </div>

            <!-- Billing -->
            <div class="category-card" id="billing">
                <div class="category-header">
                    <div class="category-icon">
                        <i class="fas fa-file-invoice"></i>
                    </div>
                    <h2>Billing & Invoices</h2>
                </div>
                <ul class="help-list">
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>How do I generate a bill?</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>To generate an invoice:</p>
                            <ol>
                                <li>Go to "View Reservations"</li>
                                <li>Click the "Bill" button for the reservation</li>
                                <li>The invoice will open in a new tab</li>
                                <li>Click "Print Invoice" to print or save as PDF</li>
                            </ol>
                        </div>
                    </li>
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>How is the total bill calculated?</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>The total bill is calculated as:</p>
                            <ul>
                                <li>Number of nights × Room rate per night</li>
                                <li>Check-in time: 2:00 PM</li>
                                <li>Check-out time: 11:00 AM</li>
                            </ul>
                            <div class="tip-box">
                                <i class="fas fa-calculator"></i>
                                The system automatically calculates based on dates selected.
                            </div>
                        </div>
                    </li>
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>Can I email the invoice?</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>Yes, from the invoice page:</p>
                            <ol>
                                <li>Click "Email Invoice" button</li>
                                <li>The system will send to the guest's email</li>
                                <li>A confirmation message will appear</li>
                            </ol>
                        </div>
                    </li>
                </ul>
            </div>

            <!-- System Features -->
            <div class="category-card">
                <div class="category-header">
                    <div class="category-icon">
                        <i class="fas fa-cog"></i>
                    </div>
                    <h2>System Features</h2>
                </div>
                <ul class="help-list">
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>Search and filter functionality</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>All list pages include:</p>
                            <ul>
                                <li><strong>Search box:</strong> Filter by guest name, contact, or room</li>
                                <li><strong>Status filter:</strong> Filter by reservation status</li>
                                <li><strong>Room type filter:</strong> Filter by room category</li>
                                <li><strong>Real-time filtering:</strong> Results update as you type</li>
                            </ul>
                        </div>
                    </li>
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>Keyboard shortcuts</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <ul>
                                <li><strong>Ctrl + F:</strong> Focus search box on any page</li>
                                <li><strong>Ctrl + P:</strong> Print invoice (on invoice page)</li>
                                <li><strong>Esc:</strong> Close modals/popups</li>
                            </ul>
                        </div>
                    </li>
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>Data validation rules</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <ul>
                                <li><strong>Phone number:</strong> Exactly 10 digits</li>
                                <li><strong>Guest name:</strong> Letters and spaces only</li>
                                <li><strong>Check-out:</strong> Must be after check-in date</li>
                                <li><strong>Price:</strong> Must be greater than 0</li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>

            <!-- Troubleshooting -->
            <div class="category-card">
                <div class="category-header">
                    <div class="category-icon">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <h2>Troubleshooting</h2>
                </div>
                <ul class="help-list">
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>Can't log in to the system</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>If you cannot log in:</p>
                            <ul>
                                <li>Check your username and password</li>
                                <li>Ensure Caps Lock is off</li>
                                <li>Contact administrator to reset password</li>
                                <li>Try default credentials: admin/admin123</li>
                            </ul>
                        </div>
                    </li>
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>Error when generating bill</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>If bill generation fails:</p>
                            <ul>
                                <li>Ensure reservation exists</li>
                                <li>Check if dates are valid</li>
                                <li>Verify room rate is set</li>
                                <li>Try again or contact support</li>
                            </ul>
                        </div>
                    </li>
                    <li class="help-item">
                        <div class="help-question" onclick="toggleAnswer(this)">
                            <span>Page not loading properly</span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="help-answer">
                            <p>Try these steps:</p>
                            <ul>
                                <li>Refresh the page (F5)</li>
                                <li>Clear browser cache</li>
                                <li>Use Chrome or Firefox for best results</li>
                                <li>Check internet connection</li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
        </div>

        <!-- FAQ Section -->
        <div class="faq-section" id="faq">
            <h3 class="section-title">
                <i class="fas fa-question-circle"></i>
                Frequently Asked Questions
            </h3>
            <div class="faq-grid">
                <div class="faq-item">
                    <h4><i class="fas fa-clock"></i> What are check-in/out times?</h4>
                    <p>Check-in is at 2:00 PM and check-out is at 11:00 AM. Early check-in or late check-out may be available upon request.</p>
                </div>
                <div class="faq-item">
                    <h4><i class="fas fa-phone"></i> Can I modify a reservation?</h4>
                    <p>Yes, you can edit active reservations from the View Reservations page. Completed or canceled reservations are locked.</p>
                </div>
                <div class="faq-item">
                    <h4><i class="fas fa-dollar-sign"></i> How are room rates set?</h4>
                    <p>Room rates are configured in Room Management. Each room type has its own rate per night.</p>
                </div>
                <div class="faq-item">
                    <h4><i class="fas fa-file-pdf"></i> Can I save invoices as PDF?</h4>
                    <p>Yes, click "Print Invoice" and choose "Save as PDF" from the print dialog.</p>
                </div>
                <div class="faq-item">
                    <h4><i class="fas fa-users"></i> How many guests per room?</h4>
                    <p>Standard rooms: 2 guests, Deluxe: 3 guests, Family: 4 guests, Suite: 4 guests.</p>
                </div>
                <div class="faq-item">
                    <h4><i class="fas fa-calendar"></i> What if dates are invalid?</h4>
                    <p>The system prevents past dates and ensures check-out is after check-in automatically.</p>
                </div>
            </div>
        </div>

        <!-- Contact Support -->
        <div class="support-section" id="support">
            <div class="support-content">
                <h3>Need More Help?</h3>
                <p>Our support team is available 24/7 to assist you with any questions or issues.</p>
                <div class="contact-buttons">
                    <button class="contact-btn btn-email" onclick="window.location.href='mailto:support@oceanviewresort.com'">
                        <i class="fas fa-envelope"></i>
                        Email Support
                    </button>
                    <button class="contact-btn btn-chat" onclick="alert('Live chat feature coming soon!')">
                        <i class="fas fa-comment"></i>
                        Live Chat
                    </button>
                </div>
                <p style="margin-top: 20px; font-size: 0.9rem;">
                    <i class="fas fa-phone"></i> Call us: +94 123 456 789
                </p>
            </div>
        </div>

        <!-- Back to Dashboard -->
        <div class="back-link">
            <a href="<%=request.getContextPath()%>/jsp/dashboard.jsp">
                <i class="fas fa-arrow-left"></i>
                Back to Dashboard
            </a>
        </div>
    </div>

    <script>
        // Toggle answer visibility
        function toggleAnswer(element) {
            element.classList.toggle('active');
            const answer = element.nextElementSibling;
            answer.classList.toggle('show');
        }

        // Search functionality
        function searchHelp() {
            const searchTerm = document.getElementById('helpSearch').value.toLowerCase();
            const helpItems = document.querySelectorAll('.help-item');
            const categories = document.querySelectorAll('.category-card');
            
            if (searchTerm.length < 2) {
                // Show everything if search is too short
                helpItems.forEach(item => {
                    item.style.display = 'block';
                });
                categories.forEach(cat => {
                    cat.style.display = 'block';
                });
                return;
            }
            
            categories.forEach(category => {
                let hasVisibleItems = false;
                const items = category.querySelectorAll('.help-item');
                
                items.forEach(item => {
                    const question = item.querySelector('.help-question span').textContent.toLowerCase();
                    const answer = item.querySelector('.help-answer').textContent.toLowerCase();
                    
                    if (question.includes(searchTerm) || answer.includes(searchTerm)) {
                        item.style.display = 'block';
                        hasVisibleItems = true;
                    } else {
                        item.style.display = 'none';
                    }
                });
                
                // Hide category if no visible items
                category.style.display = hasVisibleItems ? 'block' : 'none';
            });
        }

        // Scroll to section
        function scrollToSection(sectionId) {
            const element = document.getElementById(sectionId);
            if (element) {
                element.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        }

        // Open first item by default (optional)
        window.onload = function() {
            // Uncomment to open first item in each category
            // document.querySelectorAll('.help-item:first-child .help-question').forEach(q => {
            //     q.click();
            // });
        };
    </script>
</body>
</html>