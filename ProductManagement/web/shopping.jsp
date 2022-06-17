<%@page import="sample.users.UserDTO"%>
<%@page import="java.util.List"%>
<%@page import="sample.product.ProductDTO"%>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<!--<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!------ Include the above in your HEAD tag ---------->


<!DOCTYPE html><html class=''>
    <head>
        <!--<script src='//production-assets.codepen.io/assets/editor/live/console_runner-079c09a0e3b9ff743e39ee2d5637b9216b3545af0de366d4b9aad9dc87e26bfd.js'></script><script src='//production-assets.codepen.io/assets/editor/live/events_runner-73716630c22bbc8cff4bd0f07b135f00a0bdc5d14629260c3ec49e5606f98fdd.js'></script><script src='//production-assets.codepen.io/assets/editor/live/css_live_reload_init-2c0dc5167d60a5af3ee189d570b1835129687ea2a61bee3513dee3a50c115a77.js'></script><meta charset='UTF-8'><meta name="robots" content="noindex"><link rel="shortcut icon" type="image/x-icon" href="//production-assets.codepen.io/assets/favicon/favicon-8ea04875e70c4b0bb41da869e81236e54394d63638a1ef12fa558a4a835f1164.ico" /><link rel="mask-icon" type="" href="//production-assets.codepen.io/assets/favicon/logo-pin-f2d2b6d2c61838f7e76325261b7195c27224080bc099486ddd6dccb469b8e8e6.svg" color="#111" /><link rel="canonical" href="https://codepen.io/markbeekman/pen/WRPBjM?limit=all&page=3&q=shop" />-->
        <link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">   
        <link rel="stylesheet" href="assets/navbar/css/style.css">
        <style>
            .products {
                margin: 0 400px;
            }

            .footer {
                background-color: black;
                color: white;
                font-weight: 700;
                font-family: monospace;
                font-size: 17px;
                text-align: center;
                margin-top: 50px;
                padding: 40px 0px
            }
            body {
                background: #e9ebe4;
            }
        </style>
    <body>
        <%

            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            if (user == null || user.getRoleID().equals("AD")) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>

        <div>
            <section class="ftco-section">

                <div class="heading container-fluid">

                    <div style="background-color: white;padding-top: 17px" class="px-md-5">
                        <div class="row justify-content-between">
                            <div class="col-md-8 order-md-last">
                                <div class="row" style="height: 61px">
                                    <div class="col-md-6 text-center">
                                        <a style="font-family: Optima; letter-spacing: 5px; font-size: 30px; margin: -10px 0" class="navbar-brand" href="ProductController">Fipmart<span>Fresh and Juicy</span></a>
                                    </div>
                                    <div class="col-md-6 d-md-flex justify-content-end mb-md-0 mb-3">
                                        <form action="MainController" class="searchform order-lg-last">
                                            <div class="form-group d-flex">
                                                <input type="text" class="form-control pl-3" placeholder="Search" name="Search">
                                                <button type="submit" name="action" value="Search" class="form-control search"><span class="fa fa-search"></span></button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 d-flex">
                                <div class="social-media">
                                    <p class="mb-0 d-flex">
                                        <a href="https://www.facebook.com/haihoang2907/" target="_blank" class="d-flex align-items-center justify-content-center"><span class="fa fa-facebook"><i class="sr-only">Facebook</i></span></a>
                                        <a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-twitter"><i class="sr-only">Twitter</i></span></a>
                                        <a href="https://www.instagram.com/haihoang2907/" target="_blank" class="d-flex align-items-center justify-content-center"><span class="fa fa-instagram"><i class="sr-only">Instagram</i></span></a>
                                        <a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-dribbble"><i class="sr-only">Dribbble</i></span></a>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
                        <div class="container-fluid">

                            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="fa fa-bars"></span> Menu
                            </button>
                            <div class="collapse navbar-collapse" id="ftco-nav">
                                <ul class="navbar-nav m-auto">
                                    <li class="nav-item"><a href="ProductController" class="nav-link">Home</a></li>
                                    <li class="nav-item"><a href="#" class="nav-link">Work</a></li>
                                    <li class="nav-item"><a href="#" class="nav-link">Blog</a></li>
                                    <li class="nav-item"><a href="#" class="nav-link">Contact</a></li>
                                </ul>
                                <div class="product-search">
                                    <section class="shop">
                                        <div class="shop__header">
                                            <div class="shop__text" style="display: flex"> 
                                                <div style="color: white;margin-right: 50px; ">
                                                    <%
                                                        if (user.getFullName() == null) {

                                                    %> 
                                                    <a class="profile" href="#" ><%= user.getEmail()%></a>

                                                    <%} else {
                                                    %> 
                                                    <a class="profile" href="#" ><%= user.getFullName()%></a>

                                                    <%
                                                        }
                                                    %>
                                                    <a class="logout-button" href="MainController?action=Logout" >(Logout)</a>
                                                </div>


                                                <div><a class="button" href="cart.jsp" title="View cart">
                                                        View cart
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                </div>
                            </div>
                        </div>
                    </nav>

                </div>



                <div class="container-fluid">
                    <img src="./assets/navbar/images/header2.jpg" alt="Image Background">
                </div>

         


                <div class="shop__products">
                    <div class="products">

                        <%
                            List<ProductDTO> listProduct = (List) request.getAttribute("LIST_PRODUCT");
                            if (listProduct != null) {
                                for (int i = 0; i < listProduct.size(); i++) {

                        %>
                        <div class="products__item">
                            <article class="product">
                                <div class="product-img">
                                    <img style="width: 100%" src="<%= listProduct.get(i).getImage()%>" />
                                </div>
                                <div class="product__content">
                                    <h1 class="product__title"><%= listProduct.get(i).getProductName()%></h1>
                                    <h5><%= listProduct.get(i).getPrice()%></h5>

                                    <form action="MainController">
                                        <input type="hidden" name="productID" value="<%= listProduct.get(i).getProductID()%>" />
                                        <span><input class="quantity-product" type="number" name="quantity" min="1" value="1"></span>
                                        <input type="submit" value="Add" name="action" 
                                               style="   
                                               border: none;
                                               background-color: black;
                                               color: white;
                                               padding: 4px 13px">
                                    </form>
                                </div>
                            </article>
                        </div>

                        <%
                                }
                            }
                        %>


                    </div>
                </div>

                <%
                    Integer currentPage = (Integer) (request.getAttribute("page"));
                    Integer totalPage = (Integer) request.getAttribute("totalPage");
                    if (currentPage != null && totalPage != null) {
                %>
                <nav>
                    <ul style="justify-content: center" class="pagination">
                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                                <span class="sr-only">Previous</span>
                            </a>
                        </li>
                        <%
                            for (int i = 1; i <= totalPage; i++) {
                        %>
                        <li class="page-item <%= currentPage == i ? "active" : ""%>"><a class="page-link" href="ProductController?page=<%= i%>"><%= i%></a></li>
                            <%
                                }
                            %>
                        <li class="page-item">
                            <a class="page-link" href="" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>
                    </ul>
                </nav> 
                <%
                    }
                %>
                <div class="footer">
                    <p>copyright © 2022 all rights reserved</p>
                    <p>Hoang Manh Hai</p>
                </div>
            </section>
        </div>

        <!--            <aside class="cart js-cart">
                        <div class="cart__header">
                            <form style="display: inline" action="cart.jsp">
                                <a href="cart.jsp" class="cart__title"
                                   style="
                                   border: none;
                                   background-color: black;
                                   padding: 3px 13px;
                                   border-radius: 5%;
                                   "> Shopping cart
                                                                <h1 class="cart__title">Shopping cart</h1>
                                </a>
                            </form>
        
                            <p class="cart__text">
                                <a class="button button--light js-toggle-cart" href="#" title="Close cart">
                                    Close cart
                                </a>
                            </p>
                        </div>
                        <div class="cart__products js-cart-products">
                            <p class="cart__empty js-cart-empty">
                                Add a product to your cart
                            </p>
                            <div class="cart__product js-cart-product-template">
                                <article class="js-cart-product">
                                    <h1>Product title</h1>
                                    <p>
                                        <a class="js-remove-product" href="#" title="Delete product">
                                            Delete product
                                        </a>
                                    </p>
                                </article>
                            </div>
                        </div>
                        <div class="cart__footer">
                            <p class="cart__text">
                                <a class="button" href="#" title="Buy products">
                                    Buy products
                                </a>
                            </p>
                        </div>
                    </aside>
        
                    <div class="lightbox js-lightbox js-toggle-cart"></div>-->
        <script src='//production-assets.codepen.io/assets/common/stopExecutionOnTimeout-b2a7b3fe212eaa732349046d8416e00a9dec26eb7fd347590fbced3ab38af52e.js'></script><script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js'></script>
        <!--            <script >var cartOpen = false;
                        var numberOfProducts = 0;
        
                        $('body').on('click', '.js-toggle-cart', toggleCart);
        //               $('body').on('click', '.js-add-product', addProduct);
                        $('body').on('click', '.js-remove-product', removeProduct);
        
                        function toggleCart(e) {
                            e.preventDefault();
                            if (cartOpen) {
                                closeCart();
                                return;
                            }
                            openCart();
                        }
        
                        function openCart() {
                            cartOpen = true;
                            $('body').addClass('open');
                        }
        
                        function closeCart() {
                            cartOpen = false;
                            $('body').removeClass('open');
                        }
        
                        function addProduct(e) {
                            e.preventDefault();
                            openCart();
                            $('.js-cart-empty').addClass('hide');
                            var product = $('.js-cart-product-template').html();
                            $('.js-cart-products').prepend(product);
                            numberOfProducts++;
                        }
        
                        function removeProduct(e) {
                            e.preventDefault();
                            numberOfProducts--;
                            $(this).closest('.js-cart-product').hide(250);
                            if (numberOfProducts == 0) {
                                $('.js-cart-empty').removeClass('hide');
                            }
                        }
                        //# sourceURL=pen.js
        
                    </script>-->
        <script src="js/jquery.min.js"></script>
        <script src="js/popper.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>
    </body></html>