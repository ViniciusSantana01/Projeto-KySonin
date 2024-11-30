<%-- 
  UMC 
  Vinicius Santana, Paulo Ricardo, Juma Siqueira e Matheus Anry
--%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Sono</title>
    <link rel="stylesheet" href="CSS/registrar.css">
</head>
<body>
    <div class="container">
        <div class="logo-container">
                <img src="Imagens/Logo.png" alt="KySonin Logo" class="logo">
        <h1>Registrar Sono</h1>

        <!-- Exibindo a mensagem de sucesso ou erro -->
        <% if (request.getAttribute("msg") != null) { %>
            <div class="message <%= request.getAttribute("msg").toString().contains("sucesso") ? "success" : "error" %>">
                <%= request.getAttribute("msg") %>
            </div>
        <% } %>

        <!-- Formulário de registro de sono -->
        <form action="registrarSonoController.jsp" method="POST">
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" required>

            <label for="horaDormiu">Hora que Dormiu:</label>
            <input type="time" id="horaDormiu" name="horaDormiu" required>

            <label for="horaAcordou">Hora que Acordou:</label>
            <input type="time" id="horaAcordou" name="horaAcordou" required>

            <label for="qualidadeSono">Qualidade do Sono:</label>
            <select id="qualidadeSono" name="qualidadeSono">
                <option value="Otimo">Ótimo</option>
                <option value="Moderado">Moderado</option>
                <option value="Ruim">Ruim</option>
            </select>

            <label for="anotacao">Anotação:</label>
            <textarea id="anotacao" name="anotacao" rows="4" cols="50"></textarea>

            <!-- Campo de data será preenchido automaticamente com a data atual -->
            <input type="hidden" name="data" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">

            <input type="submit" value="Registrar">
        </form>

        <!-- Link para voltar à página inicial -->
        <a href="index.jsp" class="back-link">Voltar</a>
    </div>
</body>
</html>
