# Sistema de Folha de Pagamento (A3)

Aplicação acadêmica em Java 21, executada via terminal (CLI), para gerenciar colaboradores de diferentes regimes de remuneração, calcular proventos de forma polimórfica e persistir os registros em CSV.

---

## 1. Objetivo do Projeto
Aplicar conceitos de Programação Orientada a Objetos (abstração, herança, polimorfismo e encapsulamento) e Engenharia de Qualidade de Software em um sistema de folha de pagamento organizado em camadas, com validação automatizada em níveis unitário, de integração, sistema e aceitação.

### Funcionalidades Implementadas

| Opção | Operação | Comportamento |
| :--- | :--- | :--- |
| **`1`** | **Cadastrar colaborador** | Seleciona o tipo (`1-Padrão`, `2-Comissionado`, `3-Produção`), valida matrícula única e valores não negativos, e grava no CSV. |
| **`2`** | **Consultar colaboradores** | Lista matrícula, nome e categoria de todos os registros ativos no CSV. |
| **`3`** | **Excluir colaborador** | Localiza pela matrícula, remove o registro e atualiza o CSV. |
| **`4`** | **Gerar folha detalhada** | Exibe salário-base, adicionais e salário final de cada colaborador cadastrado. |
| **`5`** | **Emitir resumo da folha** | Exibe quantidade total de colaboradores, montante geral da folha e subtotais por categoria. |
| **`6`** | **Editar colaborador** | Mantém a matrícula e permite atualizar tipo, nome, salário-base e parâmetros específicos. |
| **`7`** | **Gerar folha individual** | Solicita uma matrícula e exibe o demonstrativo detalhado daquele colaborador (ou aviso caso não exista). |
| **`0`** | **Sair** | Libera os recursos e encerra a aplicação de forma limpa. |

### Regras de Remuneração

| Tipo | Categoria | Fórmula do Salário Final |
| :--- | :--- | :--- |
| **`1`** | **Padrão** | $SalárioFinal = SalárioBase$ |
| **`2`** | **Comissionado** | $SalárioFinal = SalárioBase + (TotalVendas \times \frac{Percentual}{100})$ |
| **`3`** | **Produção** | $SalárioFinal = SalárioBase + (QuantidadeProduzida \times ValorUnidade)$ |

> **Exemplos de referência (`AC01`–`AC03`):**
> * **Padrão (`1001` — Ana):** Base `R$ 2.000,00` $\rightarrow$ Final **`R$ 2.000,00`**
> * **Comissionado (`1002` — Bruno):** Base `R$ 2.000,00` + `5%` sobre `R$ 10.000,00` (`R$ 500,00`) $\rightarrow$ Final **`R$ 2.500,00`**
> * **Produção (`1003` — Carla):** Base `R$ 1.500,00` + `100` un. $\times$ `R$ 10,00` (`R$ 1.000,00`) $\rightarrow$ Final **`R$ 2.500,00`**

---

## 2. Integrantes da Equipe
* **João Corso Sadowoy Martins** — RA: `[Preencher RA]`
* **Cauê** — RA: `[Preencher RA]`
* **Caio** — RA: `[Preencher RA]`

---

## 3. Tecnologias e Ferramentas

| Tecnologia | Aplicação no Projeto |
| :--- | :--- |
| **Java 21 (JDK 21)** | Linguagem base da aplicação (`Records`, `Optional`, `Collections`, `Java NIO/I/O`, `Scanner`). |
| **Apache Maven (`pom.xml`)** | Gerenciamento de dependências e execução da suíte de testes unitários/integração. |
| **CSV (UTF-8)** | Persistência local estruturada (`colaboradores_db.csv`) com escrita atômica via arquivo temporário. |
| **JUnit 5** | Automação dos testes unitários e de integração (`CT001`–`CT008`, `CT014`–`CT018`, `CT026`, `CT028`, `CT030`). |
| **Robot Framework** | Automação caixa-preta de sistema e aceitação via terminal (`CT009`–`CT013`, `CT019`–`CT025`, `CT027`, `CT029`, `CT031`–`CT033`). |

---

## 4. Instalação, Compilação e Execução

### Clonar o repositório
```bash
git clone [https://github.com/CaueGR/FolhaPagamento_A3.git](https://github.com/CaueGR/FolhaPagamento_A3.git)
cd FolhaPagamento_A3
