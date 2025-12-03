<%-- src/main/webapp/edit.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Perfil</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; max-width: 900px; margin: 0 auto; }
        input, textarea, button { margin: 8px 0; padding: 6px; }
        .form-group { margin-bottom: 15px; }
        .skills-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .skills-table th, .skills-table td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        .error { color: red; font-weight: bold; }
        .section { margin-top: 30px; }
        img.preview { max-width: 200px; margin-top: 10px; }
    </style>
</head>
<body>

<h1>Editar Perfil</h1>

<c:if test="${not empty errorMessage}">
    <p class="error">${errorMessage}</p>
</c:if>

<!-- Formulario de perfil -->
<form method="post" action="${pageContext.request.contextPath}/profile" enctype="multipart/form-data">
    <div class="form-group">
        <label>Nombre:</label>
        <input type="text" name="name" value="${profile.name}">
    </div>

    <div class="form-group">
        <label>Bio:</label>
        <textarea name="bio" rows="3">${profile.bio}</textarea>
    </div>

    <div class="form-group">
        <label>Experiencia:</label>
        <textarea name="experience" rows="3">${profile.experience}</textarea>
    </div>

    <div class="form-group">
        <label>Contacto:</label>
        <input type="text" name="contact" value="${profile.contact}">
    </div>

    <div class="form-group">
        <label>Foto de perfil:</label>
        <input type="file" name="profilePicture" accept="image/*">
        <c:if test="${profile.profilePicture != 'default.png'}">
            <br><img src="${pageContext.request.contextPath}/uploads/${empty profile.profilePicture ? 'default.png' : profile.profilePicture}" class="preview" alt="Foto actual">
        </c:if>
    </div>

    <div class="form-group">
        <label>Banner:</label>
        <input type="file" name="banner" accept="image/*">
        <c:if test="${profile.banner != 'banner.jpeg'}">
            <br><img src="${pageContext.request.contextPath}/uploads/${profile.banner}" class="preview" alt="Banner actual">
        </c:if>
    </div>

    <button type="submit">Guardar Perfil</button>
</form>

<!-- CRUD de habilidades -->
<div class="section">
    <h2>Gestión de Habilidades</h2>

    <!-- Formulario para AGREGAR o EDITAR -->
    <form method="post" action="${pageContext.request.contextPath}/skill">
        <input type="hidden" name="action" value="${skillToEdit != null ? 'update' : 'add'}">
        <c:if test="${skillToEdit != null}">
            <input type="hidden" name="id" value="${skillToEdit.id}">
        </c:if>

        <div class="form-group">
            <label>Nombre de la habilidad:</label>
            <input type="text" name="name" value="${skillToEdit != null ? skillToEdit.name : ''}">
        </div>

        <div class="form-group">
            <label>Nivel (1–100):</label>
            <input type="number" name="level" min="1" max="100"
                    value="${skillToEdit != null ? skillToEdit.level : '50'}">
        </div>

        <button type="submit">
            ${skillToEdit != null ? 'Actualizar' : 'Agregar'} Habilidad
        </button>
        <c:if test="${skillToEdit != null}">
            <a href="${pageContext.request.contextPath}/skill">Cancelar edición</a>
        </c:if>
    </form>

    <!-- Tabla de habilidades -->
    <table class="skills-table">
        <thead>
            <tr>
                <th>Habilidad</th>
                <th>Nivel</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${skills}" var="skill">
                <tr>
                    <td>${skill.name}</td>
                    <td>${skill.level}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/skill?action=edit&id=${skill.id}">Editar</a>
                        |
                        <a href="${pageContext.request.contextPath}/skill?action=delete&id=${skill.id}"
                           onclick="return confirm('¿Eliminar esta habilidad?')">Eliminar</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty skills}">
                <tr>
                    <td colspan="3">No hay habilidades registradas.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<br>
<a href="${pageContext.request.contextPath}/profile">← Ver perfil público</a>

</body>
</html>