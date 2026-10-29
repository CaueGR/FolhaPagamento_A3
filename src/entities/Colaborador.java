package entities;

public abstract class Colaborador {
    protected String matricula;
    protected String nome;
    protected double salarioBase;
    //protected aonde quem esta dentro do pacote consegue acessar.

    public Colaborador(String matricula, String nome, double salarioBase) {
        if (nome == null || nome.trim().isEmpty()) throw new IllegalArgumentException("O nome é obrigatório");
        //trim tira espaço sobrando no inicio e do final das aspas.
        if (salarioBase < 0) throw new IllegalArgumentException("Salário base não pode ser negativo");

        this.matricula = matricula;
        this.nome = nome;
        this.salarioBase = salarioBase;
    }

    //quem vai acessar esses metodos é o service
    public abstract double calcularSalarioFinal();
    public abstract String getTipo();

    public String getMatricula() {
        return matricula;
    }
    public String getNome() {
        return nome;
    }
    public double getSalarioBase() {
        return salarioBase;
    }
}