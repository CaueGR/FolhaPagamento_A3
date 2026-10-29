# Sistema de Folha de Pagamento

## 1. Sobre o projeto

O **Sistema de Folha de Pagamento** é uma aplicação desenvolvida em Java com o objetivo de realizar o cadastro, a consulta, a edição e a exclusão de colaboradores, além de calcular e emitir informações relacionadas à folha de pagamento.

O sistema utiliza uma interface de linha de comando (CLI), permitindo que o usuário interaja com as funcionalidades por meio de um menu.

Os dados dos colaboradores são armazenados em um arquivo CSV, permitindo que as informações permaneçam disponíveis mesmo após o encerramento da aplicação.

O projeto utiliza conceitos de Programação Orientada a Objetos (POO), separação de responsabilidades e persistência de dados em arquivos.

## 2. Objetivos

- Gerenciar o cadastro de colaboradores.
- Diferenciar colaboradores de acordo com seu modelo de remuneração.
- Calcular valores de pagamento conforme o tipo de colaborador.
- Permitir consultas, atualizações e exclusões de registros.
- Gerar folhas de pagamento detalhadas.
- Emitir resumos financeiros da folha.
- Armazenar os dados em um arquivo CSV.
- Aplicar conceitos de encapsulamento, herança, polimorfismo e organização em camadas.

## 3. Tecnologias utilizadas

| Tecnologia | Utilização |
|---|---|
| Java 21 | Linguagem de programação |
| Java Records | Representação de DTOs |
| Java Collections | Armazenamento temporário dos colaboradores em memória |
| Java Streams | Busca de colaboradores |
| Java I/O e NIO | Leitura e gravação de arquivos |
| CSV | Persistência dos dados |
| Scanner | Entrada de dados pelo terminal |

## 4. Funcionalidades

O sistema disponibiliza as seguintes operações:

| Opção | Funcionalidade | Descrição |
|---|---|---|
| 1 | Cadastrar colaborador | Registra um novo colaborador |
| 2 | Consultar colaboradores | Exibe os colaboradores cadastrados |
| 3 | Excluir colaborador | Remove um colaborador pela matrícula |
| 4 | Gerar folha detalhada | Apresenta informações detalhadas da folha |
| 5 | Emitir resumo da folha | Apresenta um resumo dos pagamentos |
| 6 | Editar colaborador | Atualiza os dados de um colaborador |
| 0 | Sair | Encerra a aplicação |

### 4.1 Cadastro de colaboradores

O cadastro permite informar:

- Tipo de colaborador;
- Matrícula;
- Nome;
- Salário-base;
- Informações específicas de remuneração, conforme o tipo.

O sistema verifica se a matrícula já está cadastrada antes de realizar a inclusão.

### 4.2 Consulta

A consulta apresenta os colaboradores cadastrados, incluindo:

- Matrícula;
- Nome;
- Tipo de colaborador.

### 4.3 Exclusão

A exclusão é realizada por meio da matrícula.

Caso a matrícula seja encontrada, o colaborador é removido da lista e os dados são atualizados no arquivo CSV.

Caso contrário, o sistema informa que o colaborador não foi encontrado.

### 4.4 Edição

A edição permite localizar um colaborador pela matrícula e atualizar seus dados.

A matrícula é mantida, enquanto os demais dados podem ser modificados.

O sistema também permite alterar o tipo de colaborador, desde que seja informado um tipo válido.

### 4.5 Folha de pagamento detalhada

A funcionalidade de folha detalhada utiliza a classe `FolhaPagamentoService` para apresentar os dados de pagamento dos colaboradores cadastrados.

### 4.6 Resumo da folha

O resumo da folha apresenta informações consolidadas dos pagamentos.

A implementação dos cálculos e da apresentação dos resultados é responsabilidade da classe `FolhaPagamentoService`.

## 5. Tipos de colaboradores

O sistema trabalha com três tipos de colaboradores.

### 5.1 Colaborador padrão

Recebe o valor definido em seu salário-base.

**Regra de cálculo:**

```text
Salário = Salário-base
```

### 5.2 Colaborador comissionado

Recebe o salário-base acrescido de uma comissão calculada sobre o valor das vendas.

**Regra de cálculo:**

```text
Comissão = Valor das vendas × Percentual de comissão / 100

Salário = Salário-base + Comissão
```

Exemplo:

```text
Salário-base: R$ 2.000,00
Vendas: R$ 10.000,00
Comissão: 5%

Comissão = 10.000 × 5 / 100
Comissão = R$ 500,00

Salário = 2.000 + 500

Salário final = R$ 2.500,00
```

### 5.3 Colaborador de produção

Recebe o salário-base acrescido de um valor calculado conforme sua produção.

**Regra de cálculo:**

```text
Valor da produção = Quantidade produzida × Valor por unidade

Salário = Salário-base + Valor da produção
```

Exemplo:

```text
Salário-base: R$ 1.500,00
Quantidade produzida: 100 unidades
Valor por unidade: R$ 10,00

Valor da produção = 100 × 10
Valor da produção = R$ 1.000,00

Salário final = R$ 2.500,00
```

> Os exemplos ilustram as regras de remuneração consideradas no projeto. A aplicação de descontos, encargos ou outros adicionais depende das regras implementadas na classe responsável pelo cálculo da folha.

## 6. Arquitetura do projeto

O projeto utiliza uma organização em camadas para separar as responsabilidades.

```text
Usuário
   |
   v
Main
   |
   v
CadastroService
   |
   v
ColaboradorRepository
   |
   v
Arquivo CSV
```

A geração da folha utiliza uma camada específica:

```text
Main
   |
   v
FolhaPagamentoService
   |
   v
Colaboradores cadastrados
```

### 6.1 Main

A classe `Main` é responsável pela interação com o usuário.

Suas responsabilidades incluem:

- Exibir o menu principal;
- Receber os dados digitados;
- Criar os objetos DTO;
- Chamar os métodos dos serviços;
- Tratar erros de entrada e exceções;
- Controlar o funcionamento da aplicação.

### 6.2 DTO — Data Transfer Object

A classe `ColaboradorDTO` é utilizada para transportar os dados informados pelo usuário até a camada de serviço.

O DTO foi implementado utilizando um `record` do Java.

```java
public record ColaboradorDTO(
        int tipo,
        String matricula,
        String nome,
        double salarioBase,
        double valorVendas,
        double percentualComissao,
        int quantidadeProduzida,
        double valorPorUnidade
) {}
```

O uso de `record` permite representar os dados de forma concisa e imutável.

### 6.3 CadastroService

A classe `CadastroService` contém as regras relacionadas ao gerenciamento dos colaboradores.

Suas responsabilidades incluem:

- Validar matrículas duplicadas;
- Verificar a existência de colaboradores;
- Criar as entidades conforme o tipo informado;
- Encaminhar os dados ao repositório;
- Coordenar operações de cadastro, consulta, edição e exclusão.

### 6.4 ColaboradorRepository

A classe `ColaboradorRepository` é responsável pela persistência dos dados.

Suas funcionalidades incluem:

- Salvar colaboradores;
- Buscar colaboradores por matrícula;
- Listar todos os colaboradores;
- Atualizar registros;
- Excluir registros;
- Carregar os dados do arquivo CSV;
- Gravar os dados no arquivo CSV.

O repositório utiliza uma lista em memória para manter os colaboradores durante a execução da aplicação.

### 6.5 FolhaPagamentoService

A classe `FolhaPagamentoService` é responsável pelas operações relacionadas à folha de pagamento.

Suas funcionalidades incluem:

- Gerar a folha detalhada;
- Emitir o resumo da folha;
- Utilizar os colaboradores cadastrados para apresentar os resultados.

## 7. Persistência de dados

Os dados são armazenados no arquivo:

```text
colaboradores_db.csv
```

O arquivo utiliza o formato CSV (*Comma-Separated Values*).

A estrutura dos dados é:

```csv
TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
```

Cada colaborador é representado por uma linha.

Exemplo:

```csv
TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
1,001,Carlos,2000.0,0,0,0,0
2,002,Ana,2000.0,10000.0,5.0,0,0
3,003,Pedro,1500.0,0,0,100,10.0
```

O campo `TIPO` identifica o modelo de remuneração:

| Tipo | Colaborador |
|---|---|
| 1 | Padrão |
| 2 | Comissionado |
| 3 | Produção |

Os dados são carregados na inicialização do sistema.

Quando uma operação de cadastro, edição ou exclusão é realizada, o arquivo CSV é atualizado.

## 8. Tratamento de erros

O sistema utiliza exceções para tratar situações que impedem a execução correta de uma operação.

Entre os erros tratados estão:

- Matrícula já cadastrada;
- Colaborador não encontrado;
- Tipo de colaborador inválido;
- Dados de entrada inválidos;
- Falhas na leitura do arquivo;
- Falhas na gravação do arquivo.

As exceções de entrada são tratadas na classe `Main`, enquanto as regras de negócio são verificadas na camada de serviço.

As falhas de persistência são encaminhadas por meio de `IOException`.

## 9. Como executar o projeto

### Pré-requisitos

- Java Development Kit (JDK) 21;
- IDE compatível com Java, como IntelliJ IDEA, Eclipse ou VS Code.

### Execução pela IDE

1. Abra o projeto na IDE.
2. Verifique se o JDK 21 está configurado.
3. Localize a classe `Main`.
4. Execute o método `main`.
5. Utilize o menu apresentado no terminal.

### Execução pelo terminal

Caso o projeto esteja configurado para compilação direta pelo terminal, navegue até a pasta que contém os arquivos Java.

A compilação deve considerar os pacotes e a estrutura do projeto.

Após a compilação, execute a classe `Main` utilizando o classpath correspondente.

> Os comandos exatos de compilação dependem da estrutura de pastas e da configuração do projeto.

## 10. Exemplo de utilização

Ao executar a aplicação, o usuário visualizará o menu:

```text
==================================
   SISTEMA DE FOLHA DE PAGAMENTO
==================================
1. Cadastrar Colaborador
2. Consultar Colaboradores
3. Excluir Colaborador
4. Gerar Folha Detalhada
5. Emitir Resumo da Folha
6. Editar Colaborador
0. Sair
Escolha uma opção:
```

Para cadastrar um colaborador padrão, o usuário deverá selecionar a opção `1` e informar os dados solicitados.

Para consultar os registros cadastrados, deverá selecionar a opção `2`.

As demais funcionalidades são acessadas pelo menu principal.

## 11. Conceitos de Programação Orientada a Objetos

O projeto aplica conceitos fundamentais de POO.

### Encapsulamento

As responsabilidades e os dados são organizados dentro das classes correspondentes.

### Herança

Os diferentes tipos de colaboradores são representados por classes específicas derivadas da classe base `Colaborador`.

### Polimorfismo

Os diferentes tipos de colaboradores podem ser tratados de forma comum por meio da classe base, permitindo que suas particularidades sejam utilizadas nas operações de pagamento.

### Abstração

A classe base `Colaborador` representa os elementos comuns aos colaboradores, enquanto as classes específicas representam as particularidades de cada modelo de remuneração.

### Separação de responsabilidades

A aplicação divide suas responsabilidades entre interface, serviço, entidades, DTO e repositório.

Essa organização facilita a manutenção e a evolução do código.

## 12. Limitações e melhorias futuras

O projeto pode ser evoluído com novas funcionalidades, como:

- Implementação de testes unitários automatizados;
- Testes de integração da persistência em CSV;
- Validação mais robusta dos dados de entrada;
- Melhorias no tratamento de arquivos corrompidos;
- Utilização de banco de dados relacional;
- Implementação de interface gráfica;
- Geração de relatórios em PDF;
- Inclusão de descontos e encargos na folha;
- Controle de histórico de pagamentos;
- Implementação de autenticação e controle de acesso.

## 13. Considerações finais

O Sistema de Folha de Pagamento foi desenvolvido para aplicar conceitos de programação Java e Programação Orientada a Objetos em um cenário prático de gerenciamento de colaboradores.

A aplicação permite realizar operações de cadastro, consulta, edição e exclusão, além de fornecer funcionalidades de cálculo e apresentação da folha de pagamento.

A separação em camadas e a persistência em CSV contribuem para a organização do projeto e possibilitam sua evolução futura.

---

**Projeto acadêmico — Sistema de Folha de Pagamento**

Desenvolvido em Java.
