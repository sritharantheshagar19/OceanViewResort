<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Room" %>
<%@ page import="model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }

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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Room - Ocean View Resort</title>
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
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Navbar */
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
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
        .container {
            width: 550px;
            margin-top: 80px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
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

        /* Header */
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 30px;
            color: white;
            text-align: center;
            position: relative;
        }

        .header h2 {
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .header h2 i {
            font-size: 2.2rem;
        }

        .header p {
            font-size: 0.95rem;
            opacity: 0.9;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .room-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            background: rgba(255,255,255,0.2);
            padding: 8px 15px;
            border-radius: 50px;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 8px;
            backdrop-filter: blur(5px);
        }

        .room-badge i {
            color: #ffd700;
        }

        /* Form Body */
        .form-body {
            padding: 40px;
        }

        /* Message Styles */
        .message {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: shake 0.5s ease;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .message i {
            font-size: 1.3rem;
        }

        .message.success {
            background: #d4edda;
            color: #155724;
            border-left: 5px solid #28a745;
        }

        .message.error {
            background: #f8d7da;
            color: #721c24;
            border-left: 5px solid #dc3545;
        }

        /* Validation Summary */
        .validation-summary {
            background: #fff3cd;
            color: #856404;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            border-left: 5px solid #ffc107;
            display: none;
        }

        .validation-summary.show {
            display: block;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .validation-summary h4 {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
            font-size: 1rem;
        }

        .validation-summary ul {
            list-style: none;
            padding-left: 25px;
        }

        .validation-summary li {
            margin-bottom: 5px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .validation-summary li i {
            font-size: 0.8rem;
            color: #856404;
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: #2c3e50;
            font-weight: 500;
            font-size: 1rem;
        }

        .form-group label i {
            color: #667eea;
            margin-right: 10px;
            width: 20px;
        }

        .form-group label .required {
            color: #e74c3c;
            margin-left: 4px;
        }

        /* Input Wrapper */
        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-wrapper i {
            position: absolute;
            left: 15px;
            color: #95a5a6;
            font-size: 1.1rem;
            transition: color 0.3s;
            pointer-events: none;
        }

        .input-wrapper input {
            width: 100%;
            padding: 14px 15px 14px 45px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s;
            outline: none;
            background: white;
        }

        .input-wrapper input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102,126,234,0.1);
        }

        .input-wrapper input:focus ~ i {
            color: #667eea;
        }

        .input-wrapper input:read-only {
            background: #f8f9fa;
            cursor: not-allowed;
        }

        /* Validation Feedback */
        .validation-feedback {
            display: block;
            margin-top: 8px;
            font-size: 0.85rem;
            min-height: 20px;
        }

        .validation-feedback i {
            margin-right: 5px;
            font-size: 0.85rem;
        }

        .valid-feedback {
            color: #28a745;
        }

        .invalid-feedback {
            color: #dc3545;
        }

        /* Input Validation States */
        .input-wrapper.valid input {
            border-color: #28a745;
        }

        .input-wrapper.invalid input {
            border-color: #dc3545;
        }

        /* Price Preview */
        .price-preview {
            background: linear-gradient(135deg, #667eea10 0%, #764ba210 100%);
            border: 2px dashed #667eea40;
            border-radius: 12px;
            padding: 20px;
            margin: 20px 0 25px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .price-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
        }

        .price-info {
            flex: 1;
        }

        .price-info h4 {
            color: #2c3e50;
            font-size: 0.9rem;
            font-weight: 500;
            margin-bottom: 5px;
        }

        .price-display {
            font-size: 1.8rem;
            font-weight: 700;
            color: #667eea;
            line-height: 1;
        }

        .price-display small {
            font-size: 0.9rem;
            font-weight: 400;
            color: #7f8c8d;
            margin-left: 5px;
        }

        /* Button Group */
        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 10px;
        }

        .btn {
            flex: 1;
            padding: 14px;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: all 0.3s;
            text-decoration: none;
        }

        .btn-save {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(102,126,234,0.3);
        }

        .btn-save:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102,126,234,0.4);
        }

        .btn-cancel {
            background: #e74c3c;
            color: white;
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }

        .btn-cancel:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(231, 76, 60, 0.4);
        }

        .btn i {
            font-size: 1.1rem;
        }

        .btn.loading {
            position: relative;
            pointer-events: none;
            opacity: 0.8;
        }

        .btn.loading i {
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        /* Quick Tips */
        .quick-tips {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 15px 20px;
            margin-top: 25px;
        }

        .quick-tips h5 {
            color: #2c3e50;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.95rem;
        }

        .quick-tips h5 i {
            color: #667eea;
        }

        .quick-tips ul {
            list-style: none;
        }

        .quick-tips li {
            color: #7f8c8d;
            font-size: 0.85rem;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .quick-tips li i {
            color: #27ae60;
            font-size: 0.75rem;
        }

        /* Info Note */
        .info-note {
            background: #e8f0fe;
            border-radius: 10px;
            padding: 12px 15px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            color: #2c3e50;
            font-size: 0.9rem;
            border-left: 4px solid #667eea;
        }

        .info-note i {
            color: #667eea;
            font-size: 1.1rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .navbar {
                padding: 1rem;
            }
            
            .nav-brand span {
                font-size: 1.2rem;
            }
            
            .container {
                width: 95%;
                margin-top: 70px;
            }
            
            .form-body {
                padding: 25px;
            }
            
            .price-display {
                font-size: 1.5rem;
            }
            
            .btn-group {
                flex-direction: column;
            }
            
            .room-badge {
                position: static;
                margin-top: 15px;
                display: inline-flex;
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
            <i class="fas fa-user-circle"></i>
            <span><%= user.getUsername() %></span>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="container">
        <!-- Header -->
        <div class="header">
            <div class="room-badge">
                <i class="fas fa-hashtag"></i>
                <%= room.getRoomType() %>
            </div>
            <h2>
                <i class="fas fa-edit"></i>
                Edit Room
            </h2>
            <p>
                <i class="fas fa-info-circle"></i>
                Update room type and pricing information
            </p>
        </div>

        <!-- Form Body -->
        <div class="form-body">
            <!-- Success / Error Messages from Server -->
            <% if(request.getAttribute("success") != null) { %>
                <div class="message success">
                    <i class="fas fa-check-circle"></i>
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>

            <% if(request.getAttribute("error") != null) { %>
                <div class="message error">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <!-- Validation Summary (shown on submit if validation fails) -->
            <div class="validation-summary" id="validationSummary">
                <h4>
                    <i class="fas fa-exclamation-triangle"></i>
                    Please fix the following errors:
                </h4>
                <ul id="errorList"></ul>
            </div>

            <!-- Info Note -->
            <div class="info-note">
                <i class="fas fa-info-circle"></i>
                <span>You are editing room: <strong><%= room.getRoomType() %></strong></span>
            </div>

            <!-- Edit Room Form -->
            <form action="RoomServlet" method="post" id="editRoomForm" novalidate>
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="old_room_type" value="<%= room.getRoomType() %>">

                <!-- Room Type -->
                <div class="form-group">
                    <label>
                        <i class="fas fa-tag"></i>
                        Room Type <span class="required">*</span>
                    </label>
                    <div class="input-wrapper" id="roomTypeWrapper">
                        <i class="fas fa-bed"></i>
                        <input type="text" name="room_type" id="roomType" 
                               placeholder="e.g., DELUXE, SUITE, STANDARD" 
                               value="<%= room.getRoomType() %>"
                               required>
                    </div>
                    <div class="validation-feedback" id="roomTypeFeedback"></div>
                </div>

                <!-- Price Per Night -->
                <div class="form-group">
                    <label>
                        <i class="fas fa-dollar-sign"></i>
                        Price Per Night (LKR) <span class="required">*</span>
                    </label>
                    <div class="input-wrapper" id="priceWrapper">
                        <i class="fas fa-tag"></i>
                        <input type="number" name="price_per_night" id="pricePerNight" 
                               placeholder="Enter price in LKR" 
                               step="0.01" min="0" 
                               value="<%= room.getPricePerNight() %>"
                               required>
                    </div>
                    <div class="validation-feedback" id="priceFeedback"></div>
                </div>

                <!-- Price Preview -->
                <div class="price-preview" id="pricePreview">
                    <div class="price-icon">
                        <i class="fas fa-calculator"></i>
                    </div>
                    <div class="price-info">
                        <h4>Current Price</h4>
                        <div class="price-display" id="priceDisplay">
                            LKR <%= String.format("%,.2f", room.getPricePerNight()) %>
                            <small>per night</small>
                        </div>
                    </div>
                </div>

                <!-- Quick Tips -->
                <div class="quick-tips">
                    <h5>
                        <i class="fas fa-lightbulb"></i>
                        Quick Tips
                    </h5>
                    <ul>
                        <li>
                            <i class="fas fa-check-circle"></i>
                            Room type should be in uppercase (e.g., DELUXE, SUITE)
                        </li>
                        <li>
                            <i class="fas fa-check-circle"></i>
                            Price must be a positive number
                        </li>
                        <li>
                            <i class="fas fa-check-circle"></i>
                            Changing room type may affect existing reservations
                        </li>
                    </ul>
                </div>

                <!-- Button Group -->
                <div class="btn-group">
                    <a href="RoomServlet?action=list" class="btn btn-cancel">
                        <i class="fas fa-times"></i>
                        Cancel
                    </a>
                    <button type="submit" class="btn btn-save" id="submitBtn">
                        <i class="fas fa-save"></i>
                        Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Get form elements
        const form = document.getElementById('editRoomForm');
        const submitBtn = document.getElementById('submitBtn');
        const validationSummary = document.getElementById('validationSummary');
        const errorList = document.getElementById('errorList');
        
        // Input elements
        const roomType = document.getElementById('roomType');
        const pricePerNight = document.getElementById('pricePerNight');
        
        // Wrapper elements
        const roomTypeWrapper = document.getElementById('roomTypeWrapper');
        const priceWrapper = document.getElementById('priceWrapper');
        
        // Feedback elements
        const roomTypeFeedback = document.getElementById('roomTypeFeedback');
        const priceFeedback = document.getElementById('priceFeedback');
        
        // Price display
        const priceDisplay = document.getElementById('priceDisplay');

        // Real-time validation and price preview
        roomType.addEventListener('input', validateRoomType);
        pricePerNight.addEventListener('input', function() {
            validatePrice();
            updatePricePreview();
        });

        // Room Type Validation
        function validateRoomType() {
            const type = roomType.value.trim();
            
            if (type.length === 0) {
                setInvalid(roomTypeWrapper, roomTypeFeedback, 'Room type is required');
            } else if (type.length < 3) {
                setInvalid(roomTypeWrapper, roomTypeFeedback, 'Room type must be at least 3 characters');
            } else if (!/^[A-Za-z\s_]+$/.test(type)) {
                setInvalid(roomTypeWrapper, roomTypeFeedback, 'Room type can only contain letters, spaces, and underscores');
            } else {
                // Auto-format to uppercase
                roomType.value = type.toUpperCase();
                setValid(roomTypeWrapper, roomTypeFeedback, '✓ Valid room type');
            }
        }

        // Price Validation
        function validatePrice() {
            const price = parseFloat(pricePerNight.value);
            
            if (!pricePerNight.value) {
                setInvalid(priceWrapper, priceFeedback, 'Price is required');
            } else if (isNaN(price) || price <= 0) {
                setInvalid(priceWrapper, priceFeedback, 'Price must be greater than 0');
            } else if (price > 1000000) {
                setInvalid(priceWrapper, priceFeedback, 'Price seems too high (max 1,000,000)');
            } else {
                setValid(priceWrapper, priceFeedback, '✓ Valid price');
            }
        }

        // Update Price Preview
        function updatePricePreview() {
            const price = parseFloat(pricePerNight.value);
            if (price && price > 0) {
                priceDisplay.innerHTML = `LKR ${price.toLocaleString('en-LK', {minimumFractionDigits: 2, maximumFractionDigits: 2})} <small>per night</small>`;
            } else {
                priceDisplay.innerHTML = `LKR <%= String.format("%,.2f", room.getPricePerNight()) %> <small>per night</small>`;
            }
        }

        // Helper functions for validation styling
        function setInvalid(wrapper, feedback, message) {
            wrapper.classList.remove('valid');
            wrapper.classList.add('invalid');
            feedback.innerHTML = '<i class="fas fa-exclamation-circle"></i> ' + message;
            feedback.classList.remove('valid-feedback');
            feedback.classList.add('invalid-feedback');
        }

        function setValid(wrapper, feedback, message) {
            wrapper.classList.remove('invalid');
            wrapper.classList.add('valid');
            feedback.innerHTML = '<i class="fas fa-check-circle"></i> ' + message;
            feedback.classList.remove('invalid-feedback');
            feedback.classList.add('valid-feedback');
        }

        // Form submit handler
        form.addEventListener('submit', function(e) {
            // Run all validations
            validateRoomType();
            validatePrice();
            
            // Collect all errors
            const errors = [];
            
            // Room Type validation
            const type = roomType.value.trim();
            if (!type) {
                errors.push('Room type is required');
            } else if (type.length < 3) {
                errors.push('Room type must be at least 3 characters');
            } else if (!/^[A-Za-z\s_]+$/.test(type)) {
                errors.push('Room type can only contain letters, spaces, and underscores');
            }
            
            // Price validation
            const price = parseFloat(pricePerNight.value);
            if (!pricePerNight.value) {
                errors.push('Price is required');
            } else if (isNaN(price) || price <= 0) {
                errors.push('Price must be greater than 0');
            } else if (price > 1000000) {
                errors.push('Price seems too high (max 1,000,000)');
            }
            
            // If there are errors, show summary and prevent submission
            if (errors.length > 0) {
                e.preventDefault();
                
                // Display error summary
                errorList.innerHTML = '';
                errors.forEach(error => {
                    const li = document.createElement('li');
                    li.innerHTML = '<i class="fas fa-times-circle"></i> ' + error;
                    errorList.appendChild(li);
                });
                
                validationSummary.classList.add('show');
                
                // Scroll to validation summary
                validationSummary.scrollIntoView({ behavior: 'smooth', block: 'start' });
                
                return;
            }
            
            // No errors - format room type to uppercase
            roomType.value = roomType.value.trim().toUpperCase();
            
            // Add loading state
            submitBtn.classList.add('loading');
            submitBtn.innerHTML = '<i class="fas fa-spinner"></i> Saving...';
        });

        // Hide validation summary when user starts typing
        const inputs = [roomType, pricePerNight];
        inputs.forEach(input => {
            input.addEventListener('input', function() {
                validationSummary.classList.remove('show');
            });
        });

        // Prevent negative values in price field
        pricePerNight.addEventListener('keydown', function(e) {
            if (e.key === '-' || e.key === 'e') {
                e.preventDefault();
            }
        });

        // Auto-format room type to uppercase on blur
        roomType.addEventListener('blur', function() {
            this.value = this.value.trim().toUpperCase();
            validateRoomType();
        });

        // Run initial validations
        window.addEventListener('load', function() {
            validateRoomType();
            validatePrice();
        });
    </script>
</body>
</html>