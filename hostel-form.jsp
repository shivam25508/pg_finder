<%-- 
    Document   : hostel-form
    Created on : Dec 17, 2024, 3:51:22 AM
    Author     : talha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    </head>
    <body>
        <header>
            <nav class="navbar navbar-expand-md navbar-dark" style="background-color: tomato">
                <div>
                    <a href="<%=request.getContextPath()%>" class="navbar-brand"> Hostel Management App </a>
                </div>

                <ul class="navbar-nav">
                    <li><a href="<%=request.getContextPath()%>/list" class="nav-link">Hostels</a></li>
                </ul>
            </nav>
        </header>
        <br>

        <div class="container col-md-5">
            <div class="card">
                <div class="card-body">

                    <c:if test="${hostel != null}">
                        <form action="update" method="post">
                    </c:if>

                    <c:if test="${hostel == null}">
                        <form action="insert" method="post">
                    </c:if>

                    <caption>
                        <h2>
                            <c:if test="${hostel != null}">
                                Edit Hostel
                            </c:if>
                            <c:if test="${hostel == null}">
                                Add New Hostel
                            </c:if>
                        </h2>
                    </caption>

                    <c:if test="${hostel != null}">
                        <input type="hidden" name="hostel_id" value="<c:out value='${hostel.hostel_id}' />" />
                    </c:if>

                    <fieldset class="form-group">
                        <label>Hostel Name</label>
                        <input type="text" value="<c:out value='${hostel.hostel_name}' />" class="form-control" name="hostel_name" required="required">
                    </fieldset>

                    <fieldset class="form-group">
                        <label>Hostel Address</label>
                        <input type="text" value="<c:out value='${hostel.hostel_address}' />" class="form-control" name="hostel_address">
                    </fieldset>

                    <fieldset class="form-group">
                        <label>Hostel Rent</label>
                        <input type="number" value="<c:out value='${hostel.hostel_rent}' />" class="form-control" name="hostel_rent">
                    </fieldset>

                    <fieldset class="form-group">
                        <label>Hostel Contact</label>
                        <input type="text" value="<c:out value='${hostel.hostel_contact}' />" class="form-control" name="hostel_contact">
                    </fieldset>

                    <fieldset class="form-group">
                        <label>Hostel Location URL</label>
                        <input type="text" value="<c:out value='${hostel.hostel_location_url}' />" class="form-control" name="hostel_location_url">
                    </fieldset>

                    <button type="submit" class="btn btn-success">Save</button>
                    </form>

                </div>
            </div>
        </div>
    </body>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>
