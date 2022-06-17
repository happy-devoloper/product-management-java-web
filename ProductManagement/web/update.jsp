<%-- 
    Document   : update
    Created on : Mar 4, 2022, 9:48:16 PM
    Author     : light
--%>

<%@page import="sample.product.ProductError"%>
<%@page import="sample.users.UserDTO"%>
<%@page import="sample.product.ProductDAO"%>
<%@page import="sample.product.ProductDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up Form by Colorlib</title>

        <!-- Font Icon -->
        <link rel="stylesheet" href="./assets/create/fonts/material-icon/css/material-design-iconic-font.min.css">

        <!-- Main css -->
        <link rel="stylesheet" href="./assets/create/css/style.css">
        <title>Update Page</title>
    </head>
    <body>
        <%
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            if (user == null || user.getRoleID().equals("US")) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <%
            String productID = request.getParameter("productID");
            ProductDTO product = new ProductDAO().getProduct(productID);
            ProductError error = (ProductError) request.getAttribute("ERROR");
            if (error == null) {
                error = new ProductError();
            }
        %>

        <div class="main">

            <div class="container">
                <form action="MainController" method="POST" class="appointment-form" id="appointment-form">
                    <h2>FOOD MANAGEMENT</h2>
                    <div class="form-group-1">
                        <p>Product ID</p><input type="text" name="productID" required="" placeholder="ProductID" value="<%= product.getProductID()%>" readonly=""/> </br>
                        <p>Product Name</p><input type="text" name="productName" required="" placeholder="Product Name" value="<%= product.getProductName()%>"/> </br>
                        <p>Image URL</p><input type="url" name="image" required="" placeholder="Image" value="<%= product.getImage()%>"/> </br>
                        <p>Price</p><input type="number" min="0" name="price" required="" placeholder="Price" value="<%= product.getPrice()%>"/> </br>
                        <p>Quantity</p><input type="number" min="0" name="quantity" required="" placeholder="Quantity" value="<%= product.getQuantity()%>"/> </br>


                        <div>
                            <p>Category ID</p>
                            <select name="categoryID">
                                <option value="C01">C01</option>
                                <option value="C02">C02</option>
                            </select>
                        </div>


                        <div>
                            <p>Import Date</p>
                            <input type="date" name="importDate" placeholder="Import Date" required value="<%= product.getImportDate()%>"/>
                        </div>

                        <div>
                            <p>Using Date</p>
                            <input type="date" name="usingDate" placeholder="Using Date" required value="<%= product.getUsingDate()%>"/>
                        </div>
                        <p style="    
                           color: red;
                           font-size: 12px;
                           font-weight: 700;"> <%= error.getUsingDateError()%> </p>


                        <div>
                            <p>Status</p>
                            <select name="status">
                                <option value="Active">Active</option>
                                <option value="NonActive">NonActive</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-submit">
                        <input type="submit" name="action" id="submit" class="submit" value="Update" />
                    </div>

                    <div style="padding-top: 17px;">
                        <a style="margin-left: 7px;" href="ProductController">Cancel</a>
                    </div>

                </form>

            </div>

        </div>
        <!-- JS -->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>
