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

### Situação
Arquivo de configuração criado.
Importação e resolução das dependências aguardando confirmação.
Compilação e execução dos testes ainda não verificadas.
Cobertura ainda não medida.