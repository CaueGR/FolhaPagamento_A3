package entities;

public class ColaboradorPadrao extends Colaborador {
    public ColaboradorPadrao(String matricula, String nome, double salarioBase) {
        super(matricula, nome, salarioBase);
    }

    @Override
    public double calcularSalarioFinal() { return salarioBase; }

    @Override
    public String getTipo() { return "Padrão"; }
}