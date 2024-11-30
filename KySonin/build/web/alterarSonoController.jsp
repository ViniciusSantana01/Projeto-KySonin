<%-- 
  UMC 
  Vinicius Santana, Paulo Ricardo, Juma Siqueira e Matheus Anry
--%>

<%@ page import="modelo.Sono" %>
<%@ page import="dao.SonoDAO" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // Obtendo os parâmetros do formulário de alteração
    String idStr = request.getParameter("id");
    String nome = request.getParameter("nome");
    String horaDormiu = request.getParameter("horaDormiu");
    String horaAcordou = request.getParameter("horaAcordou");
    String qualidadeSono = request.getParameter("qualidadeSono");
    String anotacao = request.getParameter("anotacao");

    try {
        // Validação básica dos campos obrigatórios
        if (idStr == null || idStr.isEmpty() || nome == null || nome.trim().isEmpty() || 
            horaDormiu == null || horaDormiu.trim().isEmpty() || 
            horaAcordou == null || horaAcordou.trim().isEmpty() || 
            qualidadeSono == null || qualidadeSono.trim().isEmpty()) {
            
            // Se algum campo obrigatório estiver vazio, retorna uma mensagem de erro
            request.setAttribute("msg", "Todos os campos devem ser preenchidos.");
            request.getRequestDispatcher("alterarSono.jsp?id=" + idStr).forward(request, response);
            return;
        }

        // Convertendo as horas para objetos LocalTime
        LocalTime dormiu = LocalTime.parse(horaDormiu);
        LocalTime acordou = LocalTime.parse(horaAcordou);

        // Verifica se a hora de dormir é posterior à hora de acordar (atravessando a meia-noite)
        if (dormiu.isAfter(acordou)) {
            // Se a hora de dormir for maior que a hora de acordar (atravessando a meia-noite),
            // adicionamos 24 horas à hora de acordar para calcular corretamente o intervalo.
            acordou = acordou.plusHours(24);
        }

        // Calculando a diferença em horas entre a hora de dormir e a hora de acordar
        long horasDeSono = ChronoUnit.HOURS.between(dormiu, acordou);

        // Verificando se o intervalo de sono é superior a 10 horas
        if (horasDeSono > 10) {
            // Se o intervalo for maior que 10 horas, exibe uma mensagem de erro
            request.setAttribute("msg", "O intervalo de sono não pode ser superior a 10 horas.");
            request.getRequestDispatcher("alterarSono.jsp?id=" + idStr).forward(request, response);
            return;
        }

        // Convertendo o ID para inteiro
        int id = Integer.parseInt(idStr);

        // Criando o objeto Sono com os dados recebidos do formulário
        // Atualizando para usar LocalTime ao invés de String para horaDormiu e horaAcordou
        Sono sono = new Sono(nome, dormiu, acordou, qualidadeSono, anotacao);
        sono.setId(id); // Definindo o ID correto para o objeto Sono

        // Criando uma instância do SonoDAO para atualizar o registro
        SonoDAO sonoDAO = new SonoDAO();

        // Chamando o método alterarSono no DAO para atualizar os dados no banco
        sonoDAO.alterarSono(sono); // O método não retorna um valor, apenas faz a alteração

        // Se a atualização for bem-sucedida, exibe uma mensagem de sucesso
        request.setAttribute("msg", "Sono alterado com sucesso!");

        // Redireciona para a página de listagem após a alteração
        response.sendRedirect("listarSono.jsp");

    } catch (NumberFormatException e) {
        // Tratamento de erro caso a conversão do ID falhe
        request.setAttribute("msg", "Erro ao processar o ID do sono: " + e.getMessage());
        request.getRequestDispatcher("alterarSono.jsp?id=" + idStr).forward(request, response);
    } catch (Exception e) {
        // Caso ocorra outro erro (ex: banco de dados), exibe a mensagem de erro
        request.setAttribute("msg", "Erro ao alterar o sono: " + e.getMessage());
        request.getRequestDispatcher("alterarSono.jsp?id=" + idStr).forward(request, response);
    }
%>
