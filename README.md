# Sistema de Folha de Pagamento

Aplicação acadêmica em **Java 21**, executada pelo terminal, para gerenciar colaboradores e calcular sua remuneração. Os dados são persistidos em CSV.

## 1. Objetivo do projeto

Aplicar programação orientada a objetos em um sistema que permite cadastrar, consultar, editar e excluir colaboradores, gerar folhas de pagamento e consolidar os valores pagos por categoria.

O projeto utiliza abstração, herança e polimorfismo nas entidades, um `record` para transporte de dados, serviços para coordenar operações e um repositório para persistência em arquivo.

### Funcionalidades implementadas

| Opção | Operação | Comportamento |
|---|---|---|
| 1 | Cadastrar colaborador | Seleciona o tipo, recebe os dados e verifica matrícula duplicada. |
| 2 | Consultar colaboradores | Lista matrícula, nome e tipo dos registros cadastrados. |
| 3 | Excluir colaborador | Localiza pela matrícula e persiste a exclusão. |
| 4 | Gerar folha detalhada | Exibe base, adicionais e salário final de cada colaborador. |
| 5 | Emitir resumo da folha | Exibe quantidade de colaboradores, total geral e totais por categoria. |
| 6 | Editar colaborador | Mantém a matrícula e permite alterar nome, tipo e dados de remuneração. |
| 7 | Gerar folha individual | Solicita uma matrícula e apresenta os dados salariais daquele colaborador. |
| 0 | Sair | Encerra a aplicação. |

Na opção **7**, `gerarFolhaIndividual(String matricula)` consulta `CadastroService.buscarPorMatricula()`, cujo retorno é `Optional<Colaborador>`. O serviço utiliza `ifPresentOrElse()` para exibir matrícula, nome, tipo, salário-base, adicionais e salário final, ou a mensagem `[ERRO] Colaborador não encontrado.`. O repositório também retorna `Optional<Colaborador>` na busca.

### Regras de remuneração

| Tipo | Categoria | Salário final |
|---|---|---|
| 1 | Padrão | `salarioBase` |
| 2 | Comissionado | `salarioBase + valorVendas * (percentualComissao / 100)` |
| 3 | Produção | `salarioBase + quantidadeProduzida * valorPorUnidade` |

O percentual deve ser informado como **5 para 5%**. Nos relatórios, os adicionais correspondem a `salarioFinal - salarioBase`.

Exemplos: base de R$ 2.000,00, vendas de R$ 10.000,00 e comissão de 5% resultam em R$ 2.500,00; base de R$ 1.500,00, produção de 100 unidades e R$ 10,00 por unidade resultam em R$ 2.500,00.

Os cálculos atuais não incluem INSS, IRRF, FGTS, férias, décimo terceiro ou histórico por competência. Os relatórios são exibidos no terminal; não há exportação de holerites ou PDF.

## 2. Integrantes

**A identificação oficial da equipe ainda não foi informada neste README.** Os integrantes deverão preencher seus nomes completos e suas matrículas acadêmicas antes da entrega. Nenhum nome ou número foi presumido a partir do proprietário do repositório ou dos exemplos de colaboradores.

## 3. Tecnologias e requisitos — Java 21

| Tecnologia | Uso e situação |
|---|---|
| JDK 21 | Compilação e execução da aplicação. |
| Java Records | `ColaboradorDTO`, para transporte dos dados. |
| Collections, Streams e Optional | Lista em memória, busca por matrícula e representação de ausência. |
| Java I/O e NIO | Leitura UTF-8, escrita em arquivo temporário e substituição do CSV. |
| Scanner | Entrada pelo terminal. |
| CSV | Persistência local dos colaboradores. |
| JUnit 5 | Planejado; sem suíte ou dependências configuradas na versão inspecionada. |
| Robot Framework | Planejado; sem suíte ou integração configurada na versão inspecionada. |

A aplicação utiliza a biblioteca padrão do Java e não exige dependências externas para executar. Não há `pom.xml`, `build.gradle` ou wrappers Maven/Gradle na versão inspecionada. Git é necessário apenas para clonar o repositório; uma IDE é opcional.

## 4. Instalação, compilação e utilização

### Obter o projeto

Com o Git instalado, execute no PowerShell:

```powershell
git clone https://github.com/CaueGR/FolhaPagamento_A3.git
Set-Location .\FolhaPagamento_A3
```

Se recebeu um ZIP, extraia-o e abra o terminal na pasta que contém `src` e `colaboradores_db.csv`.

### Conferir o JDK

```powershell
java -version
javac -version
```'

Ambos devem apontar para a versão 21. Se algum comando não for encontrado, configure o JDK 21 no `PATH` e abra um novo terminal.

### Compilar e executar — PowerShell 5.1 ou superior

Execute na raiz do projeto:

```powershell
New-Item -ItemType Directory -Force -Path .\out | Out-Null
javac --release 21 -encoding UTF-8 -d .\out .\src\Main.java .\src\dto\*.java .\src\entities\*.java .\src\repository\*.java .\src\service\*.java
if ($LASTEXITCODE -eq 0) {
    java -cp .\out Main
}
```

O comando compila todos os pacotes existentes. `Main` não possui declaração de pacote. Execute novamente a compilação depois de alterar os fontes.

**Mantenha o diretório de execução na raiz do projeto:** o CSV é localizado em relação ao diretório de trabalho, não à pasta da classe compilada. Ao executar em outra pasta, o programa poderá iniciar com uma base vazia e criar outro CSV nesse local.

O `Scanner` utiliza a configuração regional padrão do Java. No terminal, o separador decimal aceito depende dessa configuração. Para uma execução explícita com ponto decimal, use:

```powershell
java '-Duser.language=en' '-Duser.country=US' -cp .\out Main
```

Essa opção afeta a entrada e a apresentação numérica. O CSV utiliza ponto decimal independentemente da configuração regional.

### Executar no IntelliJ IDEA

1. Abra a pasta do projeto.
2. Configure o SDK do projeto e o nível da linguagem para Java 21.
3. Confira se `src` está marcada como pasta de código-fonte.
4. Na configuração de execução de `Main`, defina a raiz do projeto como diretório de trabalho.
5. Execute `src/Main.java` e utilize as opções do menu.

### Exemplo de utilização

1. Selecione `1`, escolha o tipo `2` e cadastre uma matrícula de teste com nome, base `2000`, vendas `10000` e percentual `5`.
2. Selecione `2` para conferir o cadastro.
3. Selecione `7` e informe a mesma matrícula: o salário final esperado é R$ 2.500,00 e os adicionais são R$ 500,00.
4. Use `4` e `5` para consultar a folha detalhada e o resumo.
5. Use `6` para editar o registro, mantendo sua matrícula.
6. Encerre com `0`, reabra a aplicação e confira a persistência.
7. Use `3` para excluir o registro de teste.

## 5. Formato e persistência do CSV

Arquivo: **`colaboradores_db.csv`**, em UTF-8, separado por vírgulas, com cabeçalho na primeira linha e oito campos por registro.

```csv
TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
1,TESTE001,Colaborador Exemplo A,2000.0,0,0,0,0
2,TESTE002,Colaborador Exemplo B,2000.0,10000.0,5.0,0,0
3,TESTE003,Colaborador Exemplo C,1500.0,0,0,100,10.0
```

Os registros acima são fictícios e não identificam integrantes da equipe.

| Campo | Conteúdo |
|---|---|
| `TIPO` | Inteiro: 1 = padrão, 2 = comissionado, 3 = produção. |
| `MATRICULA` | Identificador textual do colaborador; preserva zeros à esquerda. |
| `NOME` | Nome do colaborador. |
| `SALARIO_BASE` | Valor base, com ponto decimal e sem símbolo monetário. |
| `VENDAS` | Valor das vendas; usado pelo tipo 2. |
| `PERCENTUAL` | Comissão percentual; `5.0` significa 5%; usado pelo tipo 2. |
| `QTD_PRODUZIDA` | Quantidade inteira; usada pelo tipo 3. |
| `VALOR_UNIDADE` | Valor por unidade; usado pelo tipo 3. |

Os campos não utilizados pelo tipo são gravados como zero. Não use separadores de milhar. A implementação usa `split(",", -1)` e não oferece escape de campos CSV: **não inclua vírgulas ou quebras de linha em nomes ou matrículas**, mesmo entre aspas.

### Leitura e gravação

- O repositório carrega o CSV na inicialização. Se o arquivo não existir, inicia uma lista vazia e cria o arquivo na primeira gravação.
- A primeira linha é descartada como cabeçalho; seu conteúdo não é validado. Linhas vazias são ignoradas.
- Linhas com quantidade diferente de oito campos, tipos desconhecidos ou valores inválidos podem interromper a inicialização.
- Cadastro, edição e exclusão trabalham sobre uma cópia da lista. A memória só é atualizada depois que a gravação termina com sucesso.
- A gravação escreve um arquivo temporário no mesmo diretório e tenta substituir o CSV com `ATOMIC_MOVE`. Quando esse recurso não é suportado, utiliza substituição comum.
- Falhas de gravação propagam `IOException` e são tratadas pelo `Main`. Erros de leitura são lançados durante a construção do repositório, antes do laço do menu, e podem encerrar o programa sem uma mensagem amigável.

A matrícula duplicada é verificada no cadastro pelo serviço. A importação do CSV não verifica duplicatas. Evite editar o arquivo enquanto a aplicação estiver aberta: as operações posteriores regravam a lista que está em memória. Não há controle de acesso simultâneo por vários processos.

## 6. Estrutura de pastas e arquitetura

### Estrutura existente na versão inspecionada

```text
folha_pagamento/
├── README.md
├── colaboradores_db.csv
├── Folha_Pagamento.iml
├── .gitignore
├── src/
│   ├── Main.java
│   ├── dto/
│   │   └── ColaboradorDTO.java
│   ├── entities/
│   │   ├── Colaborador.java
│   │   ├── ColaboradorPadrao.java
│   │   ├── ColaboradorComissionado.java
│   │   └── ColaboradorProducao.java
│   ├── repository/
│   │   └── ColaboradorRepository.java
│   └── service/
│       ├── CadastroService.java
│       └── FolhaPagamentoService.java
└── out/                         # Saída de compilação local
```

Também existem metadados locais do IntelliJ (`.idea`) e do Git (`.git`). Eles não são camadas da aplicação. A presença local de um arquivo não significa que esteja versionado no repositório remoto.

| Componente | Responsabilidade |
|---|---|
| `Main` | Menu, leitura de entradas, criação dos DTOs e chamadas aos serviços. |
| `ColaboradorDTO` | `record` com os oito dados de cadastro/edição. |
| `Colaborador` | Classe abstrata com dados comuns e contrato de cálculo salarial. |
| Subclasses de `Colaborador` | Regras de remuneração específicas de cada tipo. |
| `CadastroService` | Verificação de matrícula, criação das entidades e coordenação do cadastro, consulta, edição e exclusão. |
| `FolhaPagamentoService` | Folha detalhada, resumo e folha individual; recebe `CadastroService` pelo construtor. |
| `ColaboradorRepository` | Lista em memória, buscas e leitura/gravação do CSV. |

Fluxos principais: `Main → CadastroService → ColaboradorRepository → CSV` e `Main → FolhaPagamentoService → entidades`. Na folha individual, o serviço de folha consulta o serviço de cadastro para localizar a matrícula.

### Organização documental numerada de 01 a 11

**Status: pendente.** As pastas numeradas não existem na versão inspecionada. A tabela apresenta uma proposta de organização para a entrega acadêmica; os nomes abaixo não foram confirmados com o enunciado original do professor. Se houver nomenclatura oficial, ela deverá prevalecer.

| Pasta proposta | Conteúdo previsto |
|---|---|
| `01_Identificacao/` | Identificação do projeto e da equipe. |
| `02_Objetivos/` | Objetivo geral, objetivos específicos e escopo. |
| `03_Requisitos/` | Requisitos funcionais e não funcionais. |
| `04_Casos_de_Uso/` | Diagramas e descrições dos casos de uso. |
| `05_Modelagem/` | Diagrama de classes e regras de domínio. |
| `06_Arquitetura/` | Camadas, responsabilidades e decisões técnicas. |
| `07_Codigo_Fonte/` | Referência ao código mantido em `src/`. |
| `08_Testes_Unitarios/` | Plano e evidências de JUnit 5. |
| `09_Testes_Aceitacao/` | Plano e evidências de Robot Framework. |
| `10_Evidencias/` | Registros reproduzíveis das verificações e resultados. |
| `11_Entrega/` | Checklist e documentos finais. |

Todas as onze pastas estão **planejadas, ainda não criadas**. O README não cria pastas nem comprova a existência dos documentos previstos. O código permanece em `src/`; os comandos de execução deste documento dependem dessa estrutura.

## 7. Testes, evidências e pendências

### Situação da validação

| Verificação | Situação |
|---|---|
| Inspeção do código | Confirmados menu 0 a 7, uso de `Optional`, fórmulas salariais e persistência por arquivo temporário. |
| Compilação nesta revisão | Aprovada com JDK 21.0.11 e `javac --release 21 -encoding UTF-8`, em cópia isolada dos fontes locais, em 30/10/2026. |
| Execução nesta revisão | Aprovados cadastro e consulta de comissionado, opção 7 com matrícula existente e inexistente, folha detalhada e resumo. Para base 2000, vendas 10000 e comissão 5%, foram obtidos adicionais de 500 e salário final de 2500. Verificação pelo terminal, sem JUnit ou Robot. |
| Reinicialização e exclusão nesta revisão | Em nova execução, o cadastro foi recuperado do CSV, a folha individual manteve os valores e a exclusão foi concluída. A permanência da exclusão após outra reinicialização não foi verificada nesta revisão. |
| Testes anteriores pelo terminal | A revisão anterior relatou compilação com Java 21 e sucesso em cadastro, consulta, folha individual e exclusão. Esse relato não constitui relatório de suíte automatizada. |
| JUnit 5 | Planejado; não há classes de teste, configuração de dependências ou relatórios na versão inspecionada. |
| Robot Framework | Planejado; não há arquivos `.robot`, biblioteca de integração ou relatórios na versão inspecionada. |
| Cobertura de testes | Não medida. |

### Roteiro manual de regressão

Execute em uma cópia isolada do projeto e do CSV. Registre entrada, saída, resultado esperado, resultado obtido, versão do JDK e data.

| Cenário | Resultado esperado |
|---|---|
| Cadastrar cada um dos três tipos | Registro disponível na consulta e salário conforme a fórmula. |
| Repetir uma matrícula no cadastro | Cadastro recusado sem duplicar a linha no CSV. |
| Informar nome vazio ou valores negativos | Rejeição pelas validações correspondentes das entidades. |
| Gerar folha individual para matrícula existente | Identificação, base, adicionais e salário final corretos. |
| Buscar matrícula inexistente na opção 7 | Mensagem de colaborador não encontrado. |
| Editar nome, remuneração e tipo | Novos dados preservados, com a mesma matrícula. |
| Gerar detalhamento e resumo | Valores por colaborador e totais coerentes com a base. |
| Encerrar e reabrir | Cadastros e alterações recuperados do CSV. |
| Excluir e reabrir | Registro permanece excluído. |
| Gerar relatórios com base vazia | Mensagem apropriada, sem falha. |
| Simular falha de gravação em ambiente isolado | Operação não confirmada em memória; erro apresentado. |
| Iniciar com CSV inválido | Falha de inicialização identificada; não presumir recuperação automática. |

A tabela é um **plano de regressão**, não uma declaração de aprovação de todos os cenários.

### JUnit 5 — planejamento e execução futura

Prioridades: testar as três fórmulas, validações das entidades, duplicidade no serviço, retorno presente/vazio de `Optional`, persistência após reinicialização e preservação da memória quando a gravação falhar. Comparações de `double` devem usar tolerância.

Antes de executar, é necessário configurar JUnit Jupiter e um executor, criar os testes e isolar o CSV. O caminho do arquivo é estático e relativo ao diretório de trabalho; sua injeção pelo construtor é uma melhoria recomendada para permitir testes com diretórios temporários.

Exemplo de comando **somente após** configurar um projeto Maven com JUnit 5, Surefire e os diretórios de fontes/testes adequados:

```powershell
mvn test
```

O comando acima **não funciona como instrução imediata para a versão atual**, pois ela não contém `pom.xml`. Relatórios e resultados só deverão ser adicionados depois da execução real.

### Robot Framework — planejamento e execução futura

Prioridades: fluxos completos de cadastro, consulta, opção 7, edição, exclusão e reinicialização com persistência. Para automatizar a CLI interativa, será necessária uma biblioteca ou adaptador que controle o processo Java e verifique suas saídas. Não há interface web nem integração Selenium neste projeto.

Com Python e pip instalados, a instalação opcional do framework pode ser feita em ambiente virtual:

```powershell
py -m venv .venv
.\.venv\Scripts\python.exe -m pip install robotframework
```

Depois de implementar a integração, criar uma suíte em `tests/robot/` e compilar a aplicação, o comando previsto é:

```powershell
.\.venv\Scripts\python.exe -m robot --outputdir reports\robot tests\robot
```

`tests/robot/` e seus testes ainda não existem. Instalar o framework não implementa nem executa cenários por si só. Arquivos como `output.xml`, `log.html` e `report.html` deverão ser obtidos da execução real e avaliados antes de declarar aprovação.

### Limitações e próximos passos

- Preencher a identificação oficial dos integrantes.
- Confirmar com o enunciado os nomes e conteúdos das pastas 01 a 11 e organizar os documentos.
- Implementar e executar as suítes JUnit 5 e Robot Framework, registrando falhas e aprovações.
- Melhorar validações de matrícula, caracteres incompatíveis com o CSV e valores não finitos (`NaN`/infinito). A comissão não possui limite superior de 100% no código atual.
- Tratar erros de carregamento com mensagens amigáveis e ampliar as verificações de integridade do CSV.
- Avaliar `BigDecimal` para valores monetários: a implementação atual usa `double` e formata os relatórios com duas casas decimais.

Este README documenta a implementação inspecionada e separa funcionalidades existentes, verificações e entregas planejadas. Não declara a conclusão das pendências acadêmicas.
