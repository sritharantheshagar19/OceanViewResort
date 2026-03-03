package model;

import java.sql.Date;

public class Reservation {

    private int reservationId;
    private String guestName;
    private String address;
    private String contactNumber;
    private String roomType;
    private Date checkIn;
    private Date checkOut;
    private double totalBill;
    private int createdBy; // ID of the user who created this reservation
    private String status; // ACTIVE, CANCELLED, COMPLETED

    // ---------------- CONSTRUCTORS ----------------
    public Reservation() {}

    public Reservation(String guestName, String address, String contactNumber, String roomType,
                       Date checkIn, Date checkOut, double totalBill, int createdBy, String status) {
        this.guestName = guestName;
        this.address = address;
        this.contactNumber = contactNumber;
        this.roomType = roomType;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.totalBill = totalBill;
        this.createdBy = createdBy;
        this.status = status;
    }

    // Optional constructor for retrieving from DB (with ID)
    public Reservation(int reservationId, String guestName, String address, String contactNumber, String roomType,
                       Date checkIn, Date checkOut, double totalBill, int createdBy, String status) {
        this.reservationId = reservationId;
        this.guestName = guestName;
        this.address = address;
        this.contactNumber = contactNumber;
        this.roomType = roomType;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.totalBill = totalBill;
        this.createdBy = createdBy;
        this.status = status;
    }

    // ---------------- GETTERS & SETTERS ----------------
    public int getReservationId() { return reservationId; }
    public void setReservationId(int reservationId) { this.reservationId = reservationId; }

    public String getGuestName() { return guestName; }
    public void setGuestName(String guestName) { this.guestName = guestName; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public Date getCheckIn() { return checkIn; }
    public void setCheckIn(Date checkIn) { this.checkIn = checkIn; }

    public Date getCheckOut() { return checkOut; }
    public void setCheckOut(Date checkOut) { this.checkOut = checkOut; }

    public double getTotalBill() { return totalBill; }
    public void setTotalBill(double totalBill) { this.totalBill = totalBill; }

    public int getCreatedBy() { return createdBy; }
    public void setCreatedBy(int createdBy) { this.createdBy = createdBy; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}