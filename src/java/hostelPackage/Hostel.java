/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package hostelPackage;

/**
 *
 * @author talha
 */
public class Hostel {

    private int hostel_id;
    private String hostel_name;
    private String hostel_address;
    private String hostel_rent;
    private String hostel_contact;
    private String hostel_image;
    private String hostel_location_url;

    public Hostel() {
    }

    public Hostel(int hostel_id, String hostel_name, String hostel_address, String hostel_rent, String hostel_contact, String hostel_image, String hostel_location_url) {
        this.hostel_id = hostel_id;
        this.hostel_name = hostel_name;
        this.hostel_address = hostel_address;
        this.hostel_rent = hostel_rent;
        this.hostel_contact = hostel_contact;
        this.hostel_image = hostel_image;
        this.hostel_location_url = hostel_location_url;
    }

    public int getHostel_id() {
        return hostel_id;
    }

    public void setHostel_id(int hostel_id) {
        this.hostel_id = hostel_id;
    }

    public String getHostel_name() {
        return hostel_name;
    }

    public void setHostel_name(String hostel_name) {
        this.hostel_name = hostel_name;
    }

    public String getHostel_address() {
        return hostel_address;
    }

    public void setHostel_address(String hostel_address) {
        this.hostel_address = hostel_address;
    }

    public String getHostel_rent() {
        return hostel_rent;
    }

    public void setHostel_rent(String hostel_rent) {
        this.hostel_rent = hostel_rent;
    }

    public String getHostel_contact() {
        return hostel_contact;
    }

    public void setHostel_contact(String hostel_contact) {
        this.hostel_contact = hostel_contact;
    }

    public String getHostel_image() {
        return hostel_image;
    }

    public void setHostel_image(String hostel_image) {
        this.hostel_image = hostel_image;
    }

    public String getHostel_location_url() {
        return hostel_location_url;
    }

    public void setHostel_location_url(String hostel_location_url) {
        this.hostel_location_url = hostel_location_url;
    }

}
