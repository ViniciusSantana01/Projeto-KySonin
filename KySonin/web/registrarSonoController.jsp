<%-- 
  UMC 
  Vinicius Santana, Paulo Ricardo, Juma Siqueira e Matheus Anry
--%>

<%@page import="java.time.Duration"%>
<%@page import="java.time.LocalTime"%>
<%@page import="modelo.Sono" %>
<%@page import="dao.SonoDAO" %>
<%@page contentType="text/html;charset=UTF-8" %>
<%
    // Obtendo os parâmetros enviados pelo formulário
    String nome = request.getParameter("nome");
    String horaDormiu = request.getParameter("horaDormiu");
    String horaAcordou = request.getParameter("horaAcordou");
    String qualidadeSono = request.getParameter("qualidadeSono");
    String anotacao = request.getParameter("anotacao");

    try {
        // Validação básica dos campos obrigatórios
        if (nome == null || nome.trim().isEmpty() || 
            horaDormiu == null || horaDormiu.trim().isEmpty() || 
            horaAcordou == null || horaAcordou.trim().isEmpty() || 
            qualidadeSono == null || qualidadeSono.trim().isEmpty()) {

            // Se algum campo obrigatório estiver vazio, retorna uma mensagem de erro
            request.setAttribute("msg", "Por favor, preencha todos os campos obrigatórios.");
            request.getRequestDispatcher("registrarSono.jsp").forward(request, response);
            return;
        }

        // Convertendo as horas para objetos LocalTime
        LocalTime dormiu = LocalTime.parse(horaDormiu);
        LocalTime acordou = LocalTime.parse(horaAcordou);

        // Se a hora de acordar for antes da hora de dormir, significa que atravessou a meia-noite
        if (acordou.isBefore(dormiu)) {
            // Adiciona 24 horas ao horário de acordar para calcular corretamente
            acordou = acordou.plusHours(24); 
        }

        // Calculando a duração do sono entre a hora de dormir e a hora de acordar
        Duration duracaoSono = Duration.between(dormiu, acordou);
        long minutosDeSono = duracaoSono.toMinutes();

        // Verificando se o intervalo de sono é superior a 10 horas (600 minutos)
        if (minutosDeSono > 600) {
            // Se o intervalo for maior que 10 horas, exibe uma mensagem de erro
            request.setAttribute("msg", "O intervalo de sono não pode ser superior a 10 horas.");
            request.getRequestDispatcher("registrarSono.jsp").forward(request, response);
            return;
        }

        // Criando o objeto Sono com os dados recebidos do formulário
        Sono sono = new Sono(nome, dormiu, acordou, qualidadeSono, anotacao);

        // Salvando o registro de sono no banco de dados
        SonoDAO sonoDAO = new SonoDAO();
        sonoDAO.registrarSono(sono); // Salva o objeto Sono no banco de dados

        // Se o cadastro for bem-sucedido, exibe uma mensagem de sucesso
        request.setAttribute("msg", "Registro de sono realizado com sucesso!");
        
        // Redireciona para a página registrarSono.jsp com a mensagem de sucesso
        request.getRequestDispatcher("registrarSono.jsp").forward(request, response);

    } catch (Exception e) {
        e.printStackTrace(); // Imprime o erro no servidor (opcional)
        
        // Caso ocorra um erro, exibe uma mensagem de erro
        request.setAttribute("msg", "Erro ao registrar sono: " + e.getMessage());
        
        // Redireciona de volta para o formulário com a mensagem de erro
        request.getRequestDispatcher("registrarSono.jsp").forward(request, response);
    }
%>
