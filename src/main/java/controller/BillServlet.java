package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ReservationDAO;
import model.Reservation;

@WebServlet("/BillServlet")
public class BillServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ReservationDAO dao = new ReservationDAO();
            Reservation reservation = dao.getReservationById(id);

            if (reservation == null) {
                response.getWriter().println("Reservation not found.");
                return;
            }

            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("/jsp/invoice.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error generating invoice.");
        }
    }
}