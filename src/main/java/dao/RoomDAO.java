package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Room;
import util.DBConnection;

public class RoomDAO {

    // ---------------- GET PRICE ----------------
    public double getPrice(String roomType) {
        double price = 0.0;
        String sql = "SELECT price_per_night FROM rooms WHERE room_type = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, roomType);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    price = rs.getDouble("price_per_night");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return price;
    }

    // ---------------- GET ALL ROOMS ----------------
    public List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms ORDER BY room_type";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Room room = new Room();
                room.setRoomType(rs.getString("room_type"));
                room.setPricePerNight(rs.getDouble("price_per_night"));
                rooms.add(room);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
    }

    // ---------------- GET ALL ROOM TYPES ----------------
    public List<String> getAllRoomTypes() {
        List<String> roomTypes = new ArrayList<>();
        String sql = "SELECT room_type FROM rooms ORDER BY room_type";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                roomTypes.add(rs.getString("room_type"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return roomTypes;
    }

    // ---------------- GET ROOM BY TYPE ----------------
    public Room getRoomByType(String roomType) {
        Room room = null;
        String sql = "SELECT * FROM rooms WHERE room_type = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, roomType);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    room = new Room();
                    room.setRoomType(rs.getString("room_type"));
                    room.setPricePerNight(rs.getDouble("price_per_night"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return room;
    }

    // ---------------- ADD ROOM ----------------
    public boolean addRoom(Room room) {
        String sql = "INSERT INTO rooms (room_type, price_per_night) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, room.getRoomType());
            ps.setDouble(2, room.getPricePerNight());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ---------------- UPDATE ROOM ----------------
    public boolean updateRoom(Room room, String oldRoomType) {
        String sql = "UPDATE rooms SET room_type=?, price_per_night=? WHERE room_type=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, room.getRoomType());
            ps.setDouble(2, room.getPricePerNight());
            ps.setString(3, oldRoomType);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ---------------- DELETE ROOM ----------------
    public boolean deleteRoom(String roomType) {
        String sql = "DELETE FROM rooms WHERE room_type=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, roomType);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}