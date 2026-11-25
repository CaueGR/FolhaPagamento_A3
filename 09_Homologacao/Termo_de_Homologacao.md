# Termo de Homologação e Aceite — Folha de Pagamento (A3)

## 1. Identificação do Projeto
* **Sistema:** Sistema de Folha de Pagamento (CLI Java)
* **Versão Homologada:** `1.0.0` (`07_Executavel/FolhaPagamento_A3.jar`)
* **Data de Homologação:** 25/11/2026
* **Equipe Responsável:** João Corso Sadowoy Martins, Caio Eduardo Pinto Maia, Cauê Garcia Robattini, Eduardo Gonçalves Nunes

---

## 2. Checklist de Critérios de Aceitação (AC01 a AC03)

| Critério | Descrição | Resultado Esperado | Status |
| :--- | :--- | :--- | :--- |
| **AC01** | Cálculo Colaborador Padrão (`1001` - Ana, base R$ 2.000,00) | Salário Final = **R$ 2.000,00** | **APROVADO** |
| **AC02** | Cálculo Colaborador Comissionado (`1002` - Bruno, base R$ 2.000,00, vendas R$ 10.000,00, 5%) | Salário Final = **R$ 2.500,00** | **APROVADO** |
| **AC03** | Cálculo Colaborador Produção (`1003` - Carla, base R$ 1.500,00, 100 un. x R$ 10,00) | Salário Final = **R$ 2.500,00** | **APROVADO** |
| **Geral** | Resumo Consolidado da Folha (Massa AC01–AC03) | Total = 3 colaboradores \| Montante = **R$ 7.000,00** | **APROVADO** |
| **Integridade** | Persistência em `colaboradores_db.csv` e tratamento de exceções | Sem corrupção de dados ou falhas (`Exception`) | **APROVADO** |

---

## 3. Parecer Final
Todos os requisitos funcionais (`RF001`–`RF010`), regras de negócio (`RN001`–`RN004`) e requisitos não funcionais (`RNF001`–`RNF004`) foram verificados através da execução integral dos **33 casos de teste** planejados (100% de aprovação). O sistema encontra-se **HOMOLOGADO** para entrega.