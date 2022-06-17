<%@page import="sample.product.ProductDTO"%>
<%@page import="sample.product.Cart"%>
<%@page import="sample.users.UserDTO"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <link href= "checkout.css" rel="stylesheet" type="text/css" /> 
        <style>

            .form-title {
                padding: 13px 0 0 15px;
                margin-top: 17px;
            }
            h6 {
                font-size: 15px;
            }
        </style> 
        <title>Document</title>
    </head>

    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || loginUser.getRoleID().equals("AD")) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <div class="container wrapper">
            <div class="row cart-head">
                <div class="container">
                    <div class="row">
                        <p></p>
                    </div>
                    <div class="row ">
                        <div style="display: flex; justify-content: space-evenly;margin-top:30px">
                            <span class="step step_complete"> <a href="cart.jsp" class="check-bc">Cart</a> <span
                                    class="step_line step_complete"> </span> <span class="step_line backline"> </span> </span>
                            <span class="step step_complete"> <a href="#" class="check-bc">Checkout</a> <span
                                    class="step_line step_complete"> </span> <span class="step_line backline"> </span> </span>
                            <span class="step"> <a href="#" class="check-bc">Done!</a> <span class="step_line "> </span> <span
                                    class="step_line backline"> </span> </span>
                        </div>
                    </div>
                    <div class="row">
                        <p></p>
                    </div>
                </div>
            </div>
            <div class="row cart-body">

                <form class="form-horizontal" method="post" action="MainController">
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 col-md-push-6 col-sm-push-6">
                        <!--REVIEW ORDER-->

                        <div class="panel panel-info">
                            <div class="heading-panel">
                                Review Order <div class="pull-right"><small><a class="edit-cart" href="cart.jsp">Edit Cart</a></small></div>
                            </div>
                            <div class="panel-body">

                                <%
                                    Cart cart = (Cart) session.getAttribute("CART");
                                    double total = 0;
                                    if (cart != null) {
                                        if (cart.getCart().size() > 0) {
                                            for (ProductDTO product : cart.getCart().values()) {
                                                total += product.getQuantity() * product.getPrice();
                                %> 


                                <div class="form-group">                                   
                                    <div class="col-sm-3 col-xs-3">
                                        <img class="img-responsive" src="<%= product.getImage()%>" />
                                    </div>
                                    <div class="col-sm-6 col-xs-6">
                                        <div class="col-xs-12"><%= product.getProductName()%></div>
                                        <div class="col-xs-12"><small>Quantity:<%= product.getQuantity()%><span></span></small></div>
                                    </div>
                                    <div class="col-sm-3 col-xs-3 text-right">
                                        <h6><span><%= product.getPrice()%></span>VND</h6>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <hr />
                                </div>            

                                <%
                                    }
                                %>
                            </div>
                            <div style="padding: 0px 25px">

                                <div class="form-group">
                                    <div class="col-xs-12">
                                        <strong>Subtotal</strong>
                                        <div class="pull-right"><span><%= total%> </span><span>VND</span></div>
                                    </div>
                                    <div class="col-xs-12">
                                        <small>Shipping</small>
                                        <div class="pull-right"><span>30.000 VND</span></div>
                                    </div>
                                    <div class="col-xs-12">
                                        <small>Tax</small>
                                        <div class="pull-right"><span>20.000 VND</span></div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <hr />
                                </div>
                                <div class="form-group">
                                    <div class="col-xs-12">
                                        <strong>Order Total</strong>
                                        <% total += 30000 + 20000;%>
                                        <div class="pull-right"><span><%= total%> </span><span>VND</span></div>
                                        <input type="hidden" name="Total" value="<%= total%>" />
                                    </div>
                                </div>
                            </div>
                            <%

                                } else
                                    request.getRequestDispatcher("ProductController").forward(request, response);
                            %>
                        </div>


                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 col-md-push-6 col-sm-push-6">
                        <div class="form-group">
                            <input name="action" value="Payment" type="submit" class="button-submit"/>                          
                        </div>
                    </div>
                        <!--REVIEW ORDER END-->
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 col-md-pull-6 col-sm-pull-6">
                        <!--SHIPPING METHOD-->
                        <div class="panel panel-info">
                            <div class="heading-panel">Address</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <div class="text-form" class="col-md-12">
                                        <h4>Shipping Address</h4>
                                    </div>
                                </div>

                                <%
                                    if (loginUser.getFullName() != null) {
                                %>
                                <div class="form-group">
                                    <div class="col-md-12 form-title"><strong>Full Name:</strong></div>
                                    <div class="col-md-12">                                 
                                        <input type="text" name="fullName" class="input-form" value="<%= loginUser.getFullName()%>" required=""/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-md-12 form-title"><strong>Address:</strong></div>
                                    <div class="col-md-12">
                                        <input type="text" name="address" class="input-form" value="<%= loginUser.getAddress()%>" required=""/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-md-12 form-title"><strong>Phone Number:</strong></div>
                                    <div class="col-md-12"><input type="text" name="phone_number" class="input-form" value="<%= loginUser.getPhone()%>" required=""/></div>
                                </div>

                                <%
                                } else {
                                %>
                                <div class="form-group">
                                    <div class="col-md-12 form-title"><strong>Full Name:</strong></div>
                                    <div class="col-md-12">                                 
                                        <input type="text" name="fullName" class="input-form" required=""/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-md-12 form-title"><strong>Address:</strong></div>
                                    <div class="col-md-12">
                                        <input type="text" name="address" class="input-form" required=""/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-md-12 form-title"><strong>Phone Number:</strong></div>
                                    <div class="col-md-12"><input type="text" name="phone_number" class="input-form" required=""/></div>
                                </div>

                                <%
                                    }
                                %>

                                <div class="form-group">
                                    <div class="col-md-12 form-title"><strong>Birthday</strong></div>
                                    <div class="col-md-12">
                                        <input type="date" name="birthday" class="input-form" value="<%= loginUser.getBirthday()%>" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-md-12 form-title"><strong>Email Address:</strong></div>
                                    <div class="col-md-12"><input type="text" name="email" class="input-form" value="<%= loginUser.getEmail()%>" required=""/></div>
                                </div>
                            </div>
                        </div>
                        <!--SHIPPING METHOD END-->
                        <!--CREDIT CART PAYMENT-->
                        <div class="panel panel-info">
                            <div class="heading-panel"><span><i class="glyphicon glyphicon-lock"></i></span> Secure Payment</div>
                            <div class="panel-body">

                                <div class="cod">
                                    <input checked="checked" name="payment" type="radio" value="COD" /> COD
                                </div>


                            </div>
                        </div>
                        <!--CREDIT CART PAYMENT END-->
                    </div>



                </form>

            </div>
            <div class="row cart-footer">
            </div>

            <%
                }
            %>
        </div>
    </body>

</html>