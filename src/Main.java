
import dto.ColaboradorDTO;
import entities.Colaborador;
import repository.ColaboradorRepository;
import service.CadastroService;
import service.FolhaPagamentoService;

import java.io.IOException;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

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
                scanner.nextLine();

            } catch (Exception e) {
                System.out.println("[ERRO] Digite apenas números.");
                scanner.nextLine();
                continue;
            }

            try {

                switch (opcao) {

                    // CADASTRAR COLABORADOR
                    case 1:

                        System.out.println(
                                "Tipo (1-Padrão, 2-Comissionado, 3-Produção): "
                        );

                        int tipo = scanner.nextInt();
                        scanner.nextLine();

                        System.out.print("Matrícula: ");
                        String matricula = scanner.nextLine();

                        System.out.print("Nome: ");
                        String nome = scanner.nextLine();

                        System.out.print("Salário Base: R$ ");
                        double salarioBase = scanner.nextDouble();

                        double valorVendas = 0;
                        double percentual = 0;
                        double valorUnidade = 0;

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

                        // Cria o DTO com os dados informados.
                        ColaboradorDTO dto = new ColaboradorDTO(
                                tipo,
                                matricula,
                                nome,
                                salarioBase,
                                valorVendas,
                                percentual,
                                qtd,
                                valorUnidade
                        );

                        // Chama o service.
                        // A IOException será tratada pelo catch abaixo.
                        cadastroService.cadastrar(dto);

                        break;

                    // CONSULTAR COLABORADORES
                    case 2:

                        System.out.println(
                                "\n--- LISTA DE COLABORADORES ---"
                        );

                        for (Colaborador c : cadastroService.listarTodos()) {

                            System.out.printf(
                                    "Matrícula: %s | Nome: %s | Tipo: %s%n",
                                    c.getMatricula(),
                                    c.getNome(),
                                    c.getTipo()
                            );
                        }

                        break;

                    // EXCLUIR COLABORADOR
                    case 3:

                        System.out.print(
                                "Matrícula a ser excluída: "
                        );

                        String matExc = scanner.nextLine();

                        cadastroService.excluir(matExc);

                        break;

                    // GERAR FOLHA DETALHADA
                    case 4:

                        folhaService.gerarFolhaDetalhada(
                                cadastroService.listarTodos()
                        );

                        break;

                    // EMITIR RESUMO DA FOLHA
                    case 5:

                        folhaService.gerarResumo(
                                cadastroService.listarTodos()
                        );

                        break;

                    // EDITAR COLABORADOR
                    case 6:

                        System.out.print(
                                "Digite a matrícula do colaborador que deseja editar: "
                        );

                        String matEdit = scanner.nextLine();

                        // Verifica se o colaborador existe.
                        if (cadastroService.buscarPorMatricula(matEdit).isEmpty()) {

                            System.out.println(
                                    "[ERRO] Colaborador não encontrado."
                            );

                            break;
                        }

                        System.out.println(
                                "Qual será o NOVO tipo? "
                                        + "(1-Padrão, 2-Comissionado, 3-Produção): "
                        );

                        int novoTipo = scanner.nextInt();
                        scanner.nextLine();

                        System.out.print("Novo Nome: ");
                        String novoNome = scanner.nextLine();

                        System.out.print("Novo Salário Base: R$ ");
                        double novoSalarioBase = scanner.nextDouble();

                        double novasVendas = 0;
                        double novoPercentual = 0;
                        double novoValorUnidade = 0;

                        int novaQtd = 0;

                        if (novoTipo == 2) {

                            System.out.print("Novo Valor das Vendas: R$ ");
                            novasVendas = scanner.nextDouble();

                            System.out.print(
                                    "Novo Percentual de Comissão (%): "
                            );

                            novoPercentual = scanner.nextDouble();

                        } else if (novoTipo == 3) {

                            System.out.print("Nova Quantidade Produzida: ");
                            novaQtd = scanner.nextInt();

                            System.out.print("Novo Valor por Unidade: R$ ");
                            novoValorUnidade = scanner.nextDouble();
                        }

                        // A matrícula permanece a mesma.
                        ColaboradorDTO dtoAtualizacao = new ColaboradorDTO(
                                novoTipo,
                                matEdit,
                                novoNome,
                                novoSalarioBase,
                                novasVendas,
                                novoPercentual,
                                novaQtd,
                                novoValorUnidade
                        );

                        cadastroService.atualizar(dtoAtualizacao);

                        break;

                    // SAIR
                    case 0:

                        System.out.println("Encerrando...");

                        break;

                    // OPÇÃO INVÁLIDA
                    default:

                        System.out.println("Opção inválida!");

                        break;
                }

            } catch (IllegalArgumentException e) {

                System.out.println(
                        "\n[REGRA DE NEGÓCIO] " + e.getMessage()
                );

            } catch (IOException e) {

                System.out.println(
                        "\n[ERRO] Não foi possível salvar os dados no arquivo."
                );

            } catch (Exception e) {

                System.out.println(
                        "\n[ERRO DE ENTRADA] Verifique os dados digitados."
                );

                scanner.nextLine();
            }
        }

        scanner.close();
    }
}
