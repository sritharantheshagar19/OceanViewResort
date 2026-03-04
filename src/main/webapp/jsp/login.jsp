<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Ocean View Resort</title>
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
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            position: relative;
            overflow: hidden;
        }

        /* Animated Waves Background */
        .wave {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 100px;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="%23ffffff" fill-opacity="0.3" d="M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,122.7C672,117,768,139,864,154.7C960,171,1056,181,1152,170.7C1248,160,1344,128,1392,112L1440,96L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
            background-size: cover;
            background-repeat: no-repeat;
            animation: wave 10s linear infinite;
        }

        .wave:nth-child(2) {
            bottom: 0;
            opacity: 0.5;
            animation: wave 15s linear infinite;
        }

        .wave:nth-child(3) {
            bottom: 0;
            opacity: 0.2;
            animation: wave 20s linear infinite;
        }

        @keyframes wave {
            0% { transform: translateX(0); }
            50% { transform: translateX(-25%); }
            100% { transform: translateX(0); }
        }

        .container {
            position: relative;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            z-index: 1;
        }

        .login-wrapper {
            display: flex;
            max-width: 1000px;
            width: 100%;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
            animation: slideUp 0.5s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Left Side - Resort Info */
        .info-section {
            flex: 1;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 50px 40px;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .resort-name {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            line-height: 1.2;
        }

        .resort-tagline {
            font-size: 1.1rem;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        .features {
            list-style: none;
            margin-top: 30px;
        }

        .features li {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            font-size: 1rem;
        }

        .features li i {
            width: 30px;
            font-size: 1.2rem;
            margin-right: 10px;
        }

        /* Right Side - Login Form */
        .login-section {
            flex: 1;
            padding: 50px 40px;
            background: white;
        }

        .login-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .login-header h2 {
            color: #333;
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .login-header p {
            color: #666;
            font-size: 0.95rem;
        }

        .input-group {
            margin-bottom: 25px;
            position: relative;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
            font-size: 0.95rem;
        }

        .input-group i {
            position: absolute;
            left: 15px;
            top: 45px;
            color: #999;
            font-size: 1.1rem;
        }

        .input-group input {
            width: 100%;
            padding: 15px 15px 15px 45px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            outline: none;
        }

        .input-group input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .input-group input::placeholder {
            color: #aaa;
            font-size: 0.95rem;
        }

        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .remember {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #666;
            font-size: 0.95rem;
        }

        .remember input[type="checkbox"] {
            width: 16px;
            height: 16px;
            cursor: pointer;
        }

        .forgot-link {
            color: #667eea;
            text-decoration: none;
            font-size: 0.95rem;
            font-weight: 500;
            transition: color 0.3s;
        }

        .forgot-link:hover {
            color: #764ba2;
        }

        .login-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .error-message {
            background: #fee;
            color: #c33;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 10px;
            border-left: 4px solid #c33;
            animation: shake 0.5s ease;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .error-message i {
            font-size: 1.2rem;
        }

        .demo-credentials {
            margin-top: 30px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            font-size: 0.9rem;
        }

        .demo-credentials p {
            color: #666;
            margin-bottom: 5px;
        }

        .demo-credentials span {
            color: #333;
            font-weight: 600;
        }

        @media (max-width: 768px) {
            .login-wrapper {
                flex-direction: column;
            }
            
            .info-section {
                padding: 40px 30px;
            }
            
            .login-section {
                padding: 40px 30px;
            }
        }
    </style>
</head>
<body>
    <!-- Animated Waves -->
    <div class="wave"></div>
    <div class="wave"></div>
    <div class="wave"></div>

    <div class="container">
        <div class="login-wrapper">
            <!-- Left Side - Resort Information -->
            <div class="info-section">
                <div class="resort-name">
                    Ocean View<br>Resort
                </div>
                <p class="resort-tagline">
                    Experience luxury by the beach in Galle
                </p>
                <ul class="features">
                    <li>
                        <i class="fas fa-umbrella-beach"></i>
                        Private Beach Access
                    </li>
                    <li>
                        <i class="fas fa-swimming-pool"></i>
                        Infinity Pool
                    </li>
                    <li>
                        <i class="fas fa-spa"></i>
                        Luxury Spa
                    </li>
                    <li>
                        <i class="fas fa-wifi"></i>
                        Free High-Speed WiFi
                    </li>
                </ul>
            </div>

            <!-- Right Side - Login Form -->
            <div class="login-section">
                <div class="login-header">
                    <h2>Welcome Back</h2>
                    <p>Please login to access the reservation system</p>
                </div>

                <!-- Error Message Display -->
                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>

                <form action="<%=request.getContextPath()%>/LoginServlet" method="post">
                    <div class="input-group">
                        <label for="username">Username</label>
                        <i class="fas fa-user"></i>
                        <input type="text" id="username" name="username" 
                               placeholder="Enter your username" required>
                    </div>

                    <div class="input-group">
                        <label for="password">Password</label>
                        <i class="fas fa-lock"></i>
                        <input type="password" id="password" name="password" 
                               placeholder="Enter your password" required>
                    </div>

                    <div class="remember-forgot">
                        <label class="remember">
                            <input type="checkbox" name="remember"> Remember me
                        </label>
                        <a href="#" class="forgot-link">Forgot Password?</a>
                    </div>

                    <button type="submit" class="login-btn">
                        <i class="fas fa-sign-in-alt" style="margin-right: 10px;"></i>
                        Login to Dashboard
                    </button>
                </form>

                
            </div>
        </div>
    </div>

    <script>
        // Add floating label effect
        document.querySelectorAll('.input-group input').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('focused');
            });
            
            input.addEventListener('blur', function() {
                if (this.value === '') {
                    this.parentElement.classList.remove('focused');
                }
            });
        });
    </script>
</body>
</html>