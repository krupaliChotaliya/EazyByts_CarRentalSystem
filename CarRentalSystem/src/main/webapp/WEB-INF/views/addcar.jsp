<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DriveEase</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .alert {
            margin-top: 20px;
        }

        body {
            background-color: #e5e0e0;
            font-weight: bold;
        }
        .container {
            margin-top: 50px;
        }

        @media (min-width: 576px) {
            .form-group textarea {
                resize: vertical;
            }
        }

        .blog-form {
            background-color: white;
            border: 1px solid #ced4da;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
            margin-bottom: 30px;
        }

        .blog-form:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .blog-heading {
            text-align: center;
            color: #000000;
            font-size: 28px;
            margin-bottom: 30px;
        }
        body {
            background-color: #e5e0e0;
        }
    </style>
</head>
<body>
<%
    String message = (String) request.getAttribute("message");
    if (message != null && !message.isEmpty()) {
%>
<div class="alert alert-success"><%= message %>
</div>
<%
    }
%>

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
<div class="container">
    <h2 class="blog-heading text-black">Add a New Car</h2>
    <div class="blog-form p-5">
            <%--@elvariable id="car" type=""--%>
            <form:form modelAttribute="car" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label>Brand:</label>
                    <form:input path="brand" class="form-control" required="true"/>
                </div>
                <div class="form-group">
                    <label>Model:</label>
                    <form:input path="model" class="form-control" required="true"/>
                </div>
                <div class="form-group">
                    <label>Manufacturing Year:</label>
                    <form:input path="year" class="form-control" rows="5" required="true"></form:input>
                </div>
                <div class="form-group">
                    <label>Capacity:</label>
                    <form:input path="capacity" class="form-control" rows="5" required="true"></form:input>
                </div>
                <div class="form-group">
                    <label>Location:</label>
                    <form:input path="location" class="form-control" rows="5" required="true"></form:input>
                </div>
                <div class="form-group">
                    <label>Color:</label>
                    <form:input path="color" class="form-control" rows="5" required="true"></form:input>
                </div>
                <div class="form-group">
                    <label>Type:</label>
                    <form:input path="type" class="form-control" rows="5" required="true"></form:input>
                </div>
                <div class="form-group">
                    <label>Price per hour:</label>
                    <form:input path="price_per_day" class="form-control" rows="5" required="true"></form:input>
                </div>
                <div class="form-group">
                    <label>Car Image:</label>
                    <input type="file" name="image" class="form-control-file" required="true"/>
                </div>
                <button type="submit" class="btn btn-success">Submit</button>
            </form:form>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>







