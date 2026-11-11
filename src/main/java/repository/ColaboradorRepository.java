package repository;

import entities.Colaborador;
import entities.ColaboradorComissionado;
import entities.ColaboradorPadrao;
import entities.ColaboradorProducao;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.AtomicMoveNotSupportedException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

public class ColaboradorRepository {

    private final List<Colaborador> baseDeDados = new ArrayList<>();

    private static final Path CAMINHO_ARQUIVO =
            Paths.get("colaboradores_db.csv").toAbsolutePath();

    public ColaboradorRepository() {
        carregarDadosDoArquivo();
    }

    public void salvar(Colaborador colaborador) throws IOException {

        List<Colaborador> novaBase =
                new ArrayList<>(baseDeDados);

        novaBase.add(colaborador);

        salvarDadosNoArquivo(novaBase);

        baseDeDados.clear();
        baseDeDados.addAll(novaBase);
    }

    public List<Colaborador> buscarTodos() {
        return new ArrayList<>(baseDeDados);
    }

    public Optional<Colaborador> buscarPorMatricula(String matricula) {
        return baseDeDados.stream()
                .filter(c -> c.getMatricula().equals(matricula))
                .findFirst();
    }

    public boolean deletar(String matricula) throws IOException {

        List<Colaborador> novaBase =
                new ArrayList<>(baseDeDados);

        boolean removido = novaBase.removeIf(
                c -> c.getMatricula().equals(matricula)
        );

        if (removido) {
            salvarDadosNoArquivo(novaBase);

            baseDeDados.clear();
            baseDeDados.addAll(novaBase);
        }

        return removido;
    }

    public boolean atualizar(Colaborador colaboradorAtualizado)
            throws IOException {

        List<Colaborador> novaBase =
                new ArrayList<>(baseDeDados);

        for (int i = 0; i < novaBase.size(); i++) {

            if (novaBase.get(i).getMatricula()
                    .equals(colaboradorAtualizado.getMatricula())) {

                novaBase.set(i, colaboradorAtualizado);

                salvarDadosNoArquivo(novaBase);

                baseDeDados.clear();
                baseDeDados.addAll(novaBase);

                return true;
            }
        }

        return false;
    }

    private void salvarDadosNoArquivo(
            List<Colaborador> colaboradores
    ) throws IOException {

        Path temporario = Files.createTempFile(
                CAMINHO_ARQUIVO.getParent(),
                "colaboradores_",
                ".tmp"
        );

        try {

            try (BufferedWriter bw = Files.newBufferedWriter(
                    temporario,
                    StandardCharsets.UTF_8
            )) {

                bw.write(
                        "TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,"
                                + "PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE"
                );
                bw.newLine();

                for (Colaborador c : colaboradores) {

                    String linha;

                    if (c instanceof ColaboradorPadrao) {

                        linha = String.format(
                                Locale.US,
                                "1,%s,%s,%s,0,0,0,0",
                                c.getMatricula(),
                                c.getNome(),
                                c.getSalarioBase()
                        );

                    } else if (c instanceof ColaboradorComissionado cc) {

                        linha = String.format(
                                Locale.US,
                                "2,%s,%s,%s,%s,%s,0,0",
                                cc.getMatricula(),
                                cc.getNome(),
                                cc.getSalarioBase(),
                                cc.getValorVendas(),
                                cc.getPercentualComissao()
                        );

                    } else if (c instanceof ColaboradorProducao cp) {

                        linha = String.format(
                                Locale.US,
                                "3,%s,%s,%s,0,0,%s,%s",
                                cp.getMatricula(),
                                cp.getNome(),
                                cp.getSalarioBase(),
                                cp.getQuantidadeProduzida(),
                                cp.getValorPorUnidade()
                        );

                    } else {

                        throw new IllegalArgumentException(
                                "Tipo de colaborador não suportado."
                        );
                    }

                    bw.write(linha);
                    bw.newLine();
                }
            }

            try {

                Files.move(
                        temporario,
                        CAMINHO_ARQUIVO,
                        StandardCopyOption.REPLACE_EXISTING,
                        StandardCopyOption.ATOMIC_MOVE
                );

            } catch (AtomicMoveNotSupportedException e) {

                Files.move(
                        temporario,
                        CAMINHO_ARQUIVO,
                        StandardCopyOption.REPLACE_EXISTING
                );
            }

        } finally {

            Files.deleteIfExists(temporario);
        }
    }

    private void carregarDadosDoArquivo() {

        if (!Files.exists(CAMINHO_ARQUIVO)) {
            return;
        }

        List<Colaborador> carregados = new ArrayList<>();

        try (BufferedReader br = Files.newBufferedReader(
                CAMINHO_ARQUIVO,
                StandardCharsets.UTF_8
        )) {

            br.readLine(); // Ignora o cabeçalho.

            String linha;
            int numeroLinha = 1;

            while ((linha = br.readLine()) != null) {

                numeroLinha++;

                if (linha.isBlank()) {
                    continue;
                }

                String[] dados = linha.split(",", -1);

                if (dados.length != 8) {
                    throw new IllegalStateException(
                            "CSV inválido na linha " + numeroLinha
                    );
                }

                int tipo = Integer.parseInt(dados[0]);
                String matricula = dados[1];
                String nome = dados[2];
                double salarioBase = Double.parseDouble(dados[3]);

                switch (tipo) {

                    case 1 -> carregados.add(
                            new ColaboradorPadrao(
                                    matricula,
                                    nome,
                                    salarioBase
                            )
                    );

                    case 2 -> carregados.add(
                            new ColaboradorComissionado(
                                    matricula,
                                    nome,
                                    salarioBase,
                                    Double.parseDouble(dados[4]),
                                    Double.parseDouble(dados[5])
                            )
                    );

                    case 3 -> carregados.add(
                            new ColaboradorProducao(
                                    matricula,
                                    nome,
                                    salarioBase,
                                    Integer.parseInt(dados[6]),
                                    Double.parseDouble(dados[7])
                            )
                    );

                    default -> throw new IllegalStateException(
                            "Tipo inválido na linha " + numeroLinha
                    );
                }
            }

        } catch (IOException e) {

            throw new UncheckedIOException(
                    "Não foi possível ler o arquivo CSV.",
                    e
            );

        } catch (IllegalArgumentException e) {

            throw new IllegalStateException(
                    "Dados inválidos no CSV: " + e.getMessage(),
                    e
            );
        }

        baseDeDados.addAll(carregados);
    }
}