// UMC
// Vinicius Santana, Paulo Ricardo, Juma Siqueira e Matheus Anry

package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConectaBD {

    // Método para obter a conexão com o banco de dados
    public static Connection getConnection() throws SQLException {
        Connection con = null;
        try {
            // Registra o driver JDBC (opcional em versões mais recentes do MySQL Connector/J)
            Class.forName("com.mysql.cj.jdbc.Driver");

            // URL de conexão com o banco de dados
            String url = "jdbc:mysql://localhost:3306/controlesoninho";  // Verifique se o nome do banco está correto
            String user = "root";  // Usuário do banco de dados
            String password = "";  // Senha (deixe em branco se não houver senha)

            // Estabelecendo a conexão com o banco
            con = DriverManager.getConnection(url, user, password);
            System.out.println("Conexão com o banco de dados estabelecida com sucesso!");

        } catch (ClassNotFoundException e) {
            // Em caso de erro ao carregar o driver
            System.out.println("Erro ao carregar o driver JDBC: " + e.getMessage());
            throw new SQLException("Erro ao carregar o driver JDBC", e);
        } catch (SQLException e) {
            // Em caso de erro na conexão
            System.out.println("Erro ao conectar ao banco de dados: " + e.getMessage());
            throw new SQLException("Erro ao conectar ao banco de dados", e);
        }
        return con;
    }
}