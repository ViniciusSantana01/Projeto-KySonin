// UMC
// Vinicius Santana, Paulo Ricardo, Juma Siqueira e Matheus Anry

package modelo;

import java.time.LocalTime;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Sono {
    private int id; // ID do registro de sono
    private String nome;
    private LocalTime horaDormiu;  // Alterado para LocalTime
    private LocalTime horaAcordou; // Alterado para LocalTime
    private String qualidadeSono;
    private String anotacao;
    private String data; // Data de registro
    private String notificacao; // Campo de notificação

    // Construtor
    public Sono(String nome, LocalTime horaDormiu, LocalTime horaAcordou, String qualidadeSono, String anotacao) {
        this.nome = nome;
        this.horaDormiu = horaDormiu;
        this.horaAcordou = horaAcordou;
        this.qualidadeSono = qualidadeSono;
        this.anotacao = anotacao;
        this.data = new SimpleDateFormat("yyyy-MM-dd").format(new Date()); // Pega a data atual
        this.notificacao = gerarNotificacao(qualidadeSono); // Gerar a notificação automaticamente
    }

    // Método para gerar a notificação automaticamente
    private String gerarNotificacao(String qualidadeSono) {
        switch (qualidadeSono.toLowerCase()) {
            case "otimo":
                return "Você teve uma noite excelente de sono! Continue assim!";
            case "moderado":
                return "Seu sono foi moderado. Tente melhorar a qualidade!";
            case "ruim":
                return "Seu sono foi ruim. Busque melhorar seus hábitos de sono!";
            default:
                return "Qualidade de sono não registrada.";
        }
    }

    // Getters e Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public LocalTime getHoraDormiu() {
        return horaDormiu;
    }

    public void setHoraDormiu(LocalTime horaDormiu) {
        this.horaDormiu = horaDormiu;
    }

    public LocalTime getHoraAcordou() {
        return horaAcordou;
    }

    public void setHoraAcordou(LocalTime horaAcordou) {
        this.horaAcordou = horaAcordou;
    }

    public String getQualidadeSono() {
        return qualidadeSono;
    }

    public void setQualidadeSono(String qualidadeSono) {
        this.qualidadeSono = qualidadeSono;
    }

    public String getAnotacao() {
        return anotacao;
    }

    public void setAnotacao(String anotacao) {
        this.anotacao = anotacao;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getNotificacao() {
        return notificacao;
    }

    public void setNotificacao(String notificacao) {
        this.notificacao = notificacao;
    }
}
