<%@page import="sample.product.ProductError"%>
<%@page import="sample.users.UserDTO"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Sign Up Form by Colorlib</title>

        <!-- Font Icon -->
        <link rel="stylesheet" href="./assets/create/fonts/material-icon/css/material-design-iconic-font.min.css">

        <!-- Main css -->
        <link rel="stylesheet" href="./assets/create/css/style.css">
        <style>
            .form-group-1 input,select {
                padding: 45px 0 15px;
            }

            .form-group-1 p {
                color: red;
                font-size: 12px;
                font-weight: 700;
            }
        </style>
    </head>

    <body>
        <%
            ProductError error = (ProductError) request.getAttribute("ERROR");
            if(error == null) {
                error = new ProductError();
            }
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            if (user == null || user.getRoleID().equals("US")) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <div class="main">

            <div class="container">
                <form method="POST" class="appointment-form" id="appointment-form">
                    <h2>FOOD MANAGEMENT</h2>
                    <div class="form-group-1">
                        <input type="text" name="productID" placeholder="Product ID" required />
                        <p><%= error.getProductIDError() %></p>
                        <input type="text" name="productName" placeholder="Product Name" required />
                        <input type="url" name="image" placeholder="URL Image" required />
                        <input type="number" name="price" placeholder="Price" min="0" required />
                        <input type="number" name="quantity" placeholder="Quantity" min="0" required />
                        <div>
                            <select required name="categoryID">
                                <option value="" disabled selected hidden>Category ID</option>
                                <option value="C01">C01</option>
                                <option value="C02">C02</option>
                            </select>
                        </div>
                        <input type="date" name="importDate" placeholder="Import Date" required />
                        <input type="date" name="usingDate" placeholder="Using Date" required />
                        <p><%= error.getUsingDateError() %></p>
                        <div>
                            <select required name="status">
                                <option value="" disabled selected hidden>Status</option>
                                <option value="Active">Active</option>
                                <option value="NonActive">NonActive</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-submit">
                        <input type="submit" name="action" id="submit" class="submit" value="Create" />
                    </div>
                    <a style="margin-left: 7px;" href="ProductController">Cancel</a>

                </form>

            </div>

        </div>
        <!-- JS -->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="js/main.js"></script>
    </body><!-- This templates was made by Colorlib (https://colorlib.com) -->

</html>