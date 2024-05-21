<%@ page import="com.car.rental.system.Model.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap4.min.css" rel="stylesheet">
    <style>
        .card {
            border: none;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }

        body {
            background-color: #e5e0e0;
        }
    </style>
</head>
<body>


<nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #0b172d">
    <a class="navbar-brand" href="#">DriveEase</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav mr-auto">
           <li class="nav-item active">
            <a class="nav-link" href="/dashboard/users">Users</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="/dashboard/cars">Cars</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="/dashboard/rentals">Rentals</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="/logout">logout</a>
            </li>
        </ul>
    </div>
</nav>
<div class="container mt-4 mb-3">
    <div class="row">
        <div class="col">
            <div class="card">
                <div class="card-body">
                    <h2>Users Data</h2>
                    <a href="/user">
                        <button class="btn btn-success mb-3" id="newCategoryBtn">New User</button>
                    </a>
                    <div class="table-responsive">
                        <table id="categoryTable" class="table table-striped table-bordered" style="width:100%">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Password</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <% List<User> users = (List<User>) request.getAttribute("users");
                                if (users != null) {
                                    for (User user : users) { %>
                            <tr>
                                <td><%= user.getUserId() %>
                                </td>
                                <td><%= user.getUsername() %>
                                </td>
                                <td>
                                    <input type="password" value="<%= user.getPassword() %>"/>
                                </td>
                                <td><%= user.getEmail() %>
                                </td>
                                <td><%= user.getRole() %>
                                </td>
                                <td>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/users/update?userId=<%= user.getUserId() %>">
                                        <button type="button" class="btn btn-primary btn-sm mr-2">Update</button>
                                    </a>
                                </td>
                            </tr>
                            <% }
                            }
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap4.min.js"></script>

<script>
    $(document).ready(function () {
        $('#categoryTable').DataTable();
        $('#newCategoryBtn').click(function () {
            console.log("New Category button clicked");
        });
    });
</script>
</body>
</html>
