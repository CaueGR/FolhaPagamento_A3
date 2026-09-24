package service;

import entities.Colaborador;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FolhaPagamentoService {

    public void gerarFolhaDetalhada(List<Colaborador> colaboradores) {
        System.out.println("\n--- RELATÓRIO: FOLHA DE PAGAMENTO DETALHADA ---");
        if(colaboradores.isEmpty()) {
            System.out.println("Nenhum colaborador cadastrado.");
            return;
        }

        for (Colaborador c : colaboradores) {
            double salarioFinal = c.calcularSalarioFinal();
            double adicionais = salarioFinal - c.getSalarioBase();

            System.out.printf("Matrícula: %-5s | Nome: %-15s | Tipo: %-12s | Base: R$ %8.2f | Adicionais: R$ %8.2f | FINAL: R$ %8.2f\n",
                    c.getMatricula(), c.getNome(), c.getTipo(), c.getSalarioBase(), adicionais, salarioFinal);
        }
    }

    public void gerarResumo(List<Colaborador> colaboradores) {
        System.out.println("\n--- RELATÓRIO: RESUMO DA FOLHA ---");
        if(colaboradores.isEmpty()) {
            System.out.println("Nenhum colaborador cadastrado para o resumo.");
            return;
        }

        double totalGeral = 0;
        // O Map vai guardar a Categoria (String) e o Total (Double)
        Map<String, Double> totaisPorCategoria = new HashMap<>();

        for (Colaborador c : colaboradores) {
            double salarioFinal = c.calcularSalarioFinal();
            totalGeral += salarioFinal;

            // Vai buscar o tipo (Padrão, Comissionado, Produção)
            String categoria = c.getTipo();

            // Soma o salário ao total já existente dessa categoria
            totaisPorCategoria.put(categoria, totaisPorCategoria.getOrDefault(categoria, 0.0) + salarioFinal);
        }

        System.out.println("Quantidade de Colaboradores: " + colaboradores.size());
        System.out.printf("Custo Total Geral da Folha: R$ %.2f\n", totalGeral);

        System.out.println("\n--- Total Pago por Categoria ---");
        for (Map.Entry<String, Double> entry : totaisPorCategoria.entrySet()) {
            System.out.printf("Categoria %-12s : R$ %10.2f\n", entry.getKey(), entry.getValue());
        }
    }
}