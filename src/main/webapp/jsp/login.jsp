<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Ocean View Resort</title>
</head>
<body>
    <h2>Login</h2>
    <form action="<%=request.getContextPath()%>/LoginServlet" method="post">
    <label>Username:</label>
    <input type="text" name="username" required /><br><br>

    <label>Password:</label>
    <input type="password" name="password" required /><br><br>

    <input type="submit" value="Login" />
</form>
    <p style="color:red;">
        <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
    </p>
</body>
</html>