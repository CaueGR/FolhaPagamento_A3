# Critérios de Aceitação e Massa Base de Referência

## 1. Massa de Dados Padrão (AC01 a AC03)
Para validação funcional e homologação dos cálculos do sistema, utiliza-se a seguinte massa base de referência:

| ID | Matrícula | Nome | Tipo | Salário-Base | Parâmetros Específicos | Salário Final Esperado |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **AC01** | `1001` | Ana | Padrão (`1`) | R$ 2.000,00 | — | **R$ 2.000,00** |
| **AC02** | `1002` | Bruno | Comissionado (`2`) | R$ 2.000,00 | Vendas: R$ 10.000,00 \| Percentual: `5%` | **R$ 2.500,00** |
| **AC03** | `1003` | Carla | Produção (`3`) | R$ 1.500,00 | Quantidade: `100` \| Valor/Unidade: R$ 10,00 | **R$ 2.500,00** |

### Totalizadores Esperados (Resumo da Folha — RF008)
* **Quantidade Total de Colaboradores:** `3`
* **Total Geral da Folha:** **R$ 7.000,00** (`2.000,00 + 2.500,00 + 2.500,00`)

---

## 2. Condições de Aceite para Homologação
1. **Persistência Íntegra:** Todas as operações de inclusão, edição e exclusão refletem imediatamente no arquivo `colaboradores_db.csv` respeitando o formato `TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE`.
2. **Tratamento de Exceções de Negócio:** Tentativas de consulta, edição, exclusão ou geração de folha individual para matrículas inexistentes (ex: `9999`) devem retornar aviso amigável sem alterar o banco CSV.
3. **Base Vazia:** A emissão de folha detalhada ou resumo com o CSV vazio deve informar a ausência de registros sem exibir valores `NaN`, `null` ou falhas de execução.
4. **Cobertura de Testes:** 100% dos 33 casos de teste planejados (`CT001` a `CT033`) executados e aprovados (`PASS`).