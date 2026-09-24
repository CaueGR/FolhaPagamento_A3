package entities;

public class ColaboradorComissionado extends Colaborador {
    private double valorVendas;
    private double percentualComissao;

    public ColaboradorComissionado(String matricula, String nome, double salarioBase, double valorVendas, double percentualComissao) {
        super(matricula, nome, salarioBase);
        if (valorVendas < 0) throw new IllegalArgumentException("Valor de vendas não pode ser negativo (RN004)");
        if (percentualComissao < 0) throw new IllegalArgumentException("Percentual de comissão não pode ser negativo (RN005)");

        this.valorVendas = valorVendas;
        this.percentualComissao = percentualComissao;
    }

    @Override
    public double calcularSalarioFinal() {
        return salarioBase + (valorVendas * (percentualComissao / 100));
    }

    @Override
    public String getTipo() { return "Comissionado"; }

    // NOVOS GETTERS ADICIONADOS AQUI:
    public double getValorVendas() { return valorVendas; }
    public double getPercentualComissao() { return percentualComissao; }
}