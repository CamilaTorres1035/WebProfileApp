package repository.mongo;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.ReplaceOptions;
import model.Profile;
import org.bson.Document;
import repository.IProfileRepository;
import utils.MongoDBConnection;

public class ProfileRepositoryMongo implements IProfileRepository {
    private final MongoCollection<Document> collection;

    public ProfileRepositoryMongo() {
        collection = MongoDBConnection.getDatabase().getCollection("profile");
    }

    @Override
    public Profile getProfile() {
        Document doc = collection.find().first();
        if (doc == null) {
            Profile p = new Profile("Nombre", "Bio...", "Experiencia...", "email@ejemplo.com", "default.jpg", "banner.jpg");
            saveProfile(p);
            return p;
        }
        Profile p = new Profile();
        p.setName(doc.getString("name"));
        p.setBio(doc.getString("bio"));
        p.setExperience(doc.getString("experience"));
        p.setContact(doc.getString("contact"));
        p.setProfilePicture(doc.getString("profilePicture", "default.jpg"));
        p.setBanner(doc.getString("banner", "banner.jpg"));
        return p;
    }

    @Override
    public void saveProfile(Profile profile) {
        Document doc = new Document()
            .append("name", profile.getName())
            .append("bio", profile.getBio())
            .append("experience", profile.getExperience())
            .append("contact", profile.getContact())
            .append("profilePicture", profile.getProfilePicture())
            .append("banner", profile.getBanner());
        collection.replaceOne(new Document(), doc, new ReplaceOptions().upsert(true));
    }
}