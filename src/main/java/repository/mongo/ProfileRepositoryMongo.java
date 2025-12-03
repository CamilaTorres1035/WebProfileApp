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
        this.collection = MongoDBConnection.getDatabase().getCollection("profile");
    }

    @Override
    public Profile getProfile() {
        Document doc = collection.find().first();
        if (doc == null) {
            // Crear perfil por defecto si no existe
            Profile defaultProfile = new Profile(
                "Programador Web",
                "Biografía por defecto",
                "Experiencia por defecto",
                "contacto@ejemplo.com",
                "default.jpg",
                "banner.jpg"
            );
            saveProfile(defaultProfile);
            return defaultProfile;
        }
        return documentToProfile(doc);
    }

    @Override
    public void saveProfile(Profile profile) {
        Document doc = profileToDocument(profile);
        // Usa upsert para reemplazar el único documento (siempre hay uno solo)
        collection.replaceOne(new Document(), doc, new ReplaceOptions().upsert(true));
    }

    // --- Métodos auxiliares ---

    private Profile documentToProfile(Document doc) {
        Profile p = new Profile();

        // Nombre
        p.setName(doc.getString("name"));
        if (p.getName() == null) p.setName("Programador Web");

        // Bio
        p.setBio(doc.getString("bio"));
        if (p.getBio() == null) p.setBio("Biografía por defecto");

        // Experiencia
        p.setExperience(doc.getString("experience"));
        if (p.getExperience() == null) p.setExperience("Experiencia por defecto");

        // Contacto
        p.setContact(doc.getString("contact"));
        if (p.getContact() == null) p.setContact("contacto@ejemplo.com");

        // Foto de perfil
        Object picObj = doc.get("profilePicture");
        p.setProfilePicture(picObj != null ? picObj.toString() : "default.png");

        // Banner
        Object bannerObj = doc.get("banner");
        p.setBanner(bannerObj != null ? bannerObj.toString() : "banner.jpeg");

        return p;
    }

    private Document profileToDocument(Profile p) {
        return new Document()
            .append("name", p.getName())
            .append("bio", p.getBio())
            .append("experience", p.getExperience())
            .append("contact", p.getContact())
            .append("profilePicture", p.getProfilePicture())
            .append("banner", p.getBanner());
    }

    @Override
    public void deleteProfile() {
        collection.deleteMany(new Document()); // Borra todos los documentos (solo hay uno)
    }
}