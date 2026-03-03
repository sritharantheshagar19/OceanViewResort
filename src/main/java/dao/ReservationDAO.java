package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Reservation;
import util.DBConnection;

public class ReservationDAO {

    // ---------------- ADD RESERVATION ----------------
    public boolean addReservation(Reservation reservation) {

        String sql = "INSERT INTO reservations "
                   + "(guest_name, address, contact_number, room_type, "
                   + "check_in, check_out, total_bill, created_by, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, reservation.getGuestName());
            ps.setString(2, reservation.getAddress());
            ps.setString(3, reservation.getContactNumber());
            ps.setString(4, reservation.getRoomType());
            ps.setDate(5, reservation.getCheckIn());
            ps.setDate(6, reservation.getCheckOut());
            ps.setDouble(7, reservation.getTotalBill());
            ps.setInt(8, reservation.getCreatedBy());
            ps.setString(9, reservation.getStatus());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ---------------- GET ALL RESERVATIONS ----------------
    public List<Reservation> getAllReservations() {

        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations ORDER BY reservation_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapReservation(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // ---------------- GET BY ID ----------------
    public Reservation getReservationById(int reservationId) {

        String sql = "SELECT * FROM reservations WHERE reservation_id=?";
        Reservation r = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, reservationId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    r = mapReservation(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return r;
    }

    // ---------------- UPDATE BOOKING DETAILS ----------------
    public boolean updateReservation(Reservation reservation) {

        String sql = "UPDATE reservations SET "
                   + "guest_name=?, address=?, contact_number=?, "
                   + "room_type=?, check_in=?, check_out=?, total_bill=? "
                   + "WHERE reservation_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, reservation.getGuestName());
            ps.setString(2, reservation.getAddress());
            ps.setString(3, reservation.getContactNumber());
            ps.setString(4, reservation.getRoomType());
            ps.setDate(5, reservation.getCheckIn());
            ps.setDate(6, reservation.getCheckOut());
            ps.setDouble(7, reservation.getTotalBill());
            ps.setInt(8, reservation.getReservationId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ---------------- UPDATE STATUS ----------------
    public boolean updateStatus(int reservationId, String status) {

        String sql = "UPDATE reservations SET status=? WHERE reservation_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, reservationId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ---------------- DELETE RESERVATION ----------------
    public boolean deleteReservation(int reservationId) {

        String sql = "DELETE FROM reservations WHERE reservation_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, reservationId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ---------------- MAP RESULTSET TO OBJECT ----------------
    private Reservation mapReservation(ResultSet rs) throws SQLException {

        Reservation r = new Reservation();

        r.setReservationId(rs.getInt("reservation_id"));
        r.setGuestName(rs.getString("guest_name"));
        r.setAddress(rs.getString("address"));
        r.setContactNumber(rs.getString("contact_number"));
        r.setRoomType(rs.getString("room_type"));
        r.setCheckIn(rs.getDate("check_in"));
        r.setCheckOut(rs.getDate("check_out"));
        r.setTotalBill(rs.getDouble("total_bill"));
        r.setCreatedBy(rs.getInt("created_by"));
        r.setStatus(rs.getString("status"));

        return r;
    }
}