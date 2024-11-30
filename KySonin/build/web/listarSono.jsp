<%-- 
  UMC 
  Vinicius Santana, Paulo Ricardo, Juma Siqueira e Matheus Anry
--%>

<%@ page import="modelo.Sono"%>
<%@ page import="java.util.List"%>
<%@ page import="dao.SonoDAO"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listar Sonos</title>
    <link rel="stylesheet" href="CSS/listar.css">
</head>
<body>

<div class="container">
    <!-- Cabeçalho com logo e título -->
    <div class="header">
        <h1>Lista de Registros de Sono</h1>
        <img src="Imagens/Logo.png" alt="Logo" class="logo">
    </div>

    <!-- Exibição de mensagem -->
    <% 
        String mensagem = request.getParameter("msg");
        if (mensagem != null && !mensagem.isEmpty()) {
    %>
    <div class="message"><%= mensagem %></div>
    <% } %>

    <!-- Mensagem explicativa -->
    <div class="intro-message">
        <p>Aqui você encontra a lista completa dos registros de sono dos usuários, com detalhes sobre o horário em que dormiram, acordaram, a qualidade do sono e outras informações importantes.</p>
    </div>

    <!-- Verificando se há registros de sono -->
    <% 
        SonoDAO sonoDAO = new SonoDAO();
        List<Sono> sonos = sonoDAO.listarSonos();
        if (sonos.isEmpty()) {
    %>
        <div class="message">Nenhum registro de sono encontrado.</div>
    <% } else { %>

    <!-- Tabela de registros -->
    <table>
        <tr>
            <th>Nome</th>
            <th>Hora Dormiu</th>
            <th>Hora Acordou</th>
            <th>Qualidade Sono</th>
            <th>Anotação</th>
            <th>Notificação</th>
            <th>Data</th>
            <th>Alterar</th>
            <th>Excluir</th>
        </tr>
        <% 
            for (Sono sono : sonos) {
        %>
        <tr>
            <td><%= sono.getNome() %></td>
            <td><%= sono.getHoraDormiu() %></td>
            <td><%= sono.getHoraAcordou() %></td>
            <td><%= sono.getQualidadeSono() %></td>
            <td><%= sono.getAnotacao() %></td>
            <td><%= sono.getNotificacao() %></td>
            <td><%= sono.getData() %></td>
            <td><a href="alterarSono.jsp?id=<%= sono.getId() %>" class="action edit">Alterar</a></td>
            <td>
                <!-- Link direto para o controlador de exclusão -->
                <a href="excluirSonoController.jsp?id=<%= sono.getId() %>" class="action delete">Excluir</a>
            </td>
        </tr>
        <% } %>
    </table>
    <% } %>

    <!-- Botões de ação -->
    <div class="buttons">
        <a href="registrarSono.jsp">Registrar Novo Sono</a>
        <a href="index.jsp">Voltar</a>
    </div>
</div>

</body>
</html>

