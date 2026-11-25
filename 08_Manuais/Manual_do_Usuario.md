# Manual do Usuário — Sistema de Folha de Pagamento

## 1. Requisitos de Ambiente
* **Java Runtime Environment (JRE) ou JDK:** Versão 17 ou superior instalada e configurada no `PATH` do sistema operacional.
* **Terminal:** Prompt de Comando (CMD), PowerShell ou Bash.

---

## 2. Como Executar o Sistema
1. Abra o terminal e entre na pasta `07_Executavel` usando o comando `cd 07_Executavel`.
2. Inicie a aplicação executando `java -jar FolhaPagamento_A3.jar`.
3. O sistema criará automaticamente o arquivo `colaboradores_db.csv` no diretório atual caso ainda não exista e exibirá o menu principal.

---

## 3. Guia de Funcionalidades (Menu Principal)

| Opção | Funcionalidade | Como Utilizar |
| :--- | :--- | :--- |
| **`1`** | **Cadastrar Colaborador** | Informe o tipo (`1-Padrão`, `2-Comissionado` ou `3-Produção`), matrícula numérica única, nome e salário-base. Para Comissionado, informe também total de vendas e percentual; para Produção, informe quantidade produzida e valor unitário. |
| **`2`** | **Consultar Colaboradores** | Exibe a lista completa de colaboradores ativos no CSV com matrícula, nome e categoria. |
| **`3`** | **Excluir Colaborador** | Informe a matrícula do colaborador que deseja remover permanentemente da base. |
| **`4`** | **Gerar Folha Detalhada** | Calcula e exibe o demonstrativo analítico de pagamento de todos os colaboradores cadastrados. |
| **`5`** | **Emitir Resumo da Folha** | Exibe os totalizadores consolidados: quantidade total de colaboradores, montante geral da folha e subtotais por categoria. |
| **`6`** | **Editar Colaborador** | Informe a matrícula existente e preencha em sequência o novo tipo, novo nome, novo salário-base e os parâmetros específicos do novo tipo. |
| **`7`** | **Gerar Folha Individual** | Informe a matrícula de um colaborador específico para consultar seu contracheque detalhado (base, adicional e salário final). |
| **`0`** | **Sair** | Salva os recursos, encerra o programa de forma limpa e retorna ao terminal. |