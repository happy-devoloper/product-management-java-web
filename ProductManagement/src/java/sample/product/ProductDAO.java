/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.product;

import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import sample.utils.DBUtils;

/**
 *
 * @author light
 */
public class ProductDAO {

    private static final String USER_PRODUCT = "SELECT productID, productName, image, price, quantity, categoryID, importDate, usingDate FROM tblProduct WHERE usingDate > ? AND quantity > 0 and status = 'Active'";
    private static final String ADMIN_PRODUCT = "SELECT productID, productName, image, price, quantity, categoryID, importDate, usingDate, status FROM tblProduct";
    private static final String SEARCH_USER_PRODUCT = "SELECT productID, productName, image, price, quantity, categoryID, importDate, usingDate FROM tblProduct WHERE productName like ? AND usingDate > ? AND quantity > 0 and status = 'Active'";
    private static final String CREATE = "INSERT INTO tblProduct(productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) VALUES (?,?,?,?,?,?,?,?,?)";
    private static final String DELETE = "UPDATE tblProduct SET status = 'NonActive' WHERE productID = ? ";
    private static final String SEARCH_ID = "SELECT productName, image, price, quantity, categoryID, importDate, usingDate ,status FROM tblProduct WHERE productID = ? ";
    private static final String UPDATE = "UPDATE tblProduct SET productName = ?, image = ?, price = ?, quantity = ?, categoryID = ? ,importDate = ? ,usingDate = ? , status = ? WHERE productID = ?";
    private static final String CHECK_QUANTITY = "SELECT productID, quantity FROM tblProduct WHERE quantity < ? and productID = ?";
    private static final String ADMIN_PRODUCT_PAGGING = "SELECT productID, productName, image, price, quantity, categoryID, importDate, usingDate, status FROM tblProduct order by productID offset (?-1)*? row fetch next ? row only";
    private static final String COUNT_ADMIN_PRODUCT = "SELECT count(productID) FROM tblProduct ";
    private static final String USER_PRODUCT_PAGGING = "SELECT productID, productName, image, price, quantity, categoryID, importDate, usingDate FROM tblProduct WHERE usingDate > ? AND quantity > 0 and status = 'Active' order by productID offset (?-1)*? row fetch next ? row only";
    private static final String COUNT_USER_PRODUCT = "SELECT count(productID) FROM tblProduct WHERE usingDate > ? AND quantity > 0 and status = 'Active'";

    
    public int getTotalUserProduct() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(COUNT_USER_PRODUCT);
            long millis = System.currentTimeMillis();
            java.sql.Date date = new java.sql.Date(millis);
            ptm.setDate(1, date);
            rs = ptm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
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
        return 0;
    }

    public List<ProductDTO> getUserProductsWithPagging(int page, int PAGE_SIZE) throws SQLException {
        List<ProductDTO> listProduct = new ArrayList<>();
        ProductDTO product = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(USER_PRODUCT_PAGGING);
            long millis = System.currentTimeMillis();
            java.sql.Date date = new java.sql.Date(millis);
            ptm.setDate(1, date);
            ptm.setInt(2, page);
            ptm.setInt(3, PAGE_SIZE);
            ptm.setInt(4, PAGE_SIZE);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String productID = rs.getString("productID");
                String productName = rs.getString("productName");
                String image = rs.getString("image");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                String categoryID = rs.getString("categoryID");
                String importDate = rs.getString("importDate");
                String usingDate = rs.getString("usingDate");
                product = new ProductDTO(productID, productName, image, price, quantity, categoryID, importDate, usingDate);
                listProduct.add(product);
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
        return listProduct;
    }

    public int getTotalAdminProduct() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(COUNT_ADMIN_PRODUCT);
            rs = ptm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
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
        return 0;
    }

    public List<ProductDTO> getAdminProductsWithPagging(int page, int PAGE_SIZE) throws SQLException {
        List<ProductDTO> listProduct = new ArrayList<>();
        ProductDTO product = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(ADMIN_PRODUCT_PAGGING);
            ptm.setInt(1, page);
            ptm.setInt(2, PAGE_SIZE);
            ptm.setInt(3, PAGE_SIZE);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String productID = rs.getString("productID");
                String productName = rs.getString("productName");
                String image = rs.getString("image");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                String categoryID = rs.getString("categoryID");
                String importDate = rs.getString("importDate");
                String usingDate = rs.getString("usingDate");
                String status = rs.getString("status");
                product = new ProductDTO(productID, productName, image, price, quantity, categoryID, importDate, usingDate, status);
                listProduct.add(product);
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
        return listProduct;
    }

    public boolean update(ProductDTO product) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE);
                ptm.setString(1, product.getProductName());
                ptm.setString(2, product.getImage());
                ptm.setDouble(3, product.getPrice());
                ptm.setInt(4, product.getQuantity());
                ptm.setString(5, product.getCategoryID());
                ptm.setString(6, product.getImportDate());
                ptm.setString(7, product.getUsingDate());
                ptm.setString(8, product.getStatus());
                ptm.setString(9, product.getProductID());
                if (ptm.executeUpdate() > 0) {
                    check = true;
                } else {
                    check = false;
                }
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
        }
        return check;
    }

    public ProductDTO getProduct(String productID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        ProductDTO product = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SEARCH_ID);
            ptm.setString(1, productID);
            rs = ptm.executeQuery();
            if (rs.next()) {
                String productName = rs.getString("productName");
                String image = rs.getString("image");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                String categoryID = rs.getString("categoryID");
                String importDate = rs.getString("importDate");
                String usingDate = rs.getString("usingDate");
                String status = rs.getString("status");
                product = new ProductDTO(productID, productName, image, price, quantity, categoryID, importDate, usingDate, status);
            }
        } catch (Exception e) {
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
        return product;
    }

    public boolean delete(String productID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE);
                ptm.setString(1, productID);
                if (ptm.executeUpdate() > 0) {
                    check = true;
                } else {
                    check = false;
                }
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
        }
        return check;
    }

    public boolean create(ProductDTO product) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CREATE);
                ptm.setString(1, product.getProductID());
                ptm.setString(2, product.getProductName());
                ptm.setString(3, product.getImage());
                ptm.setDouble(4, product.getPrice());
                ptm.setInt(5, product.getQuantity());
                ptm.setString(6, product.getCategoryID());
                ptm.setString(7, product.getImportDate());
                ptm.setString(8, product.getUsingDate());
                ptm.setString(9, product.getStatus());
                if (ptm.executeUpdate() > 0) {
                    check = true;
                } else {
                    check = false;
                }
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
        }

        return check;
    }

    public List<ProductDTO> searchUserProduct(String search) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        ProductDTO product = null;
        List<ProductDTO> listProduct = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SEARCH_USER_PRODUCT);

            ptm.setString(1, "%" + search + "%");
            long millis = System.currentTimeMillis();
            java.sql.Date date = new java.sql.Date(millis);
            ptm.setDate(2, date);

            rs = ptm.executeQuery();
            while (rs.next()) {
                String productID = rs.getString("productID");
                String productName = rs.getString("productName");
                String image = rs.getString("image");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                String categoryID = rs.getString("categoryID");
                String importDate = rs.getString("importDate");
                String usingDate = rs.getString("usingDate");
                product = new ProductDTO(productID, productName, image, price, quantity, categoryID, importDate, usingDate);
                listProduct.add(product);
            }
        } catch (Exception e) {
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
        return listProduct;
    }

    public List<ProductDTO> getUserProduct() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        ProductDTO product = null;
        List<ProductDTO> listProduct = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(USER_PRODUCT);
            long millis = System.currentTimeMillis();
            java.sql.Date date = new java.sql.Date(millis);
            ptm.setDate(1, date);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String productID = rs.getString("productID");
                String productName = rs.getString("productName");
                String image = rs.getString("image");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                String categoryID = rs.getString("categoryID");
                String importDate = rs.getString("importDate");
                String usingDate = rs.getString("usingDate");
                product = new ProductDTO(productID, productName, image, price, quantity, categoryID, importDate, usingDate);
                listProduct.add(product);
            }
        } catch (Exception e) {
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
        return listProduct;
    }

    public List<ProductDTO> getAdminProduct() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        ProductDTO product = null;
        List<ProductDTO> listProduct = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(ADMIN_PRODUCT);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String productID = rs.getString("productID");
                String productName = rs.getString("productName");
                String image = rs.getString("image");
                double price = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                String categoryID = rs.getString("categoryID");
                String importDate = rs.getString("importDate");
                String usingDate = rs.getString("usingDate");
                String status = rs.getString("status");
                product = new ProductDTO(productID, productName, image, price, quantity, categoryID, importDate, usingDate, status);
                listProduct.add(product);
            }
        } catch (Exception e) {
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
        return listProduct;
    }

    public ProductDTO checkQuantity(ProductDTO product) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        ProductDTO checkProduct = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(CHECK_QUANTITY);
            ptm.setInt(1, product.getQuantity());
            ptm.setString(2, product.getProductID());
            rs = ptm.executeQuery();
            if (rs.next()) {
                String productID = rs.getString("productID");
                int quantity = rs.getInt("quantity");
                checkProduct = new ProductDTO(productID, quantity);
            }
        } catch (Exception e) {
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
        return checkProduct;
    }
}
