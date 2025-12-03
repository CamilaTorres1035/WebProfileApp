package controller;

import com.mongodb.client.MongoCollection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Profile;
import java.util.List;

import model.Skill;
import repository.mongo.SkillRepositoryMongo;
import repository.IProfileRepository;
import repository.mongo.ProfileRepositoryMongo;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import org.bson.Document;
import utils.MongoDBConnection;

@WebServlet(name = "ProfileController", urlPatterns = {"/", "/profile"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class ProfileController extends HttpServlet {

    private IProfileRepository profileRepo = new ProfileRepositoryMongo();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Reinicio total: si se pasa ?resetdb=true, borra perfil y habilidades
        if ("true".equals(request.getParameter("resetdb"))) {
            profileRepo = new ProfileRepositoryMongo();

            // Borra el perfil
            MongoCollection<Document> profileCol = MongoDBConnection.getDatabase().getCollection("profile");
            profileCol.deleteMany(new Document());

            // Borra todas las habilidades
            MongoCollection<Document> skillsCol = MongoDBConnection.getDatabase().getCollection("skills");
            skillsCol.deleteMany(new Document());

            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        Profile profile = profileRepo.getProfile();
        List<Skill> skills = new SkillRepositoryMongo().getAllSkills();

        request.setAttribute("profile", profile);
        request.setAttribute("skills", skills);
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String bio = request.getParameter("bio");
        String experience = request.getParameter("experience");
        String contact = request.getParameter("contact");

        Profile profile = profileRepo.getProfile();
        // Solo actualizar si el parámetro no es null ni vacío
        if (name != null && !name.trim().isEmpty()) {
            profile.setName(name.trim());
        }
        if (bio != null && !bio.trim().isEmpty()) {
            profile.setBio(bio.trim());
        }
        if (experience != null && !experience.trim().isEmpty()) {
            profile.setExperience(experience.trim());
        }
        if (contact != null && !contact.trim().isEmpty()) {
            profile.setContact(contact.trim());
        }

        // Subir foto de perfil
        Part filePart = request.getPart("profilePicture");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadDir = getServletContext().getRealPath("/uploads");
            new File(uploadDir).mkdirs();
            filePart.write(uploadDir + File.separator + fileName);
            profile.setProfilePicture(fileName);
        }

        // banner
        String bannerColor = request.getParameter("bannerColor");
        if (bannerColor != null && !bannerColor.trim().isEmpty()) {
            profile.setBannerColor(bannerColor.trim());
        }

        profileRepo.saveProfile(profile);
        System.out.println("Perfil guardado: " + profile.getName() + " | Banner: " + profile.getBannerColor());
        response.sendRedirect(request.getContextPath() + "/skill");
    }
}
