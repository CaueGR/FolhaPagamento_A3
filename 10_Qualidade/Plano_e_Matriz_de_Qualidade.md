# Plano de Qualidade e Matriz de Rastreabilidade

## 1. Estratégia e Ferramentas de Teste
A garantia da qualidade do projeto foi estruturada em três níveis complementares:
* **Testes Unitários e de Integração (JUnit 5 + Maven):** Validação isolada das regras de cálculo salarial, validações de negócio (`RN001`–`RN004`), CRUD em memória e persistência no `ColaboradorRepository`.
* **Testes de Sistema e Aceitação (Robot Framework):** Automação caixa-preta via terminal (`stdin`/`stdout`), simulando a operação real do usuário no arquivo executável `.jar` com isolamento de diretório e verificação linha a linha do CSV gerado.
* **Revisão Arquitetural e Usabilidade:** Inspeção estrutural de polimorfismo (`RNF003`) e validação prática do fluxo operacional.

---

## 2. Métricas de Cobertura e Execução
* **Total de Casos de Teste Planejados:** 33 (`CT001` a `CT033`)
* **Casos Automatizados em JUnit 5:** 16 (`CT001`–`CT008`, `CT014`–`CT018`, `CT026`, `CT028`, `CT030`)
* **Casos Automatizados em Robot Framework:** 17 (`CT009`–`CT013`, `CT019`–`CT025`, `CT027`, `CT029`, `CT031`–`CT033`)
* **Taxa de Aprovação:** **100% (33/33 PASS)**

---

## 3. Matriz de Rastreabilidade (Requisitos x Casos de Teste)

| Requisito / Regra | Descrição Resumida | Casos de Teste Associados | Ferramenta / Nível |
| :--- | :--- | :--- | :--- |
| **RF001 / RN001 / RN002** | Cadastro de colaboradores e validações de matrícula/valores | `CT001`–`CT004`, `CT014`–`CT018`, `CT019` | JUnit 5 / Robot |
| **RF002 / RF003 / RF004** | Cálculo salarial Padrão, Comissionado e Produção (`RN003`, `RN004`) | `CT005`, `CT006`, `CT007` | JUnit 5 (Unitário) |
| **RF005** | Consulta de colaboradores cadastrados | `CT020` | Robot (Sistema) |
| **RF006** | Cálculo polimórfico na folha | `CT008` | JUnit 5 (Unitário) |
| **RF007** | Geração da folha detalhada (com base e base vazia) | `CT023`, `CT025` | Robot (Sistema) |
| **RF008** | Emissão do resumo consolidado da folha | `CT024`, `CT025` | Robot (Sistema) |
| **RF009** | Edição e exclusão de colaboradores (válidos e inexistentes) | `CT009`–`CT013`, `CT021`, `CT022`, `CT026` | JUnit 5 / Robot |
| **RF010** | Geração de folha individual por matrícula | `CT033` | Robot (Sistema) |
| **RNF001** | Usabilidade e encerramento limpo da aplicação | `CT027`, `CT031` | Robot (Sistema/E2E) |
| **RNF002** | Robustez contra entradas inválidas no terminal | `CT029` | Robot (Sistema) |
| **RNF003** | Extensibilidade orientada a objetos (polimorfismo) | `CT032` | Robot (Estrutural) |
| **RNF004** | Persistência e recuperação de dados em CSV | `CT028`, `CT030` | JUnit 5 (Integração) |