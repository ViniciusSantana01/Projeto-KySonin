<%-- 
  UMC 
  Vinicius Santana, Paulo Ricardo, Juma Siqueira e Matheus Anry
--%>

<%@page import="java.util.List"%>
<%@ page import="dao.SonoDAO" %>
<%@ page import="modelo.Sono" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // Criando uma instância do DAO para buscar todos os registros
    SonoDAO sonoDAO = new SonoDAO();
    List<Sono> sonos = sonoDAO.listarSonos();  // Método para listar todos os registros

    // Atribuindo a lista de sonos ao request
    request.setAttribute("sonos", sonos);

    // Redirecionando para a página listarSono.jsp
    request.getRequestDispatcher("listarSono.jsp").forward(request, response);
%>
