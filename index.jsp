<%-- 
    Document   : index
    Created on : Nov 11, 2024, 9:25:14 AM
    Author     : Talha Bin Shahid
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            }

            body {
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: #f0f2ff;
            }

            .form-container {
                background: white;
                padding: 2rem;
                border-radius: 12px;
                width: 100%;
                max-width: 400px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                position: relative;
            }

            .icon {
                width: 40px;
                height: 40px;
                background-color: #f0f2ff;
                border-radius: 50%;
                display: flex;
                justify-content: center;
                align-items: center;
                margin: 0 auto 1.5rem;
            }

            .icon svg {
                width: 20px;
                height: 20px;
                fill: #6366f1;
            }

            h1 {
                text-align: center;
                font-size: 1.5rem;
                margin-bottom: 1.5rem;
                color: #1f2937;
            }

            .form-group {
                margin-bottom: 1rem;
            }

            label {
                display: block;
                margin-bottom: 0.5rem;
                color: #4b5563;
            }

            input {
                width: 100%;
                padding: 0.75rem;
                border: 1px solid #d1d5db;
                border-radius: 6px;
                font-size: 1rem;
                transition: border-color 0.2s;
            }

            input:focus {
                outline: none;
                border-color: #6366f1;
            }

            button {
                width: 100%;
                padding: 0.75rem;
                background-color: #6366f1;
                color: white;
                border: none;
                border-radius: 6px;
                font-size: 1rem;
                cursor: pointer;
                transition: background-color 0.2s;
            }

            button:hover {
                background-color: #4f46e5;
            }

            .switch-link {
                text-align: center;
                margin-top: 1rem;
            }

            .switch-link a {
                color: #6366f1;
                text-decoration: none;
            }

            .switch-link a:hover {
                text-decoration: underline;
            }

            .hidden {
                display: none;
            }
        </style>
    </head>
    <body>
        <!-- Login Form -->
        <div id="loginForm" class="form-container">
            <!--Invalid username or password message-->
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
            <div id="errorAlert" class="alert alert-danger text-center" role="alert">
                <%= errorMessage%>
            </div>
            <% }%>

            <div class="icon">
                <svg viewBox="0 0 24 24">
                <path d="M12 4l-1.41 1.41L16.17 11H4v2h12.17l-5.58 5.59L12 20l8-8z"/>
                </svg>
            </div>
            <h1>Sign in to your account</h1>
            <form action="LoginServlet" method="post">
                <input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken")%>">
                <div class="form-group">
                    <label for="loginUsername">Username</label>
                    <input type="text" id="loginUsername" name="loginUsername" required />
                </div>
                <div class="form-group">
                    <label for="loginPassword">Password</label>
                    <input type="password" id="loginPassword" name="loginPwd" required />
                </div>
                <button type="submit">Sign in</button>
            </form>
            <div class="switch-link">
                <span>Don't have an account? </span>
                <a href="#" onclick="toggleForms()">Sign up</a>
            </div>
        </div>

        <!-- Signup Form -->
        <div id="signupForm" class="form-container hidden">
            <div class="icon">
                <svg viewBox="0 0 24 24">
                <path d="M12 4l-1.41 1.41L16.17 11H4v2h12.17l-5.58 5.59L12 20l8-8z"/>
                </svg>
            </div>
            <h1>Create your account</h1>
            <form action="SignupServlet" method="post" id="signupFormElement">
                <input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken")%>">
                <div class="form-group">
                    <label for="signupUsername">Username</label>
                    <input type="text" id="signupUsername" name="uname" required />
                </div>
                <div class="form-group">
                    <label for="signupEmail">Email address</label>
                    <input type="email" id="signupEmail" name="email" required />
                </div>
                <div class="form-group">
                    <label for="signupPassword">Password</label>
                    <input type="password" id="signupPassword" name="pwd" required />
                </div>
                <button type="submit">Create account</button>
            </form>
            <div class="switch-link">
                <span>Already have an account? </span>
                <a href="#" onclick="toggleForms()">Sign in</a>
            </div>
        </div>

        <script>
            function toggleForms() {
                const loginForm = document.getElementById('loginForm');
                const signupForm = document.getElementById('signupForm');

                loginForm.classList.toggle('hidden');
                signupForm.classList.toggle('hidden');
            }

            // Client-side password validation
            document.getElementById('signupFormElement').addEventListener('submit', function (e) {
                const password = document.getElementById('signupPassword').value;
                if (password.length < 8) {
                    e.preventDefault();
                    alert('Password must be at least 8 characters long.');
                }
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
