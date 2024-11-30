// UMC
// Vinicius Santana, Paulo Ricardo, Juma Siqueira e Matheus Anry

package dao;

import modelo.Sono;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SonoDAO {
    // Método para registrar um novo sono no banco de dados
    public void registrarSono(Sono sono) throws SQLException {
        String query = "INSERT INTO sono (nome, hora_dormiu, hora_acordou, qualidade_sono, anotacao, data, notificacao) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConectaBD.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, sono.getNome());

            // Converte LocalTime para java.sql.Time para salvar no banco de dados
            stmt.setTime(2, java.sql.Time.valueOf(sono.getHoraDormiu()));  // hora_dormiu
            stmt.setTime(3, java.sql.Time.valueOf(sono.getHoraAcordou())); // hora_acordou

            stmt.setString(4, sono.getQualidadeSono());
            stmt.setString(5, sono.getAnotacao());
            stmt.setString(6, sono.getData());
            stmt.setString(7, sono.getNotificacao());

            // Executa a inserção no banco de dados
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Erro ao registrar o sono: " + e.getMessage(), e);
        }
    }

    // Método para listar todos os registros de sono do banco de dados
    public List<Sono> listarSonos() {
        List<Sono> sonos = new ArrayList<>();
        String query = "SELECT * FROM sono";
        try (Connection conn = ConectaBD.getConnection(); 
             Statement stmt = conn.createStatement(); 
             ResultSet rs = stmt.executeQuery(query)) {
            // Percorre os resultados e adiciona na lista de sonos
            while (rs.next()) {
                Sono sono = new Sono(
                    rs.getString("nome"),
                    rs.getTime("hora_dormiu").toLocalTime(),  // Convertendo de TIME para LocalTime
                    rs.getTime("hora_acordou").toLocalTime(),  // Convertendo de TIME para LocalTime
                    rs.getString("qualidade_sono"),
                    rs.getString("anotacao")
                );
                sono.setData(rs.getString("data"));
                sono.setNotificacao(rs.getString("notificacao"));
                sono.setId(rs.getInt("id")); // Agora estamos pegando o ID do banco de dados
                sonos.add(sono);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Logando erro para o desenvolvedor
        }
        return sonos;
    }

    // Método para excluir um registro de sono pelo ID
    public void excluirSono(int id) throws SQLException {
        String query = "DELETE FROM sono WHERE id = ?";
        try (Connection conn = ConectaBD.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id); // Define o ID como parâmetro para excluir o sono
            stmt.executeUpdate(); // Executa a exclusão no banco
        } catch (SQLException e) {
            throw new SQLException("Erro ao excluir o sono: " + e.getMessage(), e);
        }
    }

    // Método para alterar um registro de sono no banco de dados
    public void alterarSono(Sono sono) throws SQLException {
        String query = "UPDATE sono SET hora_dormiu = ?, hora_acordou = ?, qualidade_sono = ?, anotacao = ?, data = ?, notificacao = ? WHERE id = ?";
        try (Connection conn = ConectaBD.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            // Define os parâmetros para a atualização
            stmt.setTime(1, java.sql.Time.valueOf(sono.getHoraDormiu()));  // Convertendo LocalTime para Time
            stmt.setTime(2, java.sql.Time.valueOf(sono.getHoraAcordou())); // Convertendo LocalTime para Time
            stmt.setString(3, sono.getQualidadeSono());
            stmt.setString(4, sono.getAnotacao());
            stmt.setString(5, sono.getData());
            stmt.setString(6, sono.getNotificacao());
            stmt.setInt(7, sono.getId()); // Usando ID para garantir que alteramos o registro correto

            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Erro ao alterar o sono: " + e.getMessage(), e);
        }
    }
}


