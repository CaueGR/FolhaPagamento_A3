
package service;

import dto.ColaboradorDTO;
import entities.Colaborador;
import entities.ColaboradorComissionado;
import entities.ColaboradorPadrao;
import entities.ColaboradorProducao;
import repository.ColaboradorRepository;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

public class CadastroService {

    private final ColaboradorRepository repository;

    public CadastroService(ColaboradorRepository repository) {
        this.repository = repository;
    }

    public void cadastrar(ColaboradorDTO dto) throws IOException {

        if (repository.buscarPorMatricula(dto.matricula()).isPresent()) {
            throw new IllegalArgumentException(
                    "Matrícula " + dto.matricula() + " já cadastrada!"
            );
        }

        Colaborador novoColaborador = switch (dto.tipo()) {

            case 1 -> new ColaboradorPadrao(
                    dto.matricula(),
                    dto.nome(),
                    dto.salarioBase()
            );

            case 2 -> new ColaboradorComissionado(
                    dto.matricula(),
                    dto.nome(),
                    dto.salarioBase(),
                    dto.valorVendas(),
                    dto.percentualComissao()
            );

            case 3 -> new ColaboradorProducao(
                    dto.matricula(),
                    dto.nome(),
                    dto.salarioBase(),
                    dto.quantidadeProduzida(),
                    dto.valorPorUnidade()
            );

            default -> throw new IllegalArgumentException(
                    "Tipo de colaborador inválido."
            );
        };

        repository.salvar(novoColaborador);

        System.out.println(
                "[OK] Colaborador "
                        + novoColaborador.getNome()
                        + " cadastrado com sucesso."
        );
    }

    public List<Colaborador> listarTodos() {
        return repository.buscarTodos();
    }

    public boolean excluir(String matricula) throws IOException {

        boolean removido = repository.deletar(matricula);

        if (removido) {
            System.out.println(
                    "[OK] Colaborador com matrícula "
                            + matricula
                            + " excluído com sucesso."
            );
        } else {
            System.out.println(
                    "[ERRO] Colaborador com matrícula "
                            + matricula
                            + " não encontrado."
            );
        }

        return removido;
    }

    public Optional<Colaborador> buscarPorMatricula(String matricula) {
        return repository.buscarPorMatricula(matricula);
    }

    public void atualizar(ColaboradorDTO dto) throws IOException {

        if (repository.buscarPorMatricula(dto.matricula()).isEmpty()) {
            throw new IllegalArgumentException(
                    "Colaborador com matrícula "
                            + dto.matricula()
                            + " não encontrado!"
            );
        }

        // Cria o colaborador atualizado de acordo com o tipo informado.
        Colaborador colaboradorAtualizado = switch (dto.tipo()) {

            case 1 -> new ColaboradorPadrao(
                    dto.matricula(),
                    dto.nome(),
                    dto.salarioBase()
            );

            case 2 -> new ColaboradorComissionado(
                    dto.matricula(),
                    dto.nome(),
                    dto.salarioBase(),
                    dto.valorVendas(),
                    dto.percentualComissao()
            );

            case 3 -> new ColaboradorProducao(
                    dto.matricula(),
                    dto.nome(),
                    dto.salarioBase(),
                    dto.quantidadeProduzida(),
                    dto.valorPorUnidade()
            );

            default -> throw new IllegalArgumentException(
                    "Tipo de colaborador inválido."
            );
        };

        // Atualiza no repositório.
        boolean atualizado = repository.atualizar(colaboradorAtualizado);

        if (atualizado) {

            System.out.println(
                    "[OK] Colaborador "
                            + colaboradorAtualizado.getNome()
                            + " atualizado com sucesso."
            );

        } else {

            throw new IllegalArgumentException(
                    "Não foi possível atualizar o colaborador."
            );
        }
    }
}
