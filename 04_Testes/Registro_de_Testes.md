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
