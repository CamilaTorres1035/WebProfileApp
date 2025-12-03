package model;

public class Profile {
    private String name;
    private String bio;
    private String experience;
    private String contact;
    private String profilePicture;  // nombre del archivo (ej. "foto.jpg")
    private String banner;          // nombre del archivo del banner (ej. "banner.jpeg")

    // Constructor vacío (requerido para Gson si decides usar JSON después)
    public Profile() {}

    // Constructor completo
    public Profile(String name, String bio, String experience, String contact, String profilePicture, String banner) {
        this.name = name;
        this.bio = bio;
        this.experience = experience;
        this.contact = contact;
        this.profilePicture = profilePicture;
        this.banner = banner;
    }

    // Getters
    public String getName() {
        return name;
    }

    public String getBio() {
        return bio;
    }

    public String getExperience() {
        return experience;
    }

    public String getContact() {
        return contact;
    }

    public String getProfilePicture() {
        return profilePicture;
    }

    public String getBanner() {
        return banner;
    }

    // Setters
    public void setName(String name) {
        this.name = name;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public void setExperience(String experience) {
        this.experience = experience;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }

    public void setBanner(String banner) {
        this.banner = banner;
    }
}