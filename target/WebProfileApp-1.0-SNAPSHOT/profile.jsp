<%-- src/main/webapp/profile.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Perfil - Programador Web</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; }
        .banner { 
            width: 100%; 
            height: 200px; 
            background: #ddd url('${pageContext.request.contextPath}/uploads/${profile.banner}') center/cover no-repeat; 
        }
        .container { padding: 20px; max-width: 800px; margin: 0 auto; }
        .profile-pic { width: 120px; height: 120px; border-radius: 50%; object-fit: cover; }
        .skills { margin-top: 20px; }
        .skill { background: #f0f0f0; padding: 8px; margin: 5px 0; border-radius: 4px; }
    </style>
</head>
<body>

<div class="banner"></div>

<div class="container">
    <img src="${pageContext.request.contextPath}/uploads/${profile.profilePicture}" 
            alt="Foto de perfil" class="profile-pic">

    <h1>${profile.name}</h1>
    <p><strong>Bio:</strong> ${profile.bio}</p>
    <p><strong>Experiencia:</strong> ${profile.experience}</p>
    <p><strong>Contacto:</strong> ${profile.contact}</p>

    <div class="skills">
        <h2>Habilidades</h2>
        <c:forEach items="${skills}" var="skill">
            <div class="skill">
                ${skill.name} — Nivel: ${skill.level}
            </div>
        </c:forEach>
        <c:if test="${empty skills}">
            <p>No hay habilidades registradas.</p>
        </c:if>
    </div>

    <br>
    <a href="${pageContext.request.contextPath}/edit.jsp">✎ Editar perfil</a>
</div>

</body>
</html>