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
    <!-- Cabe�alho com logo e t�tulo -->
    <div class="header">
        <h1>Lista de Registros de Sono</h1>
        <img src="Imagens/Logo.png" alt="Logo" class="logo">
    </div>

    <!-- Exibi��o de mensagem -->
    <% 
        String mensagem = request.getParameter("msg");
        if (mensagem != null && !mensagem.isEmpty()) {
    %>
    <div class="message"><%= mensagem %></div>
    <% } %>

    <!-- Mensagem explicativa -->
    <div class="intro-message">
        <p>Aqui voc� encontra a lista completa dos registros de sono dos usu�rios, com detalhes sobre o hor�rio em que dormiram, acordaram, a qualidade do sono e outras informa��es importantes.</p>
    </div>

    <!-- Verificando se h� registros de sono -->
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
            <th>Anota��o</th>
            <th>Notifica��o</th>
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
                <!-- Link direto para o controlador de exclus�o -->
                <a href="excluirSonoController.jsp?id=<%= sono.getId() %>" class="action delete">Excluir</a>
            </td>
        </tr>
        <% } %>
    </table>
    <% } %>

    <!-- Bot�es de a��o -->
    <div class="buttons">
        <a href="registrarSono.jsp">Registrar Novo Sono</a>
        <a href="index.jsp">Voltar</a>
    </div>
</div>

</body>
</html>

