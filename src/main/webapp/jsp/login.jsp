<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Ocean View Resort</title>
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(to right, #00c6ff, #0072ff);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-card {
            background-color: #fff;
            padding: 40px 30px;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            width: 350px;
            text-align: center;
        }

        .login-card h2 {
            margin-bottom: 30px;
            color: #0072ff;
        }

        .login-card label {
            display: block;
            text-align: left;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        .login-card input[type="text"],
        .login-card input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none;
            transition: 0.3s;
        }

        .login-card input[type="text"]:focus,
        .login-card input[type="password"]:focus {
            border-color: #0072ff;
            box-shadow: 0 0 5px rgba(0,114,255,0.5);
        }

        .login-card input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #0072ff;
            border: none;
            border-radius: 5px;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .login-card input[type="submit"]:hover {
            background-color: #005bb5;
        }

        .login-card p.error {
            color: red;
            margin-top: 15px;
            font-weight: bold;
        }

        /* Responsive */
        @media (max-width: 400px) {
            .login-card {
                width: 90%;
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="login-card">
        <h2>Ocean View Resort</h2>
        <form action="<%=request.getContextPath()%>/LoginServlet" method="post">
            <label>Username</label>
            <input type="text" name="username" required />

            <label>Password</label>
            <input type="password" name="password" required />

            <input type="submit" value="Login" />
        </form>
        <p class="error">
            <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
        </p>
    </div>
</body>
</html>