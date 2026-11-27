# Manual Técnico — Sistema de Folha de Pagamento

## 1. Arquitetura do Sistema
O sistema foi desenvolvido em **Java 21** utilizando arquitetura modular em camadas para isolar interface, regras de negócio, domínio e persistência:

* **`src/Main.java` (Apresentação / CLI):** Gerencia o loop interativo no terminal (`0` a `7`), captura entradas via `Scanner`, trata exceções de digitação e aciona os serviços.
* **`src/service/` (Regras de Negócio):**
  * `CadastroService`: Valida regras de unicidade de matrícula (`RN001`) e valores não negativos (`RN002`), coordenando inclusão, consulta, edição e exclusão.
  * `FolhaPagamentoService`: Executa a geração da folha detalhada, resumo consolidado e folha individual de forma polimórfica.
* **`src/entities/` (Domínio):** Classe abstrata `Colaborador` e suas subclasses concretas (`ColaboradorPadrao`, `ColaboradorComissionado`, `ColaboradorProducao`).
* **`src/repository/` (Persistência):** `ColaboradorRepository` responsável pela leitura e gravação atômica em arquivo CSV.
* **`src/dto/` (Transporte de Dados):** Record `ColaboradorDTO` para tráfego imutável entre as camadas.

---

## 2. Modelo de Dados (Persistência CSV)
O armazenamento utiliza arquivo texto `colaboradores_db.csv` (codificação UTF-8, delimitador vírgula `,`):

| Coluna | Tipo | Descrição |
| :--- | :--- | :--- |
| `TIPO` | Inteiro | `1` (Padrão), `2` (Comissionado) ou `3` (Produção). |
| `MATRICULA` | Texto/Inteiro | Identificador único do colaborador (`RN001`). |
| `NOME` | Texto | Nome completo do colaborador (sem vírgulas). |
| `SALARIO_BASE` | Decimal (`double`) | Valor base mensal em reais (separador ponto). |
| `VENDAS` | Decimal (`double`) | Total de vendas no período (usado apenas no tipo `2`). |
| `PERCENTUAL` | Decimal (`double`) | Percentual de comissão, ex: `5.0` para 5% (usado apenas no tipo `2`). |
| `QTD_PRODUZIDA` | Inteiro | Quantidade de itens produzidos (usado apenas no tipo `3`). |
| `VALOR_UNIDADE` | Decimal (`double`) | Valor unitário por item produzido (usado apenas no tipo `3`). |

---

## 3. Dependências e Configuração
* **JDK 21:** Necessário para compilação e execução (`Records`, `Optional`, `java.nio.file`).
* **Apache Maven (`pom.xml`):** Gerencia dependências de teste (`JUnit Jupiter 5` e `Maven Surefire Plugin`).
* **Python 3 + Robot Framework:** Utilizados exclusivamente no ambiente de testes automatizados (`Library Process` e `Library OperatingSystem`).

---

## 4. Guia de Manutenção e Extensibilidade
* **Adicionar nova categoria de colaborador (`RNF003`):**
  1. Criar nova subclasse em `src/entities/` estendendo `Colaborador` e implementando `getTipo()`, `calcularAdicional()` e `calcularSalario()`.
  2. Atualizar o mapeamento de criação no `CadastroService` e a leitura/escrita no `ColaboradorRepository`.
  3. Nenhuma alteração é necessária no `FolhaPagamentoService`, pois o cálculo ocorre via polimorfismo.