package service;

import dto.ColaboradorDTO;
import entities.Colaborador;
import entities.ColaboradorComissionado;
import entities.ColaboradorPadrao;
import entities.ColaboradorProducao;
import repository.ColaboradorRepository;
import java.util.Optional;

import java.util.List;

public class CadastroService {

    // Injeção de dependência via construtor
    private final ColaboradorRepository repository;

    public CadastroService(ColaboradorRepository repository) {
        this.repository = repository;
    }

    public void cadastrar(ColaboradorDTO dto) {
        // RN001: Verifica duplicidade consultando o repository
        if (repository.buscarPorMatricula(dto.matricula()).isPresent()) {
            throw new IllegalArgumentException("Matrícula " + dto.matricula() + " já cadastrada!");
        }

        // Factory: Converte DTO na Entidade correspondente
        Colaborador novoColaborador = switch (dto.tipo()) {
            case 1 -> new ColaboradorPadrao(dto.matricula(), dto.nome(), dto.salarioBase());
            case 2 -> new ColaboradorComissionado(dto.matricula(), dto.nome(), dto.salarioBase(), dto.valorVendas(), dto.percentualComissao());
            case 3 -> new ColaboradorProducao(dto.matricula(), dto.nome(), dto.salarioBase(), dto.quantidadeProduzida(), dto.valorPorUnidade());
            default -> throw new IllegalArgumentException("Tipo de colaborador inválido.");
        };

        // Salva a entidade pronta
        repository.salvar(novoColaborador);
        System.out.println("[OK] Colaborador " + novoColaborador.getNome() + " cadastrado com sucesso.");
    }

    public List<Colaborador> listarTodos() {
        return repository.buscarTodos();
    }

    public boolean excluir(String matricula) {
        return repository.deletar(matricula);
    }
    public Optional<Colaborador> buscarPorMatricula(String matricula) {
        return repository.buscarPorMatricula(matricula);
    }

    public void atualizar(ColaboradorDTO dto) {
        // Verifica se o colaborador realmente existe antes de tentar atualizar
        if (repository.buscarPorMatricula(dto.matricula()).isEmpty()) {
            throw new IllegalArgumentException("Colaborador com matrícula " + dto.matricula() + " não encontrado!");
        }

        // Factory: Converte o DTO na Entidade correspondente com os novos dados
        Colaborador colaboradorAtualizado = switch (dto.tipo()) {
            case 1 -> new ColaboradorPadrao(dto.matricula(), dto.nome(), dto.salarioBase());
            case 2 -> new ColaboradorComissionado(dto.matricula(), dto.nome(), dto.salarioBase(), dto.valorVendas(), dto.percentualComissao());
            case 3 -> new ColaboradorProducao(dto.matricula(), dto.nome(), dto.salarioBase(), dto.quantidadeProduzida(), dto.valorPorUnidade());
            default -> throw new IllegalArgumentException("Tipo de colaborador inválido.");
        };

        repository.atualizar(colaboradorAtualizado);
        System.out.println("[OK] Colaborador " + colaboradorAtualizado.getNome() + " atualizado com sucesso.");
    }
}