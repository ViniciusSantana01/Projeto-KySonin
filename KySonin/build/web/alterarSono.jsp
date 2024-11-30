<%-- 
  UMC 
  Vinicius Santana, Paulo Ricardo, Juma Siqueira e Matheus Anry
--%>

<%@ page import="java.util.List"%>
<%@ page import="modelo.Sono" %>
<%@ page import="dao.SonoDAO" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // Obtendo o ID do sono a ser alterado, passado como parâmetro na URL
    String idStr = request.getParameter("id");
    int id = 0;
    if (idStr != null && !idStr.isEmpty()) {
        id = Integer.parseInt(idStr); // Convertendo o ID para inteiro
    }

    // Criando uma instância do DAO para buscar os dados do sono a ser alterado
    SonoDAO sonoDAO = new SonoDAO();
    Sono sono = null;
    
    try {
        // Buscando o sono no banco pelo ID
        List<Sono> sonos = sonoDAO.listarSonos();  // Método para listar todos os registros
        for (Sono s : sonos) {
            if (s.getId() == id) {
                sono = s;  // Encontrando o sono correto
                break;
            }
        }
    } catch (Exception e) {
        request.setAttribute("msg", "Erro ao carregar o sono: " + e.getMessage());
        request.getRequestDispatcher("listarSono.jsp").forward(request, response);
        return;
    }
    
    if (sono == null) {
        request.setAttribute("msg", "Registro de sono não encontrado.");
        request.getRequestDispatcher("listarSono.jsp").forward(request, response);
        return;
    }
%>

<%-- Exibindo mensagens de erro ou sucesso --%>
<% if (request.getAttribute("msg") != null) { %>
    <div class="alert">
        <%= request.getAttribute("msg") %>
    </div>
<% } %>

<!-- Formulário de alteração -->
<div class="container">
    <div class="header">
        <h1>Alterar Registro de Sono</h1>
        <link rel="stylesheet" href="CSS/alterar.css">
        <img src="Imagens/Logo.png" alt="Logo" class="logo">
    </div>

    <form action="alterarSonoController.jsp" method="post">
        <!-- Passando o ID do sono para o controller -->
        <input type="hidden" name="id" value="<%= sono.getId() %>" />
        
        <label for="nome">Nome:</label>
        <input type="text" name="nome" value="<%= sono.getNome() %>" readonly /><br>
        
        <label for="horaDormiu">Hora que Dormiu:</label>
        <input type="time" name="horaDormiu" value="<%= sono.getHoraDormiu() %>" required /><br>
        
        <label for="horaAcordou">Hora que Acordou:</label>
        <input type="time" name="horaAcordou" value="<%= sono.getHoraAcordou() %>" required /><br>
        
        <label for="qualidadeSono">Qualidade do Sono:</label>
        <select name="qualidadeSono" required>
            <option <%= (sono.getQualidadeSono().equals("Otimo")) ? "selected" : "" %> >Otimo</option>
            <option <%= (sono.getQualidadeSono().equals("Moderado")) ? "selected" : "" %> >Moderado</option>
            <option <%= (sono.getQualidadeSono().equals("Ruim")) ? "selected" : "" %> >Ruim</option>
        </select><br>
        
        <label for="anotacao">Anotação:</label>
        <textarea name="anotacao"><%= sono.getAnotacao() %></textarea><br>
        
        <input type="submit" value="Alterar Sono" />
    </form>

    <div class="buttons">
        <a href="listarSono.jsp">Voltar para a Listagem de Sonos</a>
    </div>
</div>

