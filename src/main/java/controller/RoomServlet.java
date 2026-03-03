package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.RoomDAO;
import model.Room;

@WebServlet("/RoomServlet")
public class RoomServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "list"; // default action
        RoomDAO dao = new RoomDAO();

        try {
            switch (action) {

                // ---------- VIEW ALL ROOMS ----------
                case "list":
                    List<Room> rooms = dao.getAllRooms();
                    request.setAttribute("rooms", rooms);
                    request.getRequestDispatcher("/jsp/viewRooms.jsp").forward(request, response);
                    return; // important to stop execution

                // ---------- LOAD ADD ROOM ----------
                case "add":
                    request.getRequestDispatcher("/jsp/addRoom.jsp").forward(request, response);
                    return;

                // ---------- LOAD EDIT ROOM ----------
                case "edit":
                    String roomType = request.getParameter("room_type");
                    if (roomType == null || roomType.trim().isEmpty()) {
                        response.sendRedirect("RoomServlet?action=list");
                        return;
                    }
                    Room room = dao.getRoomByType(roomType);
                    if (room != null) {
                        request.setAttribute("room", room);
                        request.getRequestDispatcher("/jsp/editRoom.jsp").forward(request, response);
                        return;
                    } else {
                        response.sendRedirect("RoomServlet?action=list");
                        return;
                    }

                // ---------- DEFAULT ----------
                default:
                    response.sendRedirect("RoomServlet?action=list");
                    return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("RoomServlet?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        RoomDAO dao = new RoomDAO();

        try {
            switch (action) {

                // ---------- ADD ROOM ----------
                case "add":
                    String newRoomType = request.getParameter("room_type").trim();
                    double price = Double.parseDouble(request.getParameter("price_per_night"));
                    dao.addRoom(new Room(newRoomType, price));
                    response.sendRedirect("RoomServlet?action=list");
                    return;

                // ---------- UPDATE ROOM ----------
                case "update":
                    String oldRoomType = request.getParameter("old_room_type");
                    String updatedRoomType = request.getParameter("room_type").trim();
                    double updatedPrice = Double.parseDouble(request.getParameter("price_per_night"));
                    dao.updateRoom(new Room(updatedRoomType, updatedPrice), oldRoomType);
                    response.sendRedirect("RoomServlet?action=list");
                    return;

                // ---------- DELETE ROOM ----------
                case "delete":
                    String delRoomType = request.getParameter("room_type");
                    dao.deleteRoom(delRoomType);
                    response.sendRedirect("RoomServlet?action=list");
                    return;

                // ---------- DEFAULT ----------
                default:
                    response.sendRedirect("RoomServlet?action=list");
                    return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("RoomServlet?action=list");
        }
    }
}