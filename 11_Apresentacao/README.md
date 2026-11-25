# 📊 Apresentação Final — Sistema de Folha de Pagamento (A3)

> **Disciplina:** Qualidade e Testes de Software / Engenharia de Software  
> **Instituição:** UniRitter — Ciência da Computação  
> **Equipe:** João Corso, Cauê, Caio e Eduardo 
> **Data:** Novembro de 2026  

---

## Slide 1 — Capa
### Sistema de Folha de Pagamento (CLI Java)
**Desenvolvimento Orientado a Objetos e Automação de Testes (JUnit 5 & Robot Framework)**

* **Repositório Oficial:** `FolhaPagamento_A3`
* **Executável Homologado:** `07_Executavel/FolhaPagamento_A3.jar`
* **Cobertura de Testes:** 33/33 Casos de Teste Aprovados (`100% PASS`)

---

## Slide 2 — Contexto, Objetivo e Escopo
* **O Problema:** Necessidade de gerenciar colaboradores com diferentes regras de remuneração (fixo, comissão e produção) garantindo precisão nos cálculos e integridade nos dados.
* **Objetivo:** Construir uma aplicação Java em camadas aplicando Orientação a Objetos e validar todo o sistema com automação de testes em múltiplos níveis.
* **Funcionalidades Entregues (Menu `0` a `7`):**
  * Gestão completa de colaboradores (`Cadastrar`, `Consultar`, `Editar` e `Excluir`).
  * Emissão de `Folha Detalhada`, `Folha Individual` (contracheque) e `Resumo Consolidado`.
  * Persistência automática em arquivo texto estruturado (`colaboradores_db.csv`).

---

## Slide 3 — Requisitos e Regras de Negócio

| Código | Escopo / Regra | Definição |
| :--- | :--- | :--- |
| **RF001 / RN001 / RN002** | Cadastro e Validações | Inclusão com matrícula única e bloqueio de valores negativos. |
| **RF002** | Cálculo — Padrão | $SalárioFinal = SalárioBase$ |
| **RF003 / RN003** | Cálculo — Comissionado | $SalárioFinal = SalárioBase + (Vendas \times \frac{Percentual}{100})$ |
| **RF004 / RN004** | Cálculo — Produção | $SalárioFinal = SalárioBase + (QtdProduzida \times ValorUnidade)$ |
| **RF005 – RF010** | Consultas, CRUD e Folhas | Listagem, edição, exclusão, folha detalhada, resumo e folha individual. |
| **RNF001 – RNF004** | Qualidade e Arquitetura | Usabilidade CLI, robustez contra entradas inválidas, extensibilidade OO e CSV. |

---

## Slide 4 — Arquitetura e Projeto Orientado a Objetos
* **Organização em Camadas (`src/main/java`):**
  * **`Main` (Apresentação / CLI):** Controle do menu (`0` a `7`) e tratamento de entradas inválidas (`Scanner`).
  * **`service` (Negócio):** `CadastroService` (regras CRUD) e `FolhaPagamentoService` (cálculo polimórfico).
  * **`entities` (Domínio):** Classe abstrata `Colaborador` estendida por `ColaboradorPadrao`, `ColaboradorComissionado` e `ColaboradorProducao`.
  * **`repository` & `dto`:** `ColaboradorRepository` (persistência CSV) e `ColaboradorDTO`.
* **Diferencial Arquitetural (`RNF003`):** O processamento da folha invoca `calcularSalario()` via polimorfismo, permitindo adicionar novas categorias sem modificar o serviço principal.

---

## Slide 5 — Estratégia de Garantia da Qualidade
* **Abordagem em Pirâmide (33 Casos de Teste):**
  * **Base — Testes Unitários e Integração (`JUnit 5 + Maven` | 16 CTs):** Validação rápida das regras matemáticas, exceções de negócio e leitura/escrita no repositório.
  * **Topo — Testes de Sistema e Aceitação (`Robot Framework` | 17 CTs):** Testes caixa-preta via terminal (`stdin`/`stdout`) executando o `.jar` real.
* **Isolamento e Rastreabilidade:** Cada teste no Robot Framework executa em diretório temporário (`temp_test_dir`) e valida o `colaboradores_db.csv` linha a linha.

---

## Slide 6 — Resultados: Testes Unitários e Integração (JUnit 5)
* **Responsáveis:** Cauê e Caio
* **Casos Cobertos (16 CTs):** `CT001`–`CT008`, `CT014`–`CT018`, `CT026`, `CT028` e `CT030`.
* **Principais Validações:**
  * Cálculo exato das três categorias e chamada polimórfica (`CT005`–`CT008`).
  * Bloqueio de matrícula duplicada e parâmetros negativos (`CT001`–`CT004`, `CT014`–`CT018`).
  * Persistência e recuperação de registros no `ColaboradorRepository` (`CT026`, `CT028`, `CT030`).
* **Status Final:** **16/16 Aprovados (`100% PASS`)**

---

## Slide 7 — Resultados: Automação de Sistema e Aceitação (Robot Framework)
* **Responsável:** João Corso
* **Casos Cobertos (17 CTs):** `CT009`–`CT013`, `CT019`–`CT025`, `CT027`, `CT029`, `CT031`–`CT033`.
* **Principais Validações:**
  * Cadastro (`CT019`), Consulta com contagem exata de linhas (`CT020`) e Edição de todos os campos (`CT009`–`CT013`).
  * Tratamento de matrículas inexistentes (`9999`) na edição e exclusão (`CT021`, `CT022`).
  * Emissão de Folha Detalhada, Resumo Consolidado, Folha Individual e base vazia (`CT023`–`CT025`, `CT033`).
  * Encerramento limpo (`CT027`), robustez contra texto inválido (`CT029`), fluxo E2E (`CT031`) e inspeção OO (`CT032`).
* **Status Final:** **17/17 Aprovados (`100% PASS`)** com relatórios `log.html` e `report.html`.

---

## Slide 8 — Demonstração dos Critérios de Aceitação (Massa AC01–AC03)

| Critério | Colaborador | Categoria | Salário-Base | Adicional | Salário Final | Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **AC01** | `1001` — Ana | Padrão | R$ 2.000,00 | R$ 0,00 | **R$ 2.000,00** | ✅ **PASS** |
| **AC02** | `1002` — Bruno | Comissionado | R$ 2.000,00 | R$ 500,00 (`5%` de `10.000`) | **R$ 2.500,00** | ✅ **PASS** |
| **AC03** | `1003` — Carla | Produção | R$ 1.500,00 | R$ 1.000,00 (`100` x `10,00`) | **R$ 2.500,00** | ✅ **PASS** |
| **Resumo** | **3 Colaboradores** | **Consolidado** | — | — | **R$ 7.000,00** | ✅ **PASS** |

---

## Slide 9 — Organização do Repositório (Padrão Oficial)

| Pasta | Conteúdo Entregue |
| :--- | :--- |
| **`01_Requisitos`** | Especificação de Requisitos (`RF`, `RN`, `RNF`) e Critérios de Aceitação (`AC01`–`AC03`). |
| **`02_Analise`** | Especificação detalhada dos Casos de Uso (`UC01`–`UC08`). |
| **`03_Projeto`** | Arquitetura em camadas e hierarquia de classes Orientada a Objetos. |
| **`04_Testes`** | `Registro_de_Testes.md` e pasta `Evidencias/` com os 33 relatórios e logs. |
| **`05_Codigo_Fonte`** | Código-fonte Java estruturado em pacotes Maven (`src/` e `pom.xml`). |
| **`06_Banco_Dados`** | Arquivo `colaboradores_db.csv` modelo com a massa de referência. |
| **`07_Executavel`** | Pacote compilado `FolhaPagamento_A3.jar` pronto para execução. |
| **`08_Manuais`** | Guia de instalação, execução e operação do menu principal. |
| **`09_Homologacao`** | Termo de Homologação e Aceite assinado pela equipe. |
| **`10_Qualidade`** | Plano de Qualidade, métricas e Matriz de Rastreabilidade (`CT001`–`CT033`). |
| **`11_Apresentacao`** | Roteiro e slides consolidados da entrega final (`Apresentacao_A3.md`). |

---

## Slide 10 — Conclusão e Lições Aprendidas
* **Entrega Consolidada:** Sistema 100% funcional, documentado e homologado com **33/33 casos de teste aprovados**.
* **Principais Ganhos Técnicos:**
  * Uso de polimorfismo reduziu acoplamento e simplificou a extensão de novas regras de cálculo.
  * Automação em dois níveis (JUnit 5 + Robot Framework) garantiu tanto a precisão matemática quanto a resiliência da interface via terminal.# 11 - Apresentacao 
