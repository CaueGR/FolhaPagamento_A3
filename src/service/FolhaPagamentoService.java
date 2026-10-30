package service;

import entities.Colaborador;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FolhaPagamentoService {

    private final CadastroService cadastroService;

    public FolhaPagamentoService(CadastroService cadastroService) {
        this.cadastroService = cadastroService;
    }

    public void gerarFolhaDetalhada(List<Colaborador> colaboradores) {
        System.out.println("\n--- RELATÓRIO: FOLHA DE PAGAMENTO DETALHADA ---");

        if (colaboradores.isEmpty()) {
            System.out.println("Nenhum colaborador cadastrado.");
            return;
        }

        for (Colaborador c : colaboradores) {
            double salarioFinal = c.calcularSalarioFinal();
            double adicionais = salarioFinal - c.getSalarioBase();

            System.out.printf(
                    "Matrícula: %-5s | Nome: %-15s | Tipo: %-12s | Base: R$ %8.2f | Adicionais: R$ %8.2f | FINAL: R$ %8.2f%n",
                    c.getMatricula(),
                    c.getNome(),
                    c.getTipo(),
                    c.getSalarioBase(),
                    adicionais,
                    salarioFinal
            );
        }
    }

    public void gerarResumo(List<Colaborador> colaboradores) {
        System.out.println("\n--- RELATÓRIO: RESUMO DA FOLHA ---");

        if (colaboradores.isEmpty()) {
            System.out.println("Nenhum colaborador cadastrado para o resumo.");
            return;
        }

        double totalGeral = 0;
        Map<String, Double> totaisPorCategoria = new HashMap<>();

        for (Colaborador c : colaboradores) {
            double salarioFinal = c.calcularSalarioFinal();
            totalGeral += salarioFinal;

            String categoria = c.getTipo();

            totaisPorCategoria.put(
                    categoria,
                    totaisPorCategoria.getOrDefault(categoria, 0.0)
                            + salarioFinal
            );
        }

        System.out.println(
                "Quantidade de Colaboradores: " + colaboradores.size()
        );

        System.out.printf(
                "Custo Total Geral da Folha: R$ %.2f%n",
                totalGeral
        );

        System.out.println("\n--- Total Pago por Categoria ---");

        for (Map.Entry<String, Double> entry : totaisPorCategoria.entrySet()) {
            System.out.printf(
                    "Categoria %-12s : R$ %10.2f%n",
                    entry.getKey(),
                    entry.getValue()
            );
        }
    }

    public void gerarFolhaIndividual(String matricula) {
        cadastroService.buscarPorMatricula(matricula).ifPresentOrElse(
                colaborador -> {
                    double salarioFinal =
                            colaborador.calcularSalarioFinal();

                    double adicionais =
                            salarioFinal - colaborador.getSalarioBase();

                    System.out.println("\n--- FOLHA INDIVIDUAL ---");

                    System.out.println(
                            "Matrícula: " + colaborador.getMatricula()
                    );

                    System.out.println(
                            "Nome: " + colaborador.getNome()
                    );

                    System.out.println(
                            "Tipo: " + colaborador.getTipo()
                    );

                    System.out.printf(
                            "Salário Base: R$ %.2f%n",
                            colaborador.getSalarioBase()
                    );

                    System.out.printf(
                            "Adicionais: R$ %.2f%n",
                            adicionais
                    );

                    System.out.printf(
                            "Salário Final: R$ %.2f%n",
                            salarioFinal
                    );
                },
                () -> System.out.println(
                        "[ERRO] Colaborador não encontrado."
                )
        );
    }
}