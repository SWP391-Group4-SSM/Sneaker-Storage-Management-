/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="ListUsersServlet", urlPatterns={"/listusers"})
public class ListUsersServlet extends HttpServlet {
   
 
 

  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        UserDAO u = new UserDAO();
        List<User> listusers=u.getAll();
        request.setAttribute("data", listusers);
        request.getRequestDispatcher ("view/listusers.jsp"). forward (request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
      
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
