# Relatório de Revisão Técnica — Folha de Pagamento (A3)

## 1. Objetivo da Revisão
Avaliar a qualidade estrutural do código-fonte Java, a aderência aos princípios de Orientação a Objetos, a integridade da persistência em CSV e a cobertura da suíte de testes antes da homologação final.

---

## 2. Não Conformidades e Problemas Encontrados
1. **Tratamento de Entradas no Terminal (`RNF002`):** Na versão inicial, entradas não numéricas encerravam a JVM com `InputMismatchException`.
2. **Validação de Regras de Negócio (`RN001` e `RN002`):** Necessidade de reforçar o bloqueio de matrículas duplicadas e valores negativos tanto na camada de entidade quanto no serviço de cadastro.
3. **Padronização Documental:** Ausência inicial da estrutura oficial de pastas (`01_Requisitos` a `11_Apresentacao`) e de evidências centralizadas de execução.

---

## 3. Correções Realizadas
* **Resiliência da CLI:** Blindagem das leituras do `Scanner` em `Main.java` com mensagens de erro padronizadas (`[ERRO]`).
* **Refatoração Orientada a Objetos (`RNF003`):** Garantia de que `FolhaPagamentoService` depende apenas da classe abstrata `Colaborador`, eliminando verificações condicionais de tipo.
* **Automação Integral (33/33 CTs):** Implementação de 16 testes unitários/integração em JUnit 5 e 17 testes de sistema/aceitação em Robot Framework com geração automática de `log.html` e `report.html`.
* **Reorganização do Repositório:** Estruturação completa das 11 pastas exigidas e atualização do `README.md`.

---

## 4. Lições Aprendidas
* **Polimorfismo reduz retrabalho:** Modelar as regras salariais nas subclasses de `Colaborador` simplificou tanto os testes unitários quanto a manutenção da folha.
* **Isolamento de massa garante determinismo:** Utilizar diretórios temporários e arquivos CSV dedicados por caso de teste no Robot Framework evitou falsos positivos e contaminação entre execuções.
* **Rastreabilidade contínua:** Vincular cada requisito (`RF`/`RN`/`RNF`) diretamente a casos de teste (`CT001`–`CT033`) assegurou que nenhum critério do cliente ficasse sem verificação.