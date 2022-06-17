<%@page import="sample.users.UserDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="sample.product.ProductDTO"%>
<%@page import="sample.product.Cart"%>
<!--<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>-->
<!------ Include the above in your HEAD tag ---------->


<!DOCTYPE html><html lang='en' class=''>
    <head>
        <!--        <script src='//production-assets.codepen.io/assets/editor/live/console_runner-079c09a0e3b9ff743e39ee2d5637b9216b3545af0de366d4b9aad9dc87e26bfd.js'></script>
                <script src='//production-assets.codepen.io/assets/editor/live/events_runner-73716630c22bbc8cff4bd0f07b135f00a0bdc5d14629260c3ec49e5606f98fdd.js'></script>
                <script src='//production-assets.codepen.io/assets/editor/live/css_live_reload_init-2c0dc5167d60a5af3ee189d570b1835129687ea2a61bee3513dee3a50c115a77.js'></script>
                <meta charset='UTF-8'><meta name="robots" content="noindex">
                <link rel="shortcut icon" type="image/x-icon" href="//production-assets.codepen.io/assets/favicon/favicon-8ea04875e70c4b0bb41da869e81236e54394d63638a1ef12fa558a4a835f1164.ico" />
                <link rel="mask-icon" type="" href="//production-assets.codepen.io/assets/favicon/logo-pin-f2d2b6d2c61838f7e76325261b7195c27224080bc099486ddd6dccb469b8e8e6.svg" color="#111" />
                <link rel="canonical" href="https://codepen.io/alex_rodrigues/pen/ABGdg?depth=everything&order=popularity&page=32&q=product&show_forks=false" />
                <script src="https://s.codepen.io/assets/libs/modernizr.js" type="text/javascript"></script>-->

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/cart.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <%
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            if (user == null || user.getRoleID().equals("AD")) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <div class="wrap cf">
            <h1 class="projTitle">Flipmart<span>Shopping Cart</span> </h1>
            <div class="heading cf">
                <h1>My Cart</h1>
                <a href="ProductController" class="continue">Continue Shopping</a>
            </div>

            <%
                Cart cart = (Cart) session.getAttribute("CART");
                HashMap<String, String> errorQuantity = (HashMap) request.getAttribute("ERROR_QUANTITY");
                if (cart != null) {
                    if (cart.getCart().size() > 0) {
                        int count = 1;
                        double total = 0;
                        for (ProductDTO product : cart.getCart().values()) {
                            total += product.getPrice() * product.getQuantity();
            %>

            <div class="cart">
                <ul class="cartWrap">

                    <li class="items even">
                        <div class="infoWrap"> 
                            <div class="cartSection">
                                <img src="<%= product.getImage()%>" alt="" class="itemImg" />
                                <p class="itemNumber">#<%= product.getProductID()%></p>
                                <h3><%= product.getProductName()%></h3>

                                <form action="MainController">
                                    <p> <input type="number" name="quantity" class="qty" value="<%= product.getQuantity()%>" min="1"/> x <%= product.getPrice()%></p>
                                    <input style="cursor: pointer;" class ="modify-button" type="submit" name="action" value="Modify"/>
                                    <input type="hidden" name="productID" value="<%= product.getProductID()%>"/>
                                </form>


                                <p class="stockStatus"> In Stock</p>
                                <%
                                    String error;
                                    if (errorQuantity != null) {
                                        error = errorQuantity.get(product.getProductID());
                                        if (error == null)
                                            error = "";
                                        else {
                                %>                               
                                <p style="color:red;font-weight: 600; font-size: 11px; margin-left: 20px"><%= error%></p>        
                                <%
                                        }
                                    }
                                %>
                            </div>  


                            <div class="prodTotal cartSection">
                                <p> <%= product.getPrice() * product.getQuantity()%></p>
                            </div>
                            <div class="cartSection removeWrap">
                                <a href="MainController?action=Remove&productID=<%= product.getProductID()%>" class="remove">x</a>
                            </div>
                        </div>
                    </li>

                </ul>
            </div>

            <%  }

            %>
            <div class="special"><div class="specialContent">Free gift with purchase!, gift wrap, etc!!</div></div>

            <div class="promoCode"><label for="promo">Have A Promo Code?</label><input type="text" name="promo" placholder="Enter Code" />
                <a href="#" class="btn"></a></div>

            <div class="subtotal cf">
                <ul>
                    <li class="totalRow"><span class="label">Subtotal</span><span class="value"><%= total%>VND</span></li>

                    <li class="totalRow"><span class="label">Shipping</span><span class="value">30.000VND</span></li>

                    <li class="totalRow"><span class="label">Tax</span><span class="value">20.000VND</span></li>
                    <li class="totalRow final"><span class="label">Total</span><span class="value"><%= total + 30000 + 20000%>VND</span></li>
                        <%

                        %>
                    <li class="totalRow"><a href="MainController?action=Checkout" class="btn continue">Checkout</a></li>
                </ul>
            </div>
            <%            } else {
            %> 
            <p style="text-align: center;
               font-size: 20px;
               margin-top: 81px;"> <%= "There are NO Product here!!"%> </p>
            <%

                    }
                }
            %>
        </div>
        <!--<script src='//production-assets.codepen.io/assets/common/stopExecutionOnTimeout-b2a7b3fe212eaa732349046d8416e00a9dec26eb7fd347590fbced3ab38af52e.js'></script><script src='//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>-->
        <!--        <script >// Remove Items From Cart
                    $('a.remove').click(function () {
                        event.preventDefault();
                        $(this).parent().parent().parent().hide(400);
        
                    })
        
                    // Just for testing, show all items
                    $('a.btn.continue').click(function () {
                        $('li.items').show(400);
                    })
        
        
                    //# sourceURL=pen.js
                </script>-->
    </body></html>