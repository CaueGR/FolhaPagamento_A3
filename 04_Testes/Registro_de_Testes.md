# Registro de preparação e execução dos testes

## Objetivo

Documentar a preparação do ambiente, a implementação e a execução
dos testes do Sistema de Folha de Pagamento para a entrega A3.

## Etapa 1 — Conferência da estrutura inicial

### Atividade realizada
Conferência visual da estrutura do projeto no IntelliJ IDEA.

### Situação encontrada
- Código Java localizado na pasta src.
- Organização em dto, entities, repository e service.
- Classe Main responsável pela execução da aplicação.
- Arquivo colaboradores_db.csv presente na raiz.
- Arquivo README.md presente na raiz.
- Nenhum arquivo pom.xml ou diretório de testes visível na estrutura apresentada.

### Próxima atividade
Configurar o Maven e adicionar o JUnit para iniciar os testes unitários.

### Situação dos testes nesta etapa
Nenhum teste JUnit executado nesta etapa.
Ainda não há resultados de aprovação ou medição de cobertura.

## Etapa 2 — Organização das pastas para o Maven

### Alterações realizadas
- Código da aplicação movido para src/main/java.
- src/main/java marcada como Sources Root no IntelliJ.
- Pasta src/test/java criada e marcada como Test Sources Root.

### Motivo
Separar o código da aplicação dos testes e adotar a estrutura
padrão utilizada pelo Maven.

### Conferência realizada
A classe Colaborador permanece com a declaração package entities.

### Situação
Organização das pastas concluída.
Compilação e execução ainda não verificadas após a movimentação.
JUnit ainda não configurado; nenhum teste executado nesta etapa.

## Etapa 3 — Configuração inicial do Maven e JUnit

### Alteração realizada
Criação do arquivo pom.xml na raiz do projeto.

### Configuração declarada
- Java 21.
- Codificação UTF-8.
- JUnit Jupiter 5.12.2, disponível no escopo de testes.
- Maven Compiler Plugin 3.14.0.
- Maven Surefire Plugin 3.5.3.

### Motivo
Gerenciar as dependências e preparar a compilação e a execução
dos testes automatizados de forma reproduzível.

### Validação realizada
Em 10/11/2026, foi executada a fase compile do Maven pelo IntelliJ.

Resultado: BUILD SUCCESS.
Foram compilados 9 arquivos Java com release 21.
Os arquivos compilados foram gerados em target/classes.

### Ajuste do ambiente
A primeira tentativa falhou porque o Maven não conseguiu criar
ou acessar o repositório local de dependências.

O caminho foi alterado nas configurações do IntelliJ para
C:\maven-repository. Após a alteração, a compilação terminou
com sucesso. A causa exata da falha no caminho anterior
não foi confirmada.

### Situação
Compilação do código da aplicação confirmada.
Execução de testes JUnit ainda não verificada.
Cobertura ainda não medida.

## Etapa 4 — Implementação do primeiro teste unitário

### Caso de teste
CT001 — Cálculo do salário do colaborador padrão.
Requisitos relacionados: RF002 e RF006.

### Implementação
Arquivo: src/test/java/entities/ColaboradorPadraoTest.java
Método: ct001_deveRetornarSalarioBaseComoSalarioFinal

### Dados de entrada
Matrícula: 1001.
Nome: Ana.
Salário-base: 2000.00.

### Resultado esperado
O método calcularSalarioFinal deve retornar 2000.00.
A comparação utiliza tolerância de 0.001.

### Execução e resultado
Data: 10/11/2026, às 22h07, horário de Brasília.
Execução: fase test do Maven, pelo IntelliJ IDEA.
Classe executada: entities.ColaboradorPadraoTest.

Testes executados: 1.
Falhas: 0.
Erros: 0.
Ignorados: 0.
Resultado do Maven: BUILD SUCCESS.

O CT001 foi aprovado: o retorno do cálculo correspondeu
ao valor esperado de 2000.00, dentro da tolerância de 0.001.

### Alcance da verificação
Foi verificado o cálculo do colaborador padrão com salário-base
de 2000.00. Esse resultado não comprova os demais cenários
nem representa uma medição de cobertura.

## Etapa 5 — Rejeição de salário-base negativo

### Caso de teste
CT002 — Rejeitar salário-base negativo.
Regra relacionada: RN003.

### Implementação
Arquivo: src/test/java/entities/ColaboradorPadraoTest.java
Método: ct002_deveRejeitarSalarioBaseNegativo

### Dados de entrada
Matrícula: 1002.
Nome: Bruno.
Salário-base: -500.00.

### Resultado esperado
Lançamento de IllegalArgumentException durante a construção,
impedindo a criação do colaborador.

### Estratégia
Uso de assertThrows para verificar a rejeição do salário inválido.

### Execução e resultado

Em 18/11/2026, às 20h35 (horário de Brasília), a fase `test` do Maven
executou o CT001 e o CT002. Ambos passaram, com zero falhas, zero erros
e zero testes ignorados.

**CT002 aprovado.** O construtor de `ColaboradorPadrao` rejeitou o
salário-base de −R$ 500,00 ao lançar `IllegalArgumentException`,
conforme a regra RN003.

[Relatório por teste (XML)](Evidencias/CT002/TEST-entities.ColaboradorPadraoTest.xml)
| [Resumo da execução (TXT)](Evidencias/CT002/entities.ColaboradorPadraoTest.txt)

## Etapa 6 — Cálculo do salário do colaborador comissionado

**CT003 — Requisitos RF003 e RF006**

O teste cria um colaborador com salário-base de R$ 2.000,00,
vendas de R$ 10.000,00 e comissão de 5%.

**Resultado esperado:** comissão de R$ 500,00 e salário final de R$ 2.500,00.
### Execução e resultado

Em 18/11/2026, às 21h14 (horário de Brasília), a fase `test` do Maven
executou CT001, CT002 e CT003. Os três passaram, com zero falhas,
zero erros e zero testes ignorados.

**CT003 aprovado.** Para vendas de R$ 10.000,00 com comissão de 5%,
o teste confirmou R$ 500,00 de comissão e salário final de R$ 2.500,00.

[Relatório por teste (XML)](Evidencias/CT003/TEST-entities.ColaboradorComissionadoTest.xml)
| [Resumo da execução (TXT)](Evidencias/CT003/entities.ColaboradorComissionadoTest.txt)

## CT004 — Cálculo do salário por produção

**Aprovado em 24/11/2026.** Com salário-base de R$ 1.500,00 e 100 unidades a R$ 10,00 cada, o teste confirmou o adicional de R$ 1.000,00 e o salário final de R$ 2.500,00.

Os 4 testes passaram, com zero falhas e zero erros.

[Evidências do CT004](Evidencias/CT004/)

## CT005 — Rejeição de nome vazio e nome nulo (RN002)

**Aprovado em 24/11/2026.** Ao criar um `ColaboradorPadrao` com nome vazio (`""`) ou nulo (`null`), o construtor lançou `IllegalArgumentException` nos dois casos.

Os 5 testes passaram, com zero falhas e zero erros.

[Evidências do CT005](Evidencias/CT005/)

## CT007 — Rejeição de tipo de colaborador inválido (RNF002)

**Aprovado em 24/11/2026.** Ao tentar cadastrar um colaborador com `tipo = 9`, o serviço lançou `IllegalArgumentException` com a mensagem “Tipo de colaborador inválido.”. O Mockito confirmou que o serviço não chamou `salvar()`.

Os 6 testes passaram, com zero falhas e zero erros.

[Evidências do CT007](Evidencias/CT007/)

## CT015 — Rejeição de valor de vendas negativo (RN004)

**Aprovado em 24/11/2026.** Com salário-base de R$ 2.000,00 e comissão de 5%, o construtor de `ColaboradorComissionado` lançou `IllegalArgumentException` ao receber um valor de vendas de −R$ 1,00.

Os 7 testes passaram, com zero falhas e zero erros.

[Evidências do CT015](Evidencias/CT015/)

## CT016 — Rejeição de percentual de comissão negativo (RN005)

**Aprovado em 24/11/2026.** Com salário-base de R$ 2.000,00 e vendas de R$ 10.000,00, o construtor de `ColaboradorComissionado` lançou `IllegalArgumentException` ao receber um percentual de comissão de −1%.

Os 8 testes passaram, com zero falhas e zero erros.

[Evidências do CT016](Evidencias/CT016/)

## CT017 — Rejeição de quantidade produzida negativa (RN006)

**Aprovado em 24/11/2026.** Com salário-base de R$ 1.500,00 e valor de R$ 10,00 por unidade, o construtor de `ColaboradorProducao` lançou `IllegalArgumentException` ao receber `-1` como quantidade produzida.

Os 9 testes passaram, com zero falhas e zero erros.

[Evidências do CT017](Evidencias/CT017/)