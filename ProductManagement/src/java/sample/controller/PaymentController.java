/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.order.Orders;
import sample.order.OrdersDAO;
import sample.product.Cart;
import sample.product.ProductDAO;
import sample.users.UserDTO;
import sample.order.OrderDetail;
import sample.product.ProductDTO;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;
import sample.email.SendMail;

/**
 *
 * @author light
 */
@WebServlet(name = "PaymentController", urlPatterns = {"/PaymentController"})
public class PaymentController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "success.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            OrdersDAO dao = new OrdersDAO();
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("CART");
            UserDTO user = null;
            Orders orders = null;
            OrderDetail orderDetail = null;
            String orderID = "";
            String detailID = "";
            boolean condition_1 = false;
            boolean condition_2 = false;
            int count = 0;
            //Orders
            if (cart != null && cart.getCart().size() > 0) {
                while (true) {
                    orderID = "OrID" + ThreadLocalRandom.current().nextInt(1, 100000);
                    if (!dao.checkOrderID(orderID)) {
                        break;
                    }
                }
                double total = Double.parseDouble(request.getParameter("Total"));
                long millis = System.currentTimeMillis();
                java.sql.Date date = new java.sql.Date(millis);
                String orderDate = new SimpleDateFormat("yyyy-MM-dd").format(date);
                user = (UserDTO) session.getAttribute("LOGIN_USER");
                orders = new Orders(orderID, orderDate, total, user.getUserID(), "Active");


                if (dao.insertOrders(orders)) {
                    condition_1 = true;
                }
//End Orders

                //OrdersDetail
                for (ProductDTO product : cart.getCart().values()) {
                    while (true) {
                        detailID = "deID" + ThreadLocalRandom.current().nextInt(1, 100000);
                        if (!dao.checkDetailID(detailID)) {
                            break;
                        }
                    }
                    double price = product.getPrice();
                    int quantity = product.getQuantity();
                    String productID = product.getProductID();
                    orderDetail = new OrderDetail(detailID, price, quantity, orderID, productID);
                    if (dao.insertOrderDetail(orderDetail)) {
                        count++;
                        dao.updateQuantity(orderDetail);
                    }

                }

                if (count == cart.getCart().size()) {
                    condition_2 = true;
                }
                //END OrdersDetail
            }
            
            String email = request.getParameter("email");
            
            if (condition_1 && condition_2) {
                SendMail.sendMail(user, orders,email);
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at PaymentController " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
