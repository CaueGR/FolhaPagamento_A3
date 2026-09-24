import dto.ColaboradorDTO;
import entities.Colaborador;
import repository.ColaboradorRepository;
import service.CadastroService;
import service.FolhaPagamentoService;

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        // Inicializando o ecossistema (Injeção de Dependências manual)
        ColaboradorRepository repository = new ColaboradorRepository();
        CadastroService cadastroService = new CadastroService(repository);
        FolhaPagamentoService folhaService = new FolhaPagamentoService();

        Scanner scanner = new Scanner(System.in);
        int opcao = -1;

        while (opcao != 0) {
            System.out.println("\n==================================");
            System.out.println("   SISTEMA DE FOLHA DE PAGAMENTO  ");
            System.out.println("==================================");
            System.out.println("1. Cadastrar Colaborador");
            System.out.println("2. Consultar Colaboradores");
            System.out.println("3. Excluir Colaborador");
            System.out.println("4. Gerar Folha Detalhada");
            System.out.println("5. Emitir Resumo da Folha");
            System.out.println("6. Editar Colaborador");
            System.out.println("0. Sair");
            System.out.print("Escolha uma opção: ");

            try {
                opcao = scanner.nextInt();
                scanner.nextLine(); // Limpa o buffer
            } catch (Exception e) {
                System.out.println("[ERRO] Digite apenas números.");
                scanner.nextLine();
                continue;
            }

            try {
                switch (opcao) {
                    case 1:
                        System.out.println("Tipo (1-Padrão, 2-Comissionado, 3-Produção): ");
                        int tipo = scanner.nextInt();
                        scanner.nextLine();

                        System.out.print("Matrícula: ");
                        String matricula = scanner.nextLine();
                        System.out.print("Nome: ");
                        String nome = scanner.nextLine();
                        System.out.print("Salário Base: R$ ");
                        double salarioBase = scanner.nextDouble();

                        double valorVendas = 0, percentual = 0, valorUnidade = 0;
                        int qtd = 0;

                        if (tipo == 2) {
                            System.out.print("Valor das Vendas: R$ ");
                            valorVendas = scanner.nextDouble();
                            System.out.print("Percentual de Comissão (%): ");
                            percentual = scanner.nextDouble();
                        } else if (tipo == 3) {
                            System.out.print("Quantidade Produzida: ");
                            qtd = scanner.nextInt();
                            System.out.print("Valor por Unidade: R$ ");
                            valorUnidade = scanner.nextDouble();
                        }

                        // Encapsula tudo no DTO e envia para a camada de Serviço
                        ColaboradorDTO dto = new ColaboradorDTO(tipo, matricula, nome, salarioBase, valorVendas, percentual, qtd, valorUnidade);
                        cadastroService.cadastrar(dto);
                        break;

                    case 2:
                        System.out.println("\n--- LISTA DE COLABORADORES ---");
                        for (Colaborador c : cadastroService.listarTodos()) {
                            System.out.printf("Matrícula: %s | Nome: %s | Tipo: %s\n", c.getMatricula(), c.getNome(), c.getTipo());
                        }
                        break;

                    case 3:
                        System.out.print("Matrícula a ser excluída: ");
                        String matExc = scanner.nextLine();
                        if(cadastroService.excluir(matExc)) {
                            System.out.println("[OK] Colaborador removido.");
                        } else {
                            System.out.println("[ERRO] Matrícula não encontrada.");
                        }
                        break;

                    case 4:
                        folhaService.gerarFolhaDetalhada(cadastroService.listarTodos());
                        break;

                    case 5:
                        folhaService.gerarResumo(cadastroService.listarTodos());
                        break;
                    case 6:
                        System.out.print("Digite a Matrícula do colaborador que deseja editar: ");
                        String matEdit = scanner.nextLine();

                        // Verifica se existe antes de pedir os dados
                        if (cadastroService.buscarPorMatricula(matEdit).isEmpty()) {
                            System.out.println("[ERRO] Colaborador não encontrado.");
                            break;
                        }

                        System.out.println("Qual será o NOVO tipo? (1-Padrão, 2-Comissionado, 3-Produção): ");
                        int novoTipo = scanner.nextInt();
                        scanner.nextLine();

                        System.out.print("Novo Nome: ");
                        String novoNome = scanner.nextLine();
                        System.out.print("Novo Salário Base: R$ ");
                        double novoSalarioBase = scanner.nextDouble();

                        double novasVendas = 0, novoPercentual = 0, novoValorUnidade = 0;
                        int novaQtd = 0;

                        if (novoTipo == 2) {
                            System.out.print("Novo Valor das Vendas: R$ ");
                            novasVendas = scanner.nextDouble();
                            System.out.print("Novo Percentual de Comissão (%): ");
                            novoPercentual = scanner.nextDouble();
                        } else if (novoTipo == 3) {
                            System.out.print("Nova Quantidade Produzida: ");
                            novaQtd = scanner.nextInt();
                            System.out.print("Novo Valor por Unidade: R$ ");
                            novoValorUnidade = scanner.nextDouble();
                        }

                        // A matrícula permanece a mesma (matEdit), os outros dados são novos
                        ColaboradorDTO dtoAtualizacao = new ColaboradorDTO(
                                novoTipo, matEdit, novoNome, novoSalarioBase,
                                novasVendas, novoPercentual, novaQtd, novoValorUnidade
                        );

                        cadastroService.atualizar(dtoAtualizacao);
                        break;

                    case 0:
                        System.out.println("Encerrando...");
                        break;

                    default:
                        System.out.println("Opção inválida!");
                }
            } catch (IllegalArgumentException e) {
                System.out.println("\n[REGRA DE NEGÓCIO] " + e.getMessage());
            } catch (Exception e) {
                System.out.println("\n[ERRO DE ENTRADA] Verifique os dados digitados.");
                scanner.nextLine();
            }
        }
        scanner.close();
    }
}