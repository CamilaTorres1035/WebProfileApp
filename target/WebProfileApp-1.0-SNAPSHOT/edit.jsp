<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
      crossorigin="anonymous"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css" />
    
    <style>
        :root {
            --banner-color: ${profile.bannerColor};
        }

        #hero {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7));
            background-color: var(--banner-color);
            min-height: 60vh;
            display: flex;
            align-items: center;
            position: relative;
        }
    </style>
    
    <title>Editar Perfil</title>
</head>
<body class="bg-light d-flex flex-column min-vh-100">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
      <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/">MiPortafolio</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
          <ul class="navbar-nav gap-3">
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/">← Ver Perfil</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Hero / Banner -->
    <header id="hero">
      <div class="container text-center text-white h-100 d-flex flex-column justify-content-center">
        <h1 class="display-4 fw-bold">${profile.name}</h1>
        <p class="lead fs-4">Developer</p>
      </div>
    </header>

    <div class="container mt-4">
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Formulario de Perfil -->
        <div class="card shadow-sm mb-5">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">Editar Información Personal</h4>
            </div>
            <div class="card-body">
                <form method="post" action="${pageContext.request.contextPath}/profile" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-md-4 text-center mb-4">
                            <img
                              src="${pageContext.request.contextPath}/uploads/${empty profile.profilePicture ? 'default.jpg' : profile.profilePicture}"
                              alt="Foto de Perfil"
                              class="rounded-circle profile-img mb-3"
                            />
                            <div class="mt-2">
                                <label for="profilePicture" class="form-label">Cambiar foto</label>
                                <input type="file" class="form-control form-control-sm" id="profilePicture" name="profilePicture" accept="image/*">
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="mb-3">
                                <label for="name" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="name" name="name" value="${profile.name}" placeholder="Tu nombre">
                            </div>
                            <div class="mb-3">
                                <label for="bio" class="form-label">Biografía</label>
                                <textarea class="form-control" id="bio" name="bio" rows="2">${profile.bio}</textarea>
                            </div>
                            <div class="mb-3">
                                <label for="experience" class="form-label">Experiencia</label>
                                <textarea class="form-control" id="experience" name="experience" rows="2">${profile.experience}</textarea>
                            </div>
                            <div class="mb-3">
                                <label for="contact" class="form-label">Contacto (email)</label>
                                <input type="text" class="form-control" id="contact" name="contact" value="${profile.contact}" placeholder="tu@email.com">
                            </div>
                            <div class="mb-3">
                                <label for="bannerColor" class="form-label">Color del banner</label>
                                <input type="color" class="form-control form-control-color" 
                                       id="bannerColor" name="bannerColor" 
                                       value="${profile.bannerColor}" title="Elige un color">
                            </div>
                            <button type="submit" class="btn btn-primary">Guardar Perfil</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Gestión de Habilidades -->
        <div class="card shadow-sm">
            <div class="card-header bg-success text-white">
                <h4 class="mb-0">Gestión de Habilidades</h4>
            </div>
            <div class="card-body">
                <!-- Formulario agregar/editar -->
                <form method="post" action="${pageContext.request.contextPath}/edit" class="row mb-4 g-3">
                    <input type="hidden" name="action" value="${skillToEdit != null ? 'update' : 'add'}">
                    <c:if test="${skillToEdit != null}">
                        <input type="hidden" name="id" value="${skillToEdit.id}">
                    </c:if>

                    <div class="col-md-5">
                        <label class="form-label">Nombre de la habilidad</label>
                        <input type="text" class="form-control" name="name" value="${skillToEdit != null ? skillToEdit.name : ''}" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Nivel (1–100)</label>
                        <input type="number" class="form-control" name="level" min="1" max="100" 
                               value="${skillToEdit != null ? skillToEdit.level : '50'}" required>
                    </div>
                    <div class="col-md-3 d-flex align-items-end">
                        <button type="submit" class="btn ${skillToEdit != null ? 'btn-warning' : 'btn-success'} w-100">
                            ${skillToEdit != null ? 'Actualizar' : 'Agregar'}
                        </button>
                    </div>
                </form>

                <!-- Lista de habilidades -->
                <div class="row g-4 justify-content-center">
                    <c:forEach items="${skills}" var="skill">
                        <div class="col-6 col-md-3">
                            <div class="card h-100 border-0 shadow-sm skill-card text-center py-4">
                                <div class="card-body">
                                    <h5 class="card-title fw-bold">${skill.name}</h5>
                                    <p class="text-muted mb-2">${skill.level}/100</p>
                                    <div class="d-flex justify-content-center gap-2">
                                        <a href="${pageContext.request.contextPath}/edit?action=edit&id=${skill.id}" 
                                           class="btn btn-sm btn-outline-primary">Editar</a>
                                        <form action="${pageContext.request.contextPath}/edit" method="post" style="display:inline;" 
      onsubmit="return confirm('¿Eliminar esta habilidad?')">
  <input type="hidden" name="action" value="delete">
  <input type="hidden" name="id" value="${skill.id}">
  <button type="submit" class="btn btn-sm btn-outline-danger">Borrar</button>
</form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty skills}">
                        <div class="col-12 text-center text-muted">
                            <p>No hay habilidades registradas.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-auto">
      <div class="container text-center">
        <p class="mb-2">
          Contacto:
          <a href="mailto:${profile.contact}" class="text-white text-decoration-underline">
            ${profile.contact}
          </a>
        </p>
        <small class="text-white-50">&copy; 2025 Mi Perfil Profesional</small>
      </div>
    </footer>

    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
      crossorigin="anonymous"
    ></script>
</body>
</html>