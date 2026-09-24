package entities;

public class ColaboradorProducao extends Colaborador {
    private int quantidadeProduzida;
    private double valorPorUnidade;

    public ColaboradorProducao(String matricula, String nome, double salarioBase, int quantidadeProduzida, double valorPorUnidade) {
        super(matricula, nome, salarioBase);
        if (quantidadeProduzida < 0) throw new IllegalArgumentException("Quantidade produzida não pode ser negativa (RN006)");
        if (valorPorUnidade < 0) throw new IllegalArgumentException("Valor por unidade não pode ser negativo (RN007)");

        this.quantidadeProduzida = quantidadeProduzida;
        this.valorPorUnidade = valorPorUnidade;
    }

    @Override
    public double calcularSalarioFinal() {
        return salarioBase + (quantidadeProduzida * valorPorUnidade);
    }

    @Override
    public String getTipo() { return "Produção"; }

    // NOVOS GETTERS ADICIONADOS AQUI:
    public int getQuantidadeProduzida() { return quantidadeProduzida; }
    public double getValorPorUnidade() { return valorPorUnidade; }
}