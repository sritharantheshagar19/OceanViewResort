package controller;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.ReservationDAO;
import dao.RoomDAO;
import model.Reservation;
import model.User;

@WebServlet("/ReservationServlet")
public class ReservationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // ================= GET =================
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        ReservationDAO reservationDao = new ReservationDAO();
        RoomDAO roomDao = new RoomDAO();

        try {
            // -------- VIEW ALL RESERVATIONS --------
            if ("list".equals(action)) {
                List<Reservation> reservationList = reservationDao.getAllReservations();
                request.setAttribute("reservationList", reservationList);
                request.getRequestDispatcher("/jsp/viewReservations.jsp").forward(request, response);
                return;
            }

            // -------- LOAD EDIT PAGE --------
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Reservation reservation = reservationDao.getReservationById(id);

                if (!"ACTIVE".equals(reservation.getStatus())) {
                    response.sendRedirect("ReservationServlet?action=list");
                    return;
                }

                List<String> roomTypeList = roomDao.getAllRoomTypes();
                request.setAttribute("roomTypes", roomTypeList.toArray(new String[0]));
                request.setAttribute("reservation", reservation);
                request.getRequestDispatcher("/jsp/editReservation.jsp").forward(request, response);
                return;
            }

            // -------- DEFAULT → LOAD ADD PAGE --------
            List<String> roomTypeList = roomDao.getAllRoomTypes();
            request.setAttribute("roomTypes", roomTypeList.toArray(new String[0]));
            request.getRequestDispatcher("/jsp/reservation.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================= POST =================
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        ReservationDAO dao = new ReservationDAO();
        RoomDAO roomDao = new RoomDAO();
        LocalDate today = LocalDate.now();

        try {
            // -------- UPDATE STATUS --------
            if ("updateStatus".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String status = request.getParameter("status");
                dao.updateStatus(id, status);
                response.sendRedirect("ReservationServlet?action=list");
                return;
            }

            // -------- ADD RESERVATION --------
            if ("add".equals(action) || "updateBooking".equals(action)) {
                User user = (User) session.getAttribute("currentUser");
                int reservationId = 0;

                if ("updateBooking".equals(action)) {
                    reservationId = Integer.parseInt(request.getParameter("id"));
                }

                String guestName = request.getParameter("guest_name").trim();
                String address = request.getParameter("address").trim();
                String contact = request.getParameter("contact_number").trim();
                String roomType = request.getParameter("room_type");
                LocalDate checkInDate = LocalDate.parse(request.getParameter("check_in"));
                LocalDate checkOutDate = LocalDate.parse(request.getParameter("check_out"));

                // -------- VALIDATION --------
                if (checkInDate.isBefore(today)) {
                    request.setAttribute("error", "Check-in date cannot be before today.");
                    doGet(request, response);
                    return;
                }

                if (!checkOutDate.isAfter(checkInDate)) { // Ensures minimum 1-day stay
                    request.setAttribute("error", "Check-out must be after check-in. Minimum stay is 1 day.");
                    doGet(request, response);
                    return;
                }

                long days = ChronoUnit.DAYS.between(checkInDate, checkOutDate);
                double price = roomDao.getPrice(roomType);
                double totalBill = days * price;

                Date checkIn = Date.valueOf(checkInDate);
                Date checkOut = Date.valueOf(checkOutDate);

                Reservation reservation = new Reservation(
                        guestName, address, contact, roomType,
                        checkIn, checkOut, totalBill,
                        user.getId(), "ACTIVE"
                );

                if ("add".equals(action)) {
                    dao.addReservation(reservation);
                } else { // updateBooking
                    reservation.setReservationId(reservationId);
                    dao.updateReservation(reservation);
                }

                response.sendRedirect("ReservationServlet?action=list");
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred.");
            doGet(request, response);
        }
    }
}