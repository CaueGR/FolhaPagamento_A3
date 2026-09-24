package entities;

public abstract class Colaborador {
    // Mantém-se protected (perfeito para a herança)
    protected String matricula;
    protected String nome;
    protected double salarioBase;

    // Construtor tem de ser public
    public Colaborador(String matricula, String nome, double salarioBase) {
        if (nome == null || nome.trim().isEmpty()) throw new IllegalArgumentException("O nome é obrigatório");
        if (salarioBase < 0) throw new IllegalArgumentException("Salário base não pode ser negativo");

        this.matricula = matricula;
        this.nome = nome;
        this.salarioBase = salarioBase;
    }

    // Os métodos têm de ser public para os Services conseguirem aceder
    public abstract double calcularSalarioFinal();
    public abstract String getTipo();

    public String getMatricula() { return matricula; }
    public String getNome() { return nome; }
    public double getSalarioBase() { return salarioBase; }
}