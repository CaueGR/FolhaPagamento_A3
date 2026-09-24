package repository;

import entities.Colaborador;
import entities.ColaboradorComissionado;
import entities.ColaboradorPadrao;
import entities.ColaboradorProducao;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

public class ColaboradorRepository {
    private List<Colaborador> baseDeDados = new ArrayList<>();
    private static final String CAMINHO_ARQUIVO = "colaboradores_db.csv";

    public ColaboradorRepository() {
        carregarDadosDoArquivo();
    }

    public void salvar(Colaborador colaborador) {
        baseDeDados.add(colaborador);
        salvarDadosNoArquivo();
    }

    public List<Colaborador> buscarTodos() {
        return new ArrayList<>(baseDeDados);
    }

    public Optional<Colaborador> buscarPorMatricula(String matricula) {
        return baseDeDados.stream()
                .filter(c -> c.getMatricula().equals(matricula))
                .findFirst();
    }

    public boolean deletar(String matricula) {
        boolean removido = baseDeDados.removeIf(c -> c.getMatricula().equals(matricula));
        if (removido) {
            salvarDadosNoArquivo();
        }
        return removido;
    }

    public boolean atualizar(Colaborador colaboradorAtualizado) {
        for (int i = 0; i < baseDeDados.size(); i++) {
            if (baseDeDados.get(i).getMatricula().equals(colaboradorAtualizado.getMatricula())) {
                baseDeDados.set(i, colaboradorAtualizado);
                salvarDadosNoArquivo(); // Atualiza o CSV
                return true;
            }
        }
        return false;
    }

    private void salvarDadosNoArquivo() {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(CAMINHO_ARQUIVO))) {
            bw.write("TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE\n");

            for (Colaborador c : baseDeDados) {
                StringBuilder linha = new StringBuilder();

                // Usamos Locale.US para garantir que os decimais usam ponto (.) em vez de vírgula (,),
                // para não quebrar a estrutura do CSV.
                if (c instanceof ColaboradorPadrao) {
                    linha.append(String.format(Locale.US, "1,%s,%s,%s,0,0,0,0\n",
                            c.getMatricula(), c.getNome(), c.getSalarioBase()));
                } else if (c instanceof ColaboradorComissionado cc) {
                    linha.append(String.format(Locale.US, "2,%s,%s,%s,%s,%s,0,0\n",
                            cc.getMatricula(), cc.getNome(), cc.getSalarioBase(),
                            cc.getValorVendas(), cc.getPercentualComissao()));
                } else if (c instanceof ColaboradorProducao cp) {
                    linha.append(String.format(Locale.US, "3,%s,%s,%s,0,0,%s,%s\n",
                            cp.getMatricula(), cp.getNome(), cp.getSalarioBase(),
                            cp.getQuantidadeProduzida(), cp.getValorPorUnidade()));
                }

                bw.write(linha.toString());
            }
        } catch (IOException e) {
            System.out.println("[ERRO CRÍTICO] Falha ao salvar no banco de dados: " + e.getMessage());
        }
    }

    private void carregarDadosDoArquivo() {
        File arquivo = new File(CAMINHO_ARQUIVO);
        if (!arquivo.exists()) return;

        try (BufferedReader br = new BufferedReader(new FileReader(arquivo))) {
            String linha = br.readLine(); // Pula o cabeçalho

            while ((linha = br.readLine()) != null) {
                String[] dados = linha.split(",");
                if (dados.length < 8) continue;

                int tipo = Integer.parseInt(dados[0]);
                String matricula = dados[1];
                String nome = dados[2];
                double salarioBase = Double.parseDouble(dados[3]);

                // Lê as colunas específicas guardadas no CSV
                if (tipo == 1) {
                    baseDeDados.add(new ColaboradorPadrao(matricula, nome, salarioBase));
                } else if (tipo == 2) {
                    double vendas = Double.parseDouble(dados[4]);
                    double percentual = Double.parseDouble(dados[5]);
                    baseDeDados.add(new ColaboradorComissionado(matricula, nome, salarioBase, vendas, percentual));
                } else if (tipo == 3) {
                    int qtd = Integer.parseInt(dados[6]);
                    double valorUnidade = Double.parseDouble(dados[7]);
                    baseDeDados.add(new ColaboradorProducao(matricula, nome, salarioBase, qtd, valorUnidade));
                }
            }
        } catch (Exception e) {
            System.out.println("[ERRO CRÍTICO] Falha ao ler o banco de dados: " + e.getMessage());
        }
    }
}