package model;

public class Profile {
    private String name;
    private String bio;
    private String experience;
    private String contact;
    private String profilePicture;
    private String banner;
    void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }

    public String getBanner() {
        return banner;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getExperience() {
        return experience;
    }

    public void setExperience(String experience) {
        this.experience = experience;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getProfilePicture() {
        return profilePicture;
    }
    public void setBanner(String banner) {
        this.banner = banner;
    }

    // Constructor
    public Profile() {}

    public Profile(String name, String bio, String experience, String contact, String profilePicture, String banner) {
        this.name = name;
        this.bio = bio;
        this.experience = experience;
        this.contact = contact;
        this.profilePicture = profilePicture;
        this.banner = banner;
    }
}