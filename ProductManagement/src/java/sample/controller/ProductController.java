/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.product.ProductDAO;
import sample.product.ProductDTO;
import sample.users.UserDTO;

/**
 *
 * @author light
 */
@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
public class ProductController extends HttpServlet {

    private static final String AD = "AD";
    private static final String US = "US";
    private static final String AD_PAGE = "admin.jsp";
    private static final String US_PAGE = "shopping.jsp";
    private static final String ERROR = "login.jsp";
    private static final int AD_PAGE_SIZE = 7;
    private static final int US_PAGE_SIZE = 6;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            String login = (String) request.getAttribute("login");
            String pageStr = request.getParameter("page");
            int page = 1;
            int productTotal;
            if(pageStr != null)
                page = Integer.parseInt(pageStr);
            List<ProductDTO> listProduct = null;
            ProductDAO dao = new ProductDAO();
            
            if (loginUser != null) {
                if (AD.equals(loginUser.getRoleID())) {
                    productTotal = dao.getTotalAdminProduct();
                    int totalPage = productTotal / AD_PAGE_SIZE;
                    if(productTotal % AD_PAGE_SIZE != 0) 
                        totalPage += 1;
                    listProduct = dao.getAdminProductsWithPagging(page, AD_PAGE_SIZE);
                    
                    request.setAttribute("page", page);
                    request.setAttribute("totalPage", totalPage);
                    request.setAttribute("LIST_PRODUCT", listProduct);
                    url = AD_PAGE;

                } else if (US.equals(loginUser.getRoleID()) || "google".equals(login)) {
                    productTotal = dao.getTotalUserProduct();
                    int totalPage = productTotal / US_PAGE_SIZE;
                    if(productTotal % US_PAGE_SIZE != 0) 
                        totalPage += 1;
                    listProduct = dao.getUserProductsWithPagging(page, US_PAGE_SIZE);
                    
                    request.setAttribute("page", page);
                    request.setAttribute("totalPage", totalPage);
                    request.setAttribute("LIST_PRODUCT", listProduct);
                    url = US_PAGE;
                }           
            }
        } catch (Exception e) {
            e.printStackTrace();
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
