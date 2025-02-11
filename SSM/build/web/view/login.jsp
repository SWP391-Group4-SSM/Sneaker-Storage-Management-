<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h1>Login</h1>
    <form action="login" method="post">
        <label>Username:</label>
        <input type="text" name="username" required/><br/><br/>
        <label>Password:</label>
        <input type="password" name="password" required/><br/><br/>
        <input type="submit" value="Login"/>
    </form>
    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>
</body>
</html>
