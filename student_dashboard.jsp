<%
    Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
    if (isLoggedIn == null || !isLoggedIn) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }

    String userID = (String) session.getAttribute("userID");
    String username = (String) session.getAttribute("username");
    String userRole = (String) session.getAttribute("userRole");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student Portal - Available Hostels</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            :root {
                --primary-color: #4F46E5;
                --text-primary: #111827;
                --text-secondary: #6B7280;
                --bg-light: #F9FAFB;
            }

            body {
                background-color: var(--bg-light);
                color: var(--text-primary);
                font-family: system-ui, -apple-system, sans-serif;
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

            .main-content {
                padding: 2rem;
                max-width: 1400px;
                margin: 0 auto;
            }

            .page-title {
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .page-subtitle {
                color: var(--text-secondary);
                margin-bottom: 2rem;
            }

            .card {
                padding: 3px;
                background: white;
                border-radius: 0.75rem;
                overflow: hidden;
                transition: transform 0.2s;
                height: 100%;
            }

            .card:hover {
                transform: translateY(-4px);
            }

            .card-body {
                padding: 1.5rem;
            }
            
            

            .hostel-name {
                font-size: 1.25rem;
                font-weight: 600;
                margin-bottom: 0.5rem;
                width: 100%;
                align-content: center;
            }

            .location {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                color: var(--text-secondary);
                margin-bottom: 1rem;
            }

            .price {
                font-size: 1.25rem;
                font-weight: 600;
                color: var(--primary-color);
                margin-bottom: 1rem;
            }

            .book-btn {
                background: var(--primary-color);
                color: white;
                border: none;
                border-radius: 0.5rem;
                padding: 0.75rem 1rem;
                width: 100%;
                font-weight: 500;
                transition: background-color 0.2s;
            }

            .book-btn:hover {
                background-color: #4338CA;
            }

            .contact-btn {
                background: none;
                border: none;
                color: var(--text-secondary);
                padding: 0.5rem;
                border-radius: 50%;
                margin-left: auto;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg sticky-top">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold" href="#" >
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-buildings" viewBox="0 0 16 16">
                    <path d="M14.763.075A.5.5 0 0 1 15 .5v15a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5V14h-1v1.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V10a.5.5 0 0 1 .342-.474L6 7.64V4.5a.5.5 0 0 1 .276-.447l8-4a.5.5 0 0 1 .487.022M6 8.694 1 10.36V15h5zM7 15h2v-1.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 .5.5V15h2V1.309l-7 3.5z"/>
                    <path d="M2 11h1v1H2zm2 0h1v1H4zm-2 2h1v1H2zm2 0h1v1H4zm4-4h1v1H8zm2 0h1v1H8zm-2 2h1v1H8zm2 0h1v1H8zm2-2h1v1H8zm0 2h1v1H8zM8 7h1v1H8zm2 0h1v1h-1zm2 0h1v1h-1zM8 5h1v1H8zm2 0h1v1h-1zm2 0h1v1h-1zm0-2h1v1h-1z"/>
                    </svg>
                    Student Portal
                </a>

                <button type="submit" class="logout-btn ms-auto d-flex align-items-center fs-6"  onclick="logout()">
                    <svg class="logout-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4M16 17l5-5-5-5M21 12H9"/>
                    </svg>
                    Logout
                </button>
            </div>
        </nav>

        <main class="main-content">
            <h1 class="page-title">Available Hostels</h1>
            <p class="page-subtitle">Find and book your perfect accommodation</p>

            <div class="container-fluid p-4">
                <div class="row" id="hostelsContainer">
                    <!-- Hostel cards will be dynamically inserted here -->
                </div>
            </div>
        </main>

        <div class="modal fade" id="bookingModal" tabindex="-1" aria-labelledby="bookingModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="bookingModalLabel">Book <span id="hostelName"></span>:</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="bookingForm" action="BookingServlet" method="post">
                            <div class="mb-3">
                                <label for="name" class="form-label">Name</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="contact" class="form-label">Contact</label>
                                <input type="text" class="form-control" id="contact" name="contact" required>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                            </div>
                            <input type="hidden" id="hostelId" name="hostelId">
                            <button type="submit" class="book-btn">Submit Booking</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        fetchHostels();

                        // Add event listener for modal hidden event
                        const bookingModal = document.getElementById('bookingModal');
                        bookingModal.addEventListener('hidden.bs.modal', function () {
                            // Reset the form when modal is closed
                            document.getElementById('bookingForm').reset();
                            // Clear the hostel name span
                            document.getElementById('hostelName').textContent = '';
                            // Clear the hidden hostel ID
                            document.getElementById('hostelId').value = '';
                        });
                    });

                    function logout() {
                        window.location.href = "LogoutServlet"; // Redirects to LogoutServlet
                    }

                    function fetchHostels() {
                        console.log("Fetching hostels...");
                        var xhr = new XMLHttpRequest();
                        xhr.open('GET', 'HostelDisplayServlet', true);
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

                    function displayHostelsAsCards(hostels) {
                        const container = document.getElementById("hostelsContainer");
                        container.innerHTML = '';

                        hostels.forEach(hostel => {
                            const cardHTML =
                                    '<div class="col-md-4 mb-4">' +
                                    '<div class="card shadow h-100">' +
                                    '<div class="card-body p-4">' +
                                    '<h2 class="card-title fw-bold mb-4 text-center">' + hostel.name + '</h2>' +
                                    // Location
                                    '<div class="d-flex align-items-center gap-2 text-muted mb-3">' +
                                    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">' +
                                    '<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>' +
                                    '<circle cx="12" cy="10" r="3"></circle>' +
                                    '</svg>' +
                                    '<span class="small">' + hostel.address + '</span>' +
                                    '</div>' +
                                    // Phone
                                    '<div class="d-flex align-items-center gap-2 text-muted mb-3">' +
                                    '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">' +
                                    '<path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>' +
                                    '</svg>' +
                                    '<span class="small">' + hostel.contact + '</span>' +
                                    '</div>' +
                                    (hostel.url ?
                                            '<a href="' + hostel.url + '"' +
                                            ' target="_blank"' +
                                            ' rel="noopener noreferrer"' +
                                            ' class="d-flex align-items-center gap-2 text-primary text-decoration-none mb-4">' +
                                            '<svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">' +
                                            '<path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path>' +
                                            '<polyline points="15 3 21 3 21 9"></polyline>' +
                                            '<line x1="10" y1="14" x2="21" y2="3"></line>' +
                                            '</svg>' +
                                            '<span class="small fw-medium">Open in Google Maps</span>' +
                                            '</a>' : '') +
                                    // Price and CTA
                                    '<div class="d-flex align-items-center justify-content-between mt-2">' +
                                    '<div>' +
                                    '<span class="fs-4 fw-bold text-primary">' + hostel.rent + 'Rs</span>' +
                                    '<span class="text-muted small">/mo</span>' +
                                    '</div>' +
                                    '<button class="btn btn-primary px-4"' +
                                    ' onclick="prepareBookingForm(\'' + hostel.id + '\', \'' + hostel.name + '\')"' +
                                    ' data-bs-toggle="modal"' +
                                    ' data-bs-target="#bookingModal">' +
                                    'Book Now' +
                                    '</button>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>';

                            container.innerHTML += cardHTML;
                        });
                    }
                    var username = "<%= username != null ? username : ""%>";
                    const userID = "<%= userID != null ? userID : ""%>";

                    function prepareBookingForm(hostelId, hostelName) {
                        document.getElementById("hostelId").value = hostelId;
                        document.getElementById("hostelName").textContent = hostelName;
                        console.log(hostelId);
                    }
    </script>
</html>
