package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Profile;
import repository.IProfileRepository;
import repository.mongo.ProfileRepositoryMongo;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet(name = "ProfileController", urlPatterns = {"/", "/profile"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 10
)
public class ProfileController extends HttpServlet {
    private IProfileRepository profileRepo = new ProfileRepositoryMongo();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Profile profile = profileRepo.getProfile();
        request.setAttribute("profile", profile);
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
        profile.setName(name);
        profile.setBio(bio);
        profile.setExperience(experience);
        profile.setContact(contact);

        // Subir imagen de perfil
        Part filePart = request.getPart("profilePicture");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadDir = getServletContext().getRealPath("/uploads");
            new File(uploadDir).mkdirs(); // Asegura que exista
            String filePath = uploadDir + File.separator + fileName;
            filePart.write(filePath);
            profile.setProfilePicture(fileName);
        }

        // Subir banner
        Part bannerPart = request.getPart("banner");
        if (bannerPart != null && bannerPart.getSize() > 0) {
            String fileName = Paths.get(bannerPart.getSubmittedFileName()).getFileName().toString();
            String uploadDir = getServletContext().getRealPath("/uploads");
            String filePath = uploadDir + File.separator + fileName;
            bannerPart.write(filePath);
            profile.setBanner(fileName);
        }

        profileRepo.saveProfile(profile);
        response.sendRedirect("edit");
    }
}