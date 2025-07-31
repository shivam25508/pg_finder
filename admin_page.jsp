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
<%-- 
    Document   : admin_page
    Created on : Dec 17, 2024, 9:50:24 PM
    Author     : Talha Bin Shahid
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hostel Finder</title>
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">


        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #f4f6f9;
            }

            /* Header */
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

            /* Container */
            .container {
                padding: 20px 40px;
            }

            .section-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .section-header h2 {
                margin: 0;
            }

            .add-btn {
                background-color: #5a54f4;
                color: white;
                border: none;
                border-radius: 5px;
                padding: 10px 20px;
                cursor: pointer;
                font-size: 14px;
            }

            .add-btn:hover {
                background-color: #3e39d1;
            }

            /* Hostel Cards */
            .hostel-card {
                background-color: white;
                border-radius: 10px;
                padding: 15px 20px;
                margin-bottom: 15px;
                box-shadow: 0px 1px 4px rgba(0, 0, 0, 0.2);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .hostel-card:hover{
                box-shadow: 5px 5px lightgray;
                transform: translateY(-4px);
                transition: .5s;
            }

            .hostel-info {
                display: flex;
                flex-direction: column;
            }

            .hostel-info h3 {
                margin: 0;
                font-size: 20px;
            }

            .hostel-info p {
                margin: 5px 0;
                color: #666;
                font-size: 14px;
            }

            .hostel-actions {
                display: flex;
                gap: 10px;
            }

            .hostel-actions button {
                background: none;
                border: none;
                cursor: pointer;
                font-size: 18px;
                color: #5a54f4;
            }

            /*        .hostel-actions button:hover {
                        color: red;
                    }*/

            /* Modal */
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.6);
                align-items: center;
                justify-content: center;
            }

            .modal-content {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                width: 350px;
            }

            .modal-content input {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .modal-content button {
                background-color: #5a54f4;
                color: white;
                border: none;
                padding: 8px 12px;
                cursor: pointer;
                border-radius: 5px;
                font-size: 14px;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <nav class="navbar navbar-expand-lg shadow-sm sticky-top">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold" href="#" >
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-buildings" viewBox="0 0 16 16">
                    <path d="M14.763.075A.5.5 0 0 1 15 .5v15a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5V14h-1v1.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V10a.5.5 0 0 1 .342-.474L6 7.64V4.5a.5.5 0 0 1 .276-.447l8-4a.5.5 0 0 1 .487.022M6 8.694 1 10.36V15h5zM7 15h2v-1.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 .5.5V15h2V1.309l-7 3.5z"/>
                    <path d="M2 11h1v1H2zm2 0h1v1H4zm-2 2h1v1H2zm2 0h1v1H4zm4-4h1v1H8zm2 0h1v1H8zm-2 2h1v1H8zm2 0h1v1H8zm2-2h1v1H8zm0 2h1v1H8zM8 7h1v1H8zm2 0h1v1h-1zm2 0h1v1h-1zM8 5h1v1H8zm2 0h1v1h-1zm2 0h1v1h-1zm0-2h1v1h-1z"/>
                    </svg>
                    Admin
                </a>

                <button type="submit" class="logout-btn ms-auto d-flex align-items-center fs-6"  onclick="logout()">
                    <svg class="logout-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4M16 17l5-5-5-5M21 12H9"/>
                    </svg>
                    Logout
                </button>
            </div>
        </nav>

        <!-- Main Container -->
        <div class="container">
            <!-- Section Header -->
            <div class="section-header">
                <h2>Hostels</h2>
                <button class="add-btn" id="addHostelBtn">
                    <i class="fas fa-plus"></i> Add New Hostel
                </button>
            </div>

            <!-- Hostel Cards -->
            <ul id="hostelList">

            </ul>
        </div>

        <!-- Add Hostel Modal -->
        <div class="modal" id="modal">
            <div class="modal-content">
                <h3>Add New Hostel</h3>
                <form id="addHostelForm" action="AddNewHostelServ" method="post">
                    <input type="text" name="username" id="username" placeholder="Manager Username" required />
                    <input type="text" name="password" id="password" placeholder="Manager Password" required />
                    <input type="text" name="email" id="email" placeholder="Manager Email" required />
                    <input type="text" name="hostelName" id="hostelName" placeholder="Hostel Name" required />
                    <input type="text" id="address" name="address" placeholder="Address" required />
                    <input type="text" name="contact" id="contact" placeholder="Contact" required />
                    <input type="number" id="price" name="price" placeholder="Price (e.g., Rs. 15000)" required />
                    <input type="text" id="googleMapsUrl" name="googleMapsUrl" placeholder="Google Maps URL" required />
                    <button type="submit">Add</button>
                    <button type="button" id="closeModal">Cancel</button>
                </form>
            </div>
        </div>

        <!-- Edit Hostel Modal -->
        <div class="modal" id="editModal">
            <div class="modal-content">
                <h3>Edit Hostel Details</h3>
                <form id="editHostelForm" action="EditHostelServlet" method="post">
                    <input type="hidden" name="hostelId" id="editHostelId" />
                    <input type="text" name="hostelName" id="editHostelName" placeholder="Hostel Name" required />
                    <input type="text" id="editAddress" name="address" placeholder="Address" required />
                    <input type="text" name="contact" id="editContact" placeholder="Contact" required />
                    <input type="number" id="editPrice" name="price" placeholder="Price (e.g., Rs. 15000)" required />
                    <input type="text" id="editGoogleMapsUrl" name="googleMapsUrl" placeholder="Google Maps URL" required />
                    <button type="submit">Update</button>
                    <button type="button" id="closeEditModal">Cancel</button>
                </form>
            </div>
        </div>



        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>


        <script>
                    const modal = document.getElementById("modal");
                    const addHostelBtn = document.getElementById("addHostelBtn");
                    const closeModal = document.getElementById("closeModal");

                    addHostelBtn.addEventListener("click", () => {
                        modal.style.display = "flex";
                    });

                    closeModal.addEventListener("click", () => {
                        modal.style.display = "none";
                    });

                    document.getElementById("addHostelForm").addEventListener("submit", function (e) {
                        e.preventDefault();

                        document.getElementById("modal").style.display = "none";

                        handleFormSubmit();
                    });

                    console.log("Hello");
                    fetchHostels();

                    function fetchHostels() {

                        var xhr = new XMLHttpRequest();

                        xhr.open('GET', 'HostelDisplayServlet', true);

                        xhr.onload = function () {
                            if (xhr.status === 200) {
                                var data = JSON.parse(xhr.responseText);

                                console.log("Data fetched successfully");
                                data.forEach(hostel => {
                                    addNewHostel(hostel.name, hostel.address, hostel.url, hostel.contact, hostel.rent, hostel.id);
                                });
                            } else {
                                console.error('Failed to fetch hostels:', xhr.statusText);
                            }
                        };
                        xhr.onerror = function () {
                            console.error('Error fetching hostels:', xhr.statusText);
                        };
                        xhr.send();
                    }

                    function logout() {
                        window.location.href = "LogoutServlet"; // Redirects to LogoutServlet
                    }

                    function handleFormSubmit() {
                        let hostelName = document.getElementById('hostelName').value;
                        let address = document.getElementById('address').value;
                        let contact = document.getElementById('contact').value;
                        let price = document.getElementById('price').value;
                        let googleMapsUrl = document.getElementById('googleMapsUrl').value;
                        let uname = document.getElementById('username').value;
                        let pwd = document.getElementById('password').value;
                        let email = document.getElementById('email').value;


                        let xhr = new XMLHttpRequest();
                        xhr.open("POST", "AddNewHostelServ", true);
                        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                        let data = 'hostelName=' + encodeURIComponent(hostelName) + '&address=' + encodeURIComponent(address) + '&contact=' + encodeURIComponent(contact) + '&price=' + encodeURIComponent(price) + '&googleMapsUrl=' + encodeURIComponent(googleMapsUrl);
                        let data2 = '&username=' + encodeURIComponent(uname) + '&password=' + encodeURIComponent(pwd) + '&email=' + encodeURIComponent(email);

                        data = data + data2;

                        xhr.onload = function () {
                            if (xhr.status === 200) {
                                let response = JSON.parse(xhr.responseText);
                                if (response.success) {
                                    addNewHostel(hostelName, address, googleMapsUrl, contact, price, response.hostelId);
                                    alert("Hostel added successfully!");
                                } else {
                                    alert(response.errorMessage);
                                }
                            } else {
                                alert("An error occurred while adding the hostel.");
                            }
                        };

                        xhr.send(data);
                    }

                    function addNewHostel(name, address, url, contact, rent, hostelId) {
                        let list = document.getElementById("hostelList");
                        let newItem = document.createElement("li");
                        newItem.classList.add("hostel-card");
                        newItem.id = "hostel-" + hostelId;

                        let text =
                                '<div class="hostel-info">' +
                                '<h3>' + name + '</h3>' +
                                '<p>' + address + '</p>' +
                                '<p>Rent: Rs. ' + rent + '/month</p>' +
                                '<p>Contact: ' + contact + '</p>' +
                                '</div>' +
                                '<div class="hostel-actions">' +
                                '<a href="' + url + '" target="_blank" style="font-size: 25px;"><i class="bx bx-map"></i></a>' +
                                '<button class="edit-btn" style="font-size:25px;" onclick="openEditModal(' + hostelId + ', \'' + name + '\', \'' + address + '\', \'' + contact + '\', \'' + rent + '\', \'' + url + '\')"><i class="bx bx-edit-alt" ></i></button>' +
                                '<button class="delete-btn" onclick="deleteHostel(' + hostelId + ')" style="color: red; font-size:25px;"><i class="bx bx-trash"></i></button>' +
                                '</div>';

                        newItem.innerHTML = text;
                        list.appendChild(newItem);
                    }

                    function deleteHostel(hostelId) {
                        let xhr = new XMLHttpRequest();
                        xhr.open("POST", "DeleteHostelServlet", true);
                        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                        let data = "hostelId=" + encodeURIComponent(hostelId);

                        xhr.onload = function () {
                            if (xhr.status === 200) {
                                let response = JSON.parse(xhr.responseText);

                                if (response.success) {
                                    // Remove the hostel from the UI if the deletion was successful
                                    let hostelElement = document.getElementById("hostel-" + hostelId);
                                    if (hostelElement) {
                                        hostelElement.remove();
                                    }
                                    alert("Hostel deleted successfully!");
                                } else {
                                    alert("Error: " + response.message);
                                }
                            } else {
                                alert("An error occurred while deleting the hostel.");
                            }
                        };

                        xhr.send(data);
                    }

                    function openEditModal(hostelId, name, address, contact, price, url) {
                        document.getElementById("editHostelId").value = hostelId;
                        document.getElementById("editHostelName").value = name;
                        document.getElementById("editAddress").value = address;
                        document.getElementById("editContact").value = contact;
                        document.getElementById("editPrice").value = price;
                        document.getElementById("editGoogleMapsUrl").value = url;
                        document.getElementById("editModal").style.display = "flex";
                    }

                    document.getElementById("closeEditModal").addEventListener("click", () => {
                        document.getElementById("editModal").style.display = "none";
                    });

                    document.addEventListener("click", function (e) {
                        if (e.target && e.target.classList.contains("edit-btn")) {
                            const li = e.target.closest("li");
                            const hostelId = li.id.split("-")[1];
                            const name = li.querySelector("h3").innerText;
                            const address = li.querySelector("p:nth-child(2)").innerText;
                            const price = li.querySelector("p:nth-child(3)").innerText.replace(/Rent: Rs. |\/month/g, "");
                            const contact = li.querySelector("p:nth-child(4)").innerText.replace("Contact: ", "");
                            const url = li.querySelector("a").href;

                            openEditModal(hostelId, name, address, contact, price, url);
                        }
                    });

                    document.getElementById("editHostelForm").addEventListener("submit", function (e) {
                        e.preventDefault(); // Prevent form from submitting and refreshing the page

                        let hostelId = document.getElementById("editHostelId").value;
                        let hostelName = document.getElementById('editHostelName').value;
                        let address = document.getElementById('editAddress').value;
                        let contact = document.getElementById('editContact').value;
                        let price = document.getElementById('editPrice').value;
                        let googleMapsUrl = document.getElementById('editGoogleMapsUrl').value;

                        let xhr = new XMLHttpRequest();
                        xhr.open("POST", "EditHostelServlet", true);
                        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                        let data = 'hostelId=' + encodeURIComponent(hostelId) +
                                '&hostelName=' + encodeURIComponent(hostelName) +
                                '&address=' + encodeURIComponent(address) +
                                '&contact=' + encodeURIComponent(contact) +
                                '&price=' + encodeURIComponent(price) +
                                '&googleMapsUrl=' + encodeURIComponent(googleMapsUrl);

                        xhr.onload = function () {
                            if (xhr.status === 200) {
                                let response = JSON.parse(xhr.responseText);
                                if (response.success) {
                                    let hostelElement = document.getElementById("hostel-" + hostelId);
                                    if (hostelElement) {
                                        hostelElement.querySelector("h3").innerText = hostelName;
                                        hostelElement.querySelector("p:nth-child(2)").innerText = address;
                                        hostelElement.querySelector("p:nth-child(3)").innerText = 'Rent: Rs. ' + price + '/month';
                                        hostelElement.querySelector("p:nth-child(4)").innerText = 'Contact: ' + contact;
                                        hostelElement.querySelector("a").href = googleMapsUrl;
                                        alert("Hostel details updated successfully!");
                                    }
                                    document.getElementById("editModal").style.display = "none"; // Close the modal
                                } else {
                                    alert(response.errorMessage);
                                }
                            } else {
                                alert("An error occurred while updating the hostel.");
                            }
                        };

                        xhr.send(data);
                    });
        </script>
    </body>
</html>
