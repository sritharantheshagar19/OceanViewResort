<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Add Reservation - Ocean View Resort</title>
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

        .container {
            width: 650px;
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
            padding: 25px 30px;
            color: white;
        }

        .header h2 {
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .header h2 i {
            font-size: 2rem;
        }

        .header p {
            font-size: 0.95rem;
            opacity: 0.9;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* Form Body */
        .form-body {
            padding: 30px;
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
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: 500;
            font-size: 0.95rem;
        }

        .form-group label i {
            color: #667eea;
            margin-right: 8px;
            width: 18px;
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
            font-size: 1rem;
            transition: color 0.3s;
            pointer-events: none;
        }

        .input-wrapper input,
        .input-wrapper select,
        .input-wrapper textarea {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s;
            outline: none;
            background: white;
        }

        .input-wrapper select {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%2395a5a6' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 16px;
        }

        .input-wrapper input:focus,
        .input-wrapper select:focus,
        .input-wrapper textarea:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102,126,234,0.1);
        }

        .input-wrapper input:focus ~ i,
        .input-wrapper select:focus ~ i,
        .input-wrapper textarea:focus ~ i {
            color: #667eea;
        }

        .input-wrapper textarea {
            resize: vertical;
            min-height: 80px;
        }

        /* Validation Feedback */
        .validation-feedback {
            display: block;
            margin-top: 5px;
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
        .input-wrapper.valid input,
        .input-wrapper.valid select,
        .input-wrapper.valid textarea {
            border-color: #28a745;
        }

        .input-wrapper.invalid input,
        .input-wrapper.invalid select,
        .input-wrapper.invalid textarea {
            border-color: #dc3545;
        }

        /* Date Info */
        .date-info {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin: 20px 0;
            display: flex;
            align-items: center;
            gap: 15px;
            color: #7f8c8d;
            font-size: 0.9rem;
            border: 1px dashed #e0e0e0;
        }

        .date-info i {
            color: #667eea;
            font-size: 1.2rem;
        }

        /* Button */
        .btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: all 0.3s;
            box-shadow: 0 5px 15px rgba(102,126,234,0.3);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102,126,234,0.4);
        }

        .btn i {
            font-size: 1.2rem;
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

        /* Footer Links */
        .footer-links {
            margin-top: 20px;
            text-align: center;
        }

        .footer-links a {
            color: #667eea;
            text-decoration: none;
            font-size: 0.95rem;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .footer-links a:hover {
            background: #f0f2f5;
            color: #764ba2;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                width: 100%;
                margin: 10px;
            }
            
            .header {
                padding: 20px;
            }
            
            .form-body {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h2>
                <i class="fas fa-plus-circle"></i>
                Add New Reservation
            </h2>
            <p>
                <i class="fas fa-info-circle"></i>
                Fill in the details to create a new reservation
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

            <!-- Reservation Form -->
            <form action="ReservationServlet" method="post" id="reservationForm" novalidate>
                <input type="hidden" name="action" value="add">

                <!-- Guest Name -->
                <div class="form-group">
                    <label>
                        <i class="fas fa-user"></i>
                        Guest Name <span class="required">*</span>
                    </label>
                    <div class="input-wrapper" id="guestNameWrapper">
                        <i class="fas fa-user"></i>
                        <input type="text" name="guest_name" id="guestName"
                               placeholder="Enter guest full name" 
                               value="<%= request.getParameter("guest_name") != null ? request.getParameter("guest_name") : "" %>"
                               required>
                    </div>
                    <div class="validation-feedback" id="guestNameFeedback"></div>
                </div>

                <!-- Address -->
                <div class="form-group">
                    <label>
                        <i class="fas fa-map-marker-alt"></i>
                        Address
                    </label>
                    <div class="input-wrapper">
                        <i class="fas fa-map-marker-alt"></i>
                        <textarea name="address" id="address" 
                                  placeholder="Enter complete address"><%= request.getParameter("address") != null ? request.getParameter("address") : "" %></textarea>
                    </div>
                </div>

                <!-- Contact Number -->
                <div class="form-group">
                    <label>
                        <i class="fas fa-phone"></i>
                        Contact Number <span class="required">*</span>
                    </label>
                    <div class="input-wrapper" id="phoneWrapper">
                        <i class="fas fa-phone"></i>
                        <input type="tel" name="contact_number" id="phoneNumber"
                               placeholder="Enter 10-digit phone number"
                               value="<%= request.getParameter("contact_number") != null ? request.getParameter("contact_number") : "" %>"
                               required>
                    </div>
                    <div class="validation-feedback" id="phoneFeedback"></div>
                </div>

                <!-- Room Type -->
                <div class="form-group">
                    <label>
                        <i class="fas fa-bed"></i>
                        Room Type <span class="required">*</span>
                    </label>
                    <div class="input-wrapper" id="roomTypeWrapper">
                        <i class="fas fa-hotel"></i>
                        <select name="room_type" id="roomType" required>
                            <option value="" disabled <%= request.getParameter("room_type") == null ? "selected" : "" %>>Select a room type</option>
                            <% 
                                String[] roomTypes = (String[]) request.getAttribute("roomTypes");
                                if(roomTypes != null){
                                    for(String rt : roomTypes){ 
                                        String selected = (request.getParameter("room_type") != null && request.getParameter("room_type").equals(rt)) ? "selected" : "";
                            %>
                                <option value="<%= rt %>" <%= selected %>><%= rt %></option>
                            <% 
                                    } 
                                } 
                            %>
                        </select>
                    </div>
                    <div class="validation-feedback" id="roomTypeFeedback"></div>
                </div>

                <!-- Check-in Date -->
                <div class="form-group">
                    <label>
                        <i class="fas fa-calendar-check"></i>
                        Check-in Date <span class="required">*</span>
                    </label>
                    <div class="input-wrapper" id="checkInWrapper">
                        <i class="fas fa-calendar-alt"></i>
                        <input type="date" name="check_in" id="checkIn" 
                               min="<%= java.time.LocalDate.now() %>"
                               value="<%= request.getParameter("check_in") != null ? request.getParameter("check_in") : "" %>"
                               required>
                    </div>
                    <div class="validation-feedback" id="checkInFeedback"></div>
                </div>

                <!-- Check-out Date -->
                <div class="form-group">
                    <label>
                        <i class="fas fa-calendar-check"></i>
                        Check-out Date <span class="required">*</span>
                    </label>
                    <div class="input-wrapper" id="checkOutWrapper">
                        <i class="fas fa-calendar-alt"></i>
                        <input type="date" name="check_out" id="checkOut" 
                               min="<%= java.time.LocalDate.now().plusDays(1) %>"
                               value="<%= request.getParameter("check_out") != null ? request.getParameter("check_out") : "" %>"
                               required>
                    </div>
                    <div class="validation-feedback" id="checkOutFeedback"></div>
                </div>

                <!-- Date Information -->
                <div class="date-info">
                    <i class="fas fa-clock"></i>
                    <span>Check-in: 2:00 PM | Check-out: 11:00 AM</span>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn" id="submitBtn">
                    <i class="fas fa-save"></i>
                    Add Reservation
                </button>
            </form>

            <!-- Footer Links -->
            <div class="footer-links">
                <a href="<%=request.getContextPath()%>/jsp/dashboard.jsp">
                    <i class="fas fa-arrow-left"></i>
                    Back to Dashboard
                </a>
            </div>
        </div>
    </div>

    <script>
        // Get form elements
        const form = document.getElementById('reservationForm');
        const submitBtn = document.getElementById('submitBtn');
        const validationSummary = document.getElementById('validationSummary');
        const errorList = document.getElementById('errorList');
        
        // Input elements
        const guestName = document.getElementById('guestName');
        const phoneNumber = document.getElementById('phoneNumber');
        const roomType = document.getElementById('roomType');
        const checkIn = document.getElementById('checkIn');
        const checkOut = document.getElementById('checkOut');
        
        // Wrapper elements
        const guestNameWrapper = document.getElementById('guestNameWrapper');
        const phoneWrapper = document.getElementById('phoneWrapper');
        const roomTypeWrapper = document.getElementById('roomTypeWrapper');
        const checkInWrapper = document.getElementById('checkInWrapper');
        const checkOutWrapper = document.getElementById('checkOutWrapper');
        
        // Feedback elements
        const guestNameFeedback = document.getElementById('guestNameFeedback');
        const phoneFeedback = document.getElementById('phoneFeedback');
        const roomTypeFeedback = document.getElementById('roomTypeFeedback');
        const checkInFeedback = document.getElementById('checkInFeedback');
        const checkOutFeedback = document.getElementById('checkOutFeedback');

        // Real-time validation (visual feedback only)
        guestName.addEventListener('input', validateGuestName);
        phoneNumber.addEventListener('input', validatePhone);
        roomType.addEventListener('change', validateRoomType);
        checkIn.addEventListener('change', validateDates);
        checkOut.addEventListener('change', validateDates);

        // Guest Name Validation (visual only)
        function validateGuestName() {
            const name = guestName.value.trim();
            
            if (name.length === 0) {
                setInvalid(guestNameWrapper, guestNameFeedback, 'Guest name is required');
            } else if (name.length < 3) {
                setInvalid(guestNameWrapper, guestNameFeedback, 'Guest name must be at least 3 characters');
            } else if (!/^[a-zA-Z\s]+$/.test(name)) {
                setInvalid(guestNameWrapper, guestNameFeedback, 'Guest name can only contain letters and spaces');
            } else {
                setValid(guestNameWrapper, guestNameFeedback, '✓ Valid guest name');
            }
        }

        // Phone Validation (visual only)
        function validatePhone() {
            let phone = phoneNumber.value.replace(/\D/g, '');
            
            if (phone.length === 0) {
                setInvalid(phoneWrapper, phoneFeedback, 'Phone number is required');
            } else if (phone.length !== 10) {
                setInvalid(phoneWrapper, phoneFeedback, 'Phone number must be exactly 10 digits');
            } else {
                phoneNumber.value = phone;
                setValid(phoneWrapper, phoneFeedback, '✓ Valid 10-digit phone number');
            }
        }

        // Room Type Validation (visual only)
        function validateRoomType() {
            if (!roomType.value) {
                setInvalid(roomTypeWrapper, roomTypeFeedback, 'Please select a room type');
            } else {
                setValid(roomTypeWrapper, roomTypeFeedback, '✓ Room type selected');
            }
        }

        // Date Validations (visual only)
        function validateDates() {
            validateCheckIn();
            validateCheckOut();
            
            if (checkIn.value && checkOut.value) {
                const checkInDate = new Date(checkIn.value);
                const checkOutDate = new Date(checkOut.value);
                
                if (checkOutDate <= checkInDate) {
                    setInvalid(checkOutWrapper, checkOutFeedback, 'Check-out must be after check-in date');
                }
            }
            
            // Update min date for checkout
            if (checkIn.value) {
                const checkInDate = new Date(checkIn.value);
                checkInDate.setDate(checkInDate.getDate() + 1);
                checkOut.min = checkInDate.toISOString().split('T')[0];
            }
        }

        function validateCheckIn() {
            if (!checkIn.value) {
                setInvalid(checkInWrapper, checkInFeedback, 'Check-in date is required');
                return;
            }
            
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            const checkInDate = new Date(checkIn.value);
            
            if (checkInDate < today) {
                setInvalid(checkInWrapper, checkInFeedback, 'Check-in date cannot be in the past');
            } else {
                setValid(checkInWrapper, checkInFeedback, '✓ Check-in date valid');
            }
        }

        function validateCheckOut() {
            if (!checkOut.value) {
                setInvalid(checkOutWrapper, checkOutFeedback, 'Check-out date is required');
                return;
            }
            
            if (checkIn.value) {
                const checkInDate = new Date(checkIn.value);
                const checkOutDate = new Date(checkOut.value);
                
                if (checkOutDate <= checkInDate) {
                    setInvalid(checkOutWrapper, checkOutFeedback, 'Check-out must be after check-in date');
                } else {
                    setValid(checkOutWrapper, checkOutFeedback, '✓ Check-out date valid');
                }
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

        // Form submit handler - validate all fields and show summary if errors
        form.addEventListener('submit', function(e) {
            // Run all validations
            validateGuestName();
            validatePhone();
            validateRoomType();
            validateDates();
            
            // Collect all errors
            const errors = [];
            
            // Guest Name validation
            const name = guestName.value.trim();
            if (!name) {
                errors.push('Guest name is required');
            } else if (name.length < 3) {
                errors.push('Guest name must be at least 3 characters');
            } else if (!/^[a-zA-Z\s]+$/.test(name)) {
                errors.push('Guest name can only contain letters and spaces');
            }
            
            // Phone validation
            const phone = phoneNumber.value.replace(/\D/g, '');
            if (!phone) {
                errors.push('Phone number is required');
            } else if (phone.length !== 10) {
                errors.push('Phone number must be exactly 10 digits');
            }
            
            // Room Type validation
            if (!roomType.value) {
                errors.push('Please select a room type');
            }
            
            // Date validations
            if (!checkIn.value) {
                errors.push('Check-in date is required');
            } else {
                const today = new Date();
                today.setHours(0, 0, 0, 0);
                const checkInDate = new Date(checkIn.value);
                if (checkInDate < today) {
                    errors.push('Check-in date cannot be in the past');
                }
            }
            
            if (!checkOut.value) {
                errors.push('Check-out date is required');
            }
            
            if (checkIn.value && checkOut.value) {
                const checkInDate = new Date(checkIn.value);
                const checkOutDate = new Date(checkOut.value);
                if (checkOutDate <= checkInDate) {
                    errors.push('Check-out date must be after check-in date');
                }
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
            
            // No errors - clean phone number and submit
            phoneNumber.value = phoneNumber.value.replace(/\D/g, '');
            
            // Add loading state
            submitBtn.classList.add('loading');
            submitBtn.innerHTML = '<i class="fas fa-spinner"></i> Processing...';
        });

        // Auto-set dates on page load
        window.addEventListener('load', function() {
            if (!checkIn.value) {
                const today = new Date().toISOString().split('T')[0];
                checkIn.value = today;
                
                const tomorrow = new Date();
                tomorrow.setDate(tomorrow.getDate() + 1);
                checkOut.value = tomorrow.toISOString().split('T')[0];
            }
            
            // Run initial validations
            validateGuestName();
            validatePhone();
            validateRoomType();
            validateDates();
        });

        // Prevent non-numeric input in phone field
        phoneNumber.addEventListener('keypress', function(e) {
            const charCode = e.which ? e.which : e.keyCode;
            if (charCode < 48 || charCode > 57) {
                e.preventDefault();
            }
        });

        // Hide validation summary when user starts typing
        const inputs = [guestName, phoneNumber, roomType, checkIn, checkOut];
        inputs.forEach(input => {
            input.addEventListener('input', function() {
                validationSummary.classList.remove('show');
            });
        });
    </script>
</body>
</html>