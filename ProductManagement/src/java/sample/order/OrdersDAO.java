/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import sample.utils.DBUtils;

/**
 *
 * @author light
 */
public class OrdersDAO {

    private static final String CHECK_ORDER_ID = "SELECT orderID FROM tblOrders WHERE orderID = ?";
    private static final String CHECK_DETAIL_ID = "SELECT detailID FROM tblOrderDetail WHERE detailID = ?";
    private static final String INSERT_DETAIL_ORDER = "INSERT INTO tblOrderDetail (detailID, price, quantity, orderID, productID) VALUES (?, ?, ?, ?, ?)";
    private static final String INSERT_ORDERS = "INSERT INTO tblOrders(orderID, orderDate, total, userID, status) VALUES (?,?,?,?,?)";
    private static final String UPDATE_QUANTITY = "UPDATE tblProduct SET quantity = quantity - ? WHERE productID = ?";

    
    public void updateQuantity(OrderDetail orderDetail) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_QUANTITY);
            ptm.setInt(1, orderDetail.getQuantity());
            ptm.setString(2, orderDetail.getProductID());
            ptm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (ptm != null) {
                ptm.close();
            }
        }
    }
    
    public boolean insertOrders(Orders orders) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(INSERT_ORDERS);
            ptm.setString(1, orders.getOrderID());
            ptm.setString(2, orders.getOrderDate());

            ptm.setDouble(3, orders.getTotal());
            ptm.setString(4, orders.getUserID());
            ptm.setString(5, orders.getStatus());
            if (ptm.executeUpdate() > 0) {
                check = true;
            }
        } catch (Exception e) {
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (ptm != null) {
                ptm.close();
            }
        }
        return check;
    }

    public boolean insertOrderDetail(OrderDetail orderDetail) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(INSERT_DETAIL_ORDER);
            ptm.setString(1, orderDetail.getDetailID());
            ptm.setDouble(2, orderDetail.getPrice());
            ptm.setInt(3, orderDetail.getQuantity());
            ptm.setString(4, orderDetail.getOrderID());
            ptm.setString(5, orderDetail.getProductID());
            if (ptm.executeUpdate() > 0) {
                check = true;
            }

        } catch (Exception e) {
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (ptm != null) {
                ptm.close();
            }
        }
        return check;
    }

    public boolean checkOrderID(String id) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        Orders order = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(CHECK_ORDER_ID);
            ptm.setString(1, id);
            rs = ptm.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (rs != null) {
                rs.close();
            }

        }
        return check;
    }

    public boolean checkDetailID(String id) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        Orders order = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(CHECK_DETAIL_ID);
            ptm.setString(1, id);
            rs = ptm.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (rs != null) {
                rs.close();
            }

        }
        return check;
    }

}
