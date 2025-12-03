package repository;

import model.Profile;

public interface IProfileRepository {
    Profile getProfile();
    void saveProfile(Profile profile);
    void deleteProfile();
    public void resetProfile();
}