# Especificação de Casos de Uso — Sistema de Folha de Pagamento

## 1. Ator Principal
* **Operador / Analista de RH:** Usuário responsável por cadastrar, consultar, alterar, excluir colaboradores e emitir os demonstrativos da folha de pagamento via terminal.

---

## 2. Resumo dos Casos de Uso
* **UC01:** Cadastrar Colaborador (`RF001`, `RN001`, `RN002`)
* **UC02:** Consultar Colaboradores (`RF005`)
* **UC03:** Editar Colaborador (`RF009`, `RN002`)
* **UC04:** Excluir Colaborador (`RF009`)
* **UC05:** Gerar Folha Detalhada (`RF002`, `RF003`, `RF004`, `RF006`, `RF007`)
* **UC06:** Emitir Resumo da Folha (`RF008`)
* **UC07:** Encerrar Aplicação (`RNF001`)
* **UC08:** Gerar Folha Individual (`RF010`)

---

## 3. Detalhamento dos Casos de Uso

### UC01 — Cadastrar Colaborador (RF001, RN001, RN002)
* **Objetivo:** Registrar um novo colaborador na base CSV.
* **Fluxo Principal:**
  1. O operador seleciona a opção `1. Cadastrar Colaborador`.
  2. O sistema solicita o tipo (`1-Padrão`, `2-Comissionado`, `3-Produção`), matrícula, nome e salário-base.
  3. Caso seja Comissionado (`2`), solicita total de vendas e percentual de comissão. Caso seja Produção (`3`), solicita quantidade produzida e valor por unidade.
  4. O sistema valida a unicidade da matrícula e valores não negativos, grava o registro em `colaboradores_db.csv` e exibe `[OK] Colaborador <Nome> cadastrado com sucesso.`.
* **Fluxos Alternativos:**
  * **Matrícula duplicada:** Exibe mensagem de erro informando que a matrícula já existe e aborta o cadastro.
  * **Entrada inválida / valor negativo:** Exibe aviso de validação e retorna ao menu sem corromper o CSV.

### UC02 — Consultar Colaboradores (RF005)
* **Objetivo:** Listar todos os colaboradores ativos no arquivo CSV.
* **Fluxo Principal:**
  1. O operador seleciona a opção `2. Consultar Colaboradores`.
  2. O sistema lê o arquivo `colaboradores_db.csv` e imprime matrícula, nome e categoria de cada registro.
* **Fluxo Alternativo:**
  * **Base vazia:** Informa que não há colaboradores cadastrados.

### UC03 — Editar Colaborador (RF009, RN002)
* **Objetivo:** Atualizar dados cadastrais ou alterar a categoria de remuneração de um colaborador existente.
* **Fluxo Principal:**
  1. O operador seleciona a opção `6. Editar Colaborador` e informa a matrícula.
  2. O sistema localiza o registro e solicita o novo tipo, novo nome, novo salário-base e os parâmetros específicos do novo tipo.
  3. O sistema sobrescreve o registro atualizado no `colaboradores_db.csv` e exibe `[OK] Colaborador <Nome> atualizado com sucesso.`.
* **Fluxo Alternativo:**
  * **Matrícula inexistente:** Exibe mensagem informando que a matrícula não foi encontrada e mantém o CSV inalterado.

### UC04 — Excluir Colaborador (RF009)
* **Objetivo:** Remover permanentemente um colaborador da base CSV.
* **Fluxo Principal:**
  1. O operador seleciona a opção `3. Excluir Colaborador` e informa a matrícula.
  2. O sistema remove o registro correspondente do arquivo `colaboradores_db.csv` e confirma a exclusão.
* **Fluxo Alternativo:**
  * **Matrícula inexistente:** Exibe mensagem de matrícula não encontrada e mantém o arquivo intacto.

### UC05 — Gerar Folha Detalhada (RF002, RF003, RF004, RF006, RF007)
* **Objetivo:** Exibir o demonstrativo analítico de pagamento de todos os colaboradores.
* **Fluxo Principal:**
  1. O operador seleciona a opção `4. Gerar Folha Detalhada`.
  2. O sistema instancia os objetos conforme a categoria e invoca o cálculo polimórfico `calcularSalario()`.
  3. Exibe cada colaborador com salário-base, adicionais e salário final formatado.
* **Fluxo Alternativo:**
  * **Base vazia:** Exibe aviso informativo de ausência de registros sem gerar valores `NaN` ou `null`.

### UC06 — Emitir Resumo da Folha (RF008)
* **Objetivo:** Apresentar os indicadores consolidados da folha mensal.
* **Fluxo Principal:**
  1. O operador seleciona a opção `5. Emitir Resumo da Folha`.
  2. O sistema totaliza a quantidade de colaboradores, o montante geral da folha e os subtotais por categoria (`Padrão`, `Comissionado`, `Produção`).

### UC07 — Encerrar Aplicação (RNF001)
* **Objetivo:** Finalizar a execução do programa de forma segura.
* **Fluxo Principal:**
  1. O operador seleciona a opção `0. Sair`.
  2. O sistema libera os recursos de leitura (`Scanner`), exibe `Encerrando...` e finaliza com código de saída `0`.

### UC08 — Gerar Folha Individual (RF010)
* **Objetivo:** Consultar o contracheque/demonstrativo detalhado de um único colaborador.
* **Fluxo Principal:**
  1. O operador seleciona a opção `7. Gerar Folha Individual` e informa a matrícula desejada.
  2. O sistema exibe matrícula, nome, tipo, salário-base, valor adicional (comissão ou produção) e salário final.
* **Fluxo Alternativo:**
  * **Matrícula inexistente:** Informa que a matrícula não foi localizada.