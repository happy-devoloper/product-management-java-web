<%@page import="java.util.List"%>
<%@page import="sample.product.ProductDTO"%>
<%@page import="sample.users.UserDTO"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Bootstrap User Management Data Table</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="./css/admin.css" />

        <script>
            $(document).ready(function () {
                $('[data-toggle="tooltip"]').tooltip();
            });
        </script>
    </head>
    <body>
        <%
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            if (user == null || user.getRoleID().equals("US")) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <div class="container-xl" style="max-width: 100%;">
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-5">
                                <h2>Food <b>Management</b></h2>
                            </div>
                            <div class="userLogin">
                                <a class="" href="profile.jsp" ><%= user.getFullName()%></a>
                                <a  href="MainController?action=Logout" >(Logout)</a>
                            </div>
                            <div class="col-sm-5">
                                <a href="MainController?action=Create" class="btn btn-secondary"><i class="material-icons">&#xE147;</i> <span>Add New Product</span></a>
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>						
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Category ID</th>
                                <th>Import Date</th>
                                <th>Using Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>

                            <%
                                List<ProductDTO> listProduct = (List) request.getAttribute("LIST_PRODUCT");
                                if (listProduct != null) {
                                    for (ProductDTO list : listProduct) {

                            %> 

                            <tr>
                                <td><%= list.getProductID()%></td>
                                <td style="width: 500px"><a href="#"><img style="max-width: 22%" src="<%= list.getImage()%>" class="avatar" alt="Avatar"><%= list.getProductName()%></a></td>
                                <td><%= list.getPrice()%></td>                        
                                <td><%= list.getQuantity()%></td>
                                <td><%= list.getCategoryID()%></td>
                                <td><%= list.getImportDate()%></td>
                                <td><%= list.getUsingDate()%></td>
                                <%
                                    if (list.getStatus().equals("Active")) {
                                %>
                                <td><span class="status text-success">&bull;</span> Active</td>
                                <%
                                } else {
                                %>
                                <td><span class="status text-danger">&bull;</span> NonActive</td>                        
                                <%
                                    }
                                %>
                                <td>
                                    <a href="update.jsp?productID=<%= list.getProductID()%>" class="settings" title="Update" data-toggle="tooltip"><i class="material-icons">&#xE8B8;</i></a>
                                    <a href="MainController?action=Delete&productID=<%= list.getProductID()%>" class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE5C9;</i></a>
                                </td>
                            </tr>
                            <tr>



                                <%         }
                                %> 
                        <div style="margin-right: 130px">
                            <%
                                int currentPage = (Integer)(request.getAttribute("page"));    
                            %>
                            <nav aria-label="Page navigation example">
                                <ul class="pagination">
                                    <li class="page-item">
                                        <a class="page-link" href="#" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                            <span class="sr-only">Previous</span>
                                        </a>
                                    </li>
                                    <%
                                        
                                        int totalPage = (Integer) request.getAttribute("totalPage");
                                        for (int i = 1; i <= totalPage; i++) {
                                    %>
                                    <li class="page-item <%= currentPage == i ? "active" : "" %>"><a class="page-link" href="ProductController?page=<%= i %>"><%= i %></a></li>
                                        <%
                                            }
                                        %>
                                    <li class="page-item">
                                        <a class="page-link" href="ProductController?page=<%= currentPage + 1 %>" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                            <span class="sr-only">Next</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>   
                        </div>

                        <%
                            }
                        %>

                        </tbody>
                    </table>
                    <!-- <div class="clearfix">
                        <div class="hint-text">Showing <b>5</b> out of <b>25</b> entries</div>
                        <ul class="pagination">
                            <li class="page-item disabled"><a href="#">Previous</a></li>
                            <li class="page-item"><a href="#" class="page-link">1</a></li>
                            <li class="page-item"><a href="#" class="page-link">2</a></li>
                            <li class="page-item active"><a href="#" class="page-link">3</a></li>
                            <li class="page-item"><a href="#" class="page-link">4</a></li>
                            <li class="page-item"><a href="#" class="page-link">5</a></li>
                            <li class="page-item"><a href="#" class="page-link">Next</a></li>
                        </ul>
                    </div> -->
                </div>
            </div>
        </div>     
    </body>
</html>