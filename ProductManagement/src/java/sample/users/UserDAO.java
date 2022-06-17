/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import sample.utils.DBUtils;

/**
 *
 * @author light
 */
public class UserDAO {
    
    private static final String LOGIN = "SELECT fullName, roleID, address, birthday, phone, email, status FROM tblUsers WHERE userID = ? and password = ?";
    private static final String CHECK_USER_ID = "SELECT userID FROM tblUsers WHERE userID = ?";

    
    public boolean checkUserID(String userID) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(CHECK_USER_ID);
            ptm.setString(1, userID);
            rs = ptm.executeQuery();
            if(rs.next())
                check = true;
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
        return check;
    }
        
    public UserDTO checkLogin(String userID, String password) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(LOGIN);
            ptm.setString(1, userID);
            ptm.setString(2, password);
            rs = ptm.executeQuery();
            if(rs.next()) {
                String fullName = rs.getString("fullName");
                String roleID = rs.getString("roleID");
                String address = rs.getString("address");
                String birthday = rs.getString("birthday");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                String status = rs.getString("status");
                user = new UserDTO(userID, fullName, password, roleID, address, birthday, phone, email, status);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(conn != null) conn.close();
            if(ptm != null) ptm.close();
            if(rs != null) rs.close();
        }
        return user;
    }
}
