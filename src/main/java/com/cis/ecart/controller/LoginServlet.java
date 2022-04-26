package com.cis.ecart.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cis.ecart.dao.UserDao;
import com.cis.ecart.model.User;
import com.cis.ecart.utility.DBConnection;

@WebServlet("/user-login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			String email = request.getParameter("login-email");
			String password = request.getParameter("login-password");

			UserDao udao = new UserDao(DBConnection.createDBConnection());
			User user = udao.userLogin(email, password);
			if (user != null) {
				request.getSession().setAttribute("auth", user);
				HttpSession session = request.getSession();
				session.setAttribute("auth", user);
				System.out.print("user logged in");
				response.sendRedirect("index.jsp");
			} else {
				out.println("there is no user");
			}

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} 

	}
}
