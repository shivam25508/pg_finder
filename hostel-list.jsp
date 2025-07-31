<%-- 
    Document   : hostel-list
    Created on : Dec 17, 2024, 3:46:40 AM
    Author     : talha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>
        <header>
            <nav class="navbar navbar-expand-md navbar-dark" style="background-color: tomato">
                <div>
                    <a href="<%=request.getContextPath()%>" class="navbar-brand"> Admin </a>
                </div>

                <ul class="navbar-nav">
                    <li><a href="<%=request.getContextPath()%>/list" class="nav-link">Hostels</a></li>
                </ul>
            </nav>
        </header>
        <br>

        <div class="row">
            <div class="container">
                <h3 class="text-center">List of Hostels</h3>
                <hr>
                <div class="container text-left">
                    <a href="<%=request.getContextPath()%>/new" class="btn btn-success">Add New Hostel</a>
                </div>
                <br>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Address</th>
                            <th>Rent</th>
                            <th>Contact</th>
                            <th>Location URL</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="hostel" items="${listHostel}">
                        <tr>
                            <td><c:out value="${hostel.hostel_id}" /></td>
                        <td><c:out value="${hostel.hostel_name}" /></td>
                        <td><c:out value="${hostel.hostel_address}" /></td>
                        <td><c:out value="${hostel.hostel_rent}" /></td>
                        <td><c:out value="${hostel.hostel_contact}" /></td>
                        <td><c:out value="${hostel.hostel_location_url}" /></td>
                        <td>
                            <a href="edit?id=<c:out value='${hostel.hostel_id}' />" class="btn btn-primary">Edit</a>
                            &nbsp;&nbsp;&nbsp;
                            <a href="delete?id=<c:out value='${hostel.hostel_id}' />" class="btn btn-danger">Delete</a>
                        </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </body>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>
