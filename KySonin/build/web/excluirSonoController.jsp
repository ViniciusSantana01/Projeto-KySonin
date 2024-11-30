<%-- 
  UMC 
  Vinicius Santana, Paulo Ricardo, Juma Siqueira e Matheus Anry
--%>

<%@ page import="dao.SonoDAO" %>
<%@ page import="modelo.Sono" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String idParam = request.getParameter("id");

    if (idParam != null && !idParam.isEmpty()) {
        try {
            // Converte o ID para inteiro
            int id = Integer.parseInt(idParam);

            // Instancia o DAO para acessar o banco de dados
            SonoDAO sonoDAO = new SonoDAO();
            // Chama o método para excluir o registro
            sonoDAO.excluirSono(id);

            // Mensagem de sucesso
            request.setAttribute("msg", "Registro de sono excluido com sucesso!");
        } catch (NumberFormatException e) {
            // Erro ao converter o ID
            request.setAttribute("msg", "Erro: ID inválido fornecido.");
        } catch (Exception e) {
            // Erro ao excluir o registro
            request.setAttribute("msg", "Erro ao excluir o registro de sono: " + e.getMessage());
        }
    } else {
        // Caso o ID não seja fornecido
        request.setAttribute("msg", "Erro: ID do registro de sono não fornecido.");
    }

    // Redireciona para a listagem com a mensagem via URL (exibe na página)
    response.sendRedirect("listarSono.jsp?msg=" + request.getAttribute("msg"));
%>

