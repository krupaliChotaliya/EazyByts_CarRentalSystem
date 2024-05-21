<%@ page import="com.car.rental.system.Model.Car" %>
<%@ page import="java.util.Optional" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DriveEase</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .navbar {
            margin-bottom: 0;
        }
    </style>
</head>
<body class="bg-gray-100 flex flex-col items-center  min-h-screen">

<nav class="navbar navbar-expand-lg navbar-dark bg-gray-900 font-serif w-full p-3">
    <a class="navbar-brand" href="/">DriveEase</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item">
                <a class="nav-link active" href="/cars">Cars</a>
            </li>
            <% String userId = null;
                HttpSession httpSession = (HttpSession)
                        request.getSession(false);
                if (httpSession != null &&
                        httpSession.getAttribute("userId") != null) {
                    userId = httpSession.getAttribute("userId").toString();
                }
                if (userId != null) {
            %>

            <li class="nav-item">
                <a class="nav-link active" href="/logout">Logout</a>
            </li>
            <% } %>
            <% String authenticated = null;
                HttpSession httpSession1 = (HttpSession)
                        request.getSession(false);
                if (httpSession1 != null &&
                        httpSession1.getAttribute("userId") != null) {
                    authenticated = httpSession1.getAttribute("userId").toString();
                }
                if
                (authenticated == null) { %>

            <li class="nav-item">
                <a class="nav-link active" href="/login">login</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="/register">Register</a>
            </li>
            <% } %>
            <% String role = null;
                if (httpSession != null &&
                        httpSession.getAttribute("role") != null) {
                    role = httpSession.getAttribute("role").toString();
                }
                if (role != null
                        && role.equals("admin")) { %>

            <li class="nav-item">
                <a class="nav-link active" href="/dashboard/users">Admin DashBoard</a>
            </li>
            <% } %>
        </ul>
    </div>
</nav>
<% Optional<Car> car = (Optional<Car>) request.getAttribute("car");
    if (car.isPresent()) { %>
<div class="w-full justify-center mt-5 max-w-6xl bg-white rounded-lg shadow-lg overflow-hidden flex flex-col md:flex-row">
    <div class="md:w-1/2">
        <img src="${pageContext.request.contextPath}/image/<%= car.get().getImage() %>" alt="Image">
    </div>
    <div class="md:w-1/2 p-8 flex flex-col justify-center">
        <div class="font-bold text-4xl text-gray-800 mb-6"><%= car.get().getModel() %></div>
        <ul class="text-gray-700 text-lg space-y-4">
            <li><strong class="text-gray-900">Brand:</strong> <span
                    class="text-gray-500"> <%= car.get().getBrand() %></span></li>
            <li><strong class="text-gray-900">Type:</strong> <span
                    class="text-gray-500"> <%= car.get().getType() %></span></li>
            <li><strong class="text-gray-900">Color:</strong> <span
                    class="text-gray-500"> <%= car.get().getColor() %></span></li>
            <li><strong class="text-gray-900">Capacity:</strong> <span
                    class="text-gray-500"> <%= car.get().getCapacity() %></span></li>
            <li><strong class="text-gray-900">Year:</strong> <span
                    class="text-gray-500"> <%= car.get().getYear() %></span></li>
            <li><strong class="text-gray-900">Location:</strong> <span
                    class="text-gray-500"> <%= car.get().getLocation() %></span></li>
            <li><strong class="text-gray-900">Rent per Day:</strong> <span
                    class="text-green-500">$<%= car.get().getPrice_per_day() %></span></li>
        </ul>
        <div class="mt-8">
            <label for="startDate" class="block text-gray-700">Start Date:</label>
            <input type="date" id="startDate" name="startDate" class="border rounded-lg py-2 px-3 mt-2 w-full" required>

            <label for="endDate" class="block text-gray-700 mt-4">End Date:</label>
            <input type="date" id="endDate" name="endDate" class="border rounded-lg py-2 px-3 mt-2 w-full" required>

            <button id="bookNowButton"
                    class="bg-blue-600 hover:bg-blue-800 text-white font-semibold py-3 px-6 rounded-lg w-full transition duration-300 mt-8">
                Book Now
            </button>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmationModalLabel">Confirm Booking</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p><strong>Brand:</strong> <span id="modalBrand"></span></p>
                <p><strong>Model:</strong> <span id="modalModel"></span></p>
                <p><strong>Start Date:</strong> <span id="modalStartDate"></span></p>
                <p><strong>End Date:</strong> <span id="modalEndDate"></span></p>
                <p><strong>Total Payment:</strong> $<span id="modalTotalPayment"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" id="confirmButton" class="btn btn-primary">Confirm</button>
            </div>
        </div>
    </div>
</div>

<% } %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('bookNowButton').addEventListener('click', function () {
        const startDate = document.getElementById('startDate').value;
        const endDate = document.getElementById('endDate').value;

        if (startDate && endDate) {
            var pricePerDay = <%= car.get().getPrice_per_day() %>;
            var start = new Date(startDate);
            var end = new Date(endDate);
            var diffTime = Math.abs(end - start);
            var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
            var totalPayment = diffDays * pricePerDay;

            document.getElementById('modalBrand').innerText = '<%= car.get().getBrand() %>';
            document.getElementById('modalModel').innerText = '<%= car.get().getModel() %>';
            document.getElementById('modalStartDate').innerText = startDate;
            document.getElementById('modalEndDate').innerText = endDate;
            document.getElementById('modalTotalPayment').innerText = totalPayment;

            var confirmationModal = new bootstrap.Modal(document.getElementById('confirmationModal'));
            confirmationModal.show();
        } else {
            alert('Please select both start and end dates.');
        }
    });

    document.getElementById('confirmButton').addEventListener('click', function() {
        const carId = <%= car.get().getId() %>;
        console.log('Car ID:', carId);
        var rental = {
            "user": { "userId": 1 },
            "car": { "id": carId },
            "start_date": document.getElementById('modalStartDate').innerText,
            "end_date": document.getElementById('modalEndDate').innerText,
            "payment": document.getElementById('modalTotalPayment').innerText,
            "payment_status": 'Success'
        };
        fetch('/rental/book', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(rental)
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok ' + response.statusText);
                }
                return response.json();
            })
            .then(data => {
                alert(data.message);
                var confirmationModal = bootstrap.Modal.getInstance(document.getElementById('confirmationModal'));
                if (confirmationModal) {
                    confirmationModal.hide();
                }
            })
            .catch((error) => {
                console.error('Error:', error);
                alert('Booking failed. Please try again.'+error);
                const confirmationModal = bootstrap.Modal.getInstance(document.getElementById('confirmationModal'));
                if (confirmationModal) {
                    confirmationModal.hide();
                }
            });
    });
</script>
</body>
</html>