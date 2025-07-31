<%
    Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
    if (isLoggedIn == null || !isLoggedIn) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    String userRole = (String) session.getAttribute("userRole");
    String userID = (String) session.getAttribute("userID");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hostel Manager Portal</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            /* Custom styles */
            :root {
                --primary-color: #007bff;
                --secondary-color: #6c757d;
                --danger-color: #dc3545;
            }

            body {
                background-color: #f8f9fa;
            }

            .navbar {
                padding: 1rem 10rem;
                background: white;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .navbar-brand {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                color: #333;
                font-weight: 600;
            }

            .navbar-brand svg {
                width: 24px;
                height: 24px;
                fill: #6366f1;
            }

            .logout-btn {
                color: #dc2626;
                text-decoration: none;
                display: flex;
                border:none;
                border-radius: 8px;
                background: none;
                align-items: center;
                gap: 0.25rem;
                font-size: 0.95rem;
                transition: background-color 0.3s ease;
            }

            .logout-btn:hover {
                background-color: #fef2f2;
            }

            .logout-icon {
                width: 20px;
                height: 20px;
            }

            .hostel-card {
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
            }

            .hostel-info {
                padding: 1.5rem;
            }

            .info-item {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                margin-bottom: 0.5rem;
                color: var(--secondary-color);
            }

            .booking-table {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                padding: 1.5rem;
            }

            .delete-btn {
                color: var(--danger-color);
                cursor: pointer;
            }

            @media (max-width: 768px) {
                .hostel-image {
                    height: 200px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Navigation bar -->
        <nav class="navbar navbar-light bg-white">
            <div class="container">
                <a class="navbar-brand fw-bold" href="#">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-buildings" viewBox="0 0 16 16">
                    <path d="M14.763.075A.5.5 0 0 1 15 .5v15a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5V14h-1v1.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V10a.5.5 0 0 1 .342-.474L6 7.64V4.5a.5.5 0 0 1 .276-.447l8-4a.5.5 0 0 1 .487.022M6 8.694 1 10.36V15h5zM7 15h2v-1.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 .5.5V15h2V1.309l-7 3.5z"/>
                    <path d="M2 11h1v1H2zm2 0h1v1H4zm-2 2h1v1H2zm2 0h1v1H4zm4-4h1v1H8zm2 0h1v1H8zm-2 2h1v1H8zm2 0h1v1H8zm2-2h1v1H8zm0 2h1v1H8zM8 7h1v1H8zm2 0h1v1h-1zm2 0h1v1h-1zM8 5h1v1H8zm2 0h1v1h-1zm2 0h1v1h-1zm0-2h1v1h-1z"/>
                    </svg>
                    Hostel Manager Portal
                </a>
                <button class="logout-btn ms-auto d-flex align-items-center fs-6" onclick="logout()">
                    <svg class="logout-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4M16 17l5-5-5-5M21 12H9"/>
                    </svg>
                    Logout
                </button>
            </div>
        </nav>

        <!-- Main content -->
        <div class="container my-4">
            <!-- Hostel information card -->
            <div id="hostels-list" class="row mb-3 ">
                <!-- Hostels will be dynamically inserted here by JavaScript -->
            </div>

            <!-- Booking requests section -->
            <div class="booking-table">
                <h3 class="mb-4">Booking Requests</h3>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>NAME</th>
                                <th>CONTACT</th>
                                <th>MESSAGE</th>
                                <th>ACTION</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <!--Requests will display here-->
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script>
                    // Fetch hostel data dynamically using AJAX
                    function logout() {
                        window.location.href = "LogoutServlet"; // Redirects to LogoutServlet
                    }

                    document.addEventListener("DOMContentLoaded", function () {
                        fetchHostels();
                        fetchRequests();
                    });

                    // Function to fetch hostels
                    function fetchHostels() {
                        console.log("Fetching hostels...");
                        var xhr = new XMLHttpRequest();
                        xhr.open('GET', 'ManagerHostelDispServ', true);
                        xhr.onload = function () {
                            if (xhr.status === 200) {
                                var data = JSON.parse(xhr.responseText);
                                console.log("Hostels fetched successfully");
                                displayHostelsAsCards(data);
                            } else {
                                console.error('Error fetching hostels:', xhr.statusText);
                            }
                        };
                        xhr.send();
                    }

                    // Function to fetch requests
                    function fetchRequests() {
                        console.log("Fetching requests...");
                        var xhr = new XMLHttpRequest();
                        xhr.open('GET', 'ManagerRequestDispServ', true);
                        xhr.onload = function () {
                            if (xhr.status === 200) {
                                var data = JSON.parse(xhr.responseText);
                                console.log("Requests fetched successfully");
                                displayRequestsAsTable(data);
                            } else {
                                console.error('Error fetching requests:', xhr.statusText);
                            }
                        };
                        xhr.send();
                    }

                    // Function to display requests in a table
                    function displayRequestsAsTable(requests) {
                        const container = document.querySelector(".booking-table tbody");
                        container.innerHTML = ''; // Clear the previous content
                        requests.forEach(function (request) {
                            const rowHTML =
                                    '<tr>' +
                                    '<td>' + request.name + '</td>' +
                                    '<td>' + request.contact + '</td>' +
                                    '<td>' + request.description + '</td>' +
                                    '<td>' +
                                    '<i class="fas fa-trash delete-btn" onclick="deleteRequest(\'' + request.id + '\')"></i>' +
                                    '</td>' +
                                    '</tr>';
                            container.innerHTML += rowHTML;
                        });
                    }

                    // Function to display hostels as cards
                    function displayHostelsAsCards(hostels) {
                        const container = document.getElementById("hostels-list");
                        container.innerHTML = ''; // Clear the previous content
                        hostels.forEach(function (hostel) {
                            const cardHTML =
                                    '<div class="col-md-4">' +
                                    '<div class="hostel-card shadow h-100 bg-white">' +
                                    '<div class="card-body p-4">' +
                                    '<h2 class="card-title fw-bold mb-4 text-center">' + hostel.name + '</h2>' +
                                    '<div class="d-flex align-items-center gap-2 text-muted mb-3">' +
                                    '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">' +
                                    '<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>' +
                                    '<circle cx="12" cy="10" r="3"></circle>' +
                                    '</svg>' +
                                    '<span class="small">' + hostel.address + '</span>' +
                                    '</div>' +
                                    '<div class="d-flex align-items-center gap-2 text-muted mb-3">' +
                                    '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">' +
                                    '<path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>' +
                                    '</svg>' +
                                    '<span class="small">' + hostel.contact + '</span>' +
                                    '</div>' +
                                    (hostel.url ?
                                            '<a href="' + hostel.url + '" target="_blank" rel="noopener noreferrer" class="d-flex align-items-center gap-2 text-primary text-decoration-none mb-4">' +
                                            '<svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">' +
                                            '<path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path>' +
                                            '<polyline points="15 3 21 3 21 9"></polyline>' +
                                            '<line x1="10" y1="14" x2="21" y2="3"></line>' +
                                            '</svg>' +
                                            '<span class="small fw-medium">Open in Google Maps</span>' +
                                            '</a>' : '') +
                                    '<div class="d-flex align-items-center justify-content-between mt-2">' +
                                    '<div>' +
                                    '<span class="fs-4 fw-bold text-primary">' + hostel.rent + 'Rs</span>' +
                                    '<span class="text-muted small">/mo</span>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>';

                            container.innerHTML += cardHTML;
                        });
                    }

                    function deleteRequest(requestId) {
                        if (confirm('Are you sure you want to delete this request?')) {
                            fetch('DeleteBookingReq', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded'
                                },
                                body: 'requestId=' + requestId
                            })
                                    .then(response => response.json())
                                    .then(data => {
                                        if (data.success) {
                                            // Refresh the requests list
                                            fetchRequests();
                                        } else {
                                            alert(data.message);
                                        }
                                    })
                                    .catch(error => {
                                        console.error('Error:', error);
                                        alert('Error deleting request');
                                    });
                        }
                    }
        </script>
    </body>
</html>