# Arquitetura e Projeto Orientado a Objetos — Folha de Pagamento

## 1. Arquitetura em Camadas
O sistema segue uma arquitetura modular em Java organizada em pacotes dentro de `src/main/java/`:

* **`Main.java` (Camada de Apresentação / CLI):** Gerencia o loop do menu principal (`0` a `7`), captura entradas do usuário via `Scanner`, trata exceções de entrada (`RNF002`) e delega operações aos serviços.
* **`service` (Camada de Regras de Negócio):**
  * `CadastroService`: Orquestra validação de regras de negócio (`RN001`, `RN002`) e operações CRUD.
  * `FolhaPagamentoService`: Executa o processamento da folha detalhada, resumo consolidado e folha individual de forma polimórfica.
* **`entities` (Camada de Domínio):** Modela a hierarquia de colaboradores aplicando herança e polimorfismo (`RNF003`).
* **`repository` (Camada de Persistência):**
  * `ColaboradorRepository`: Realiza leitura, escrita e atualização no arquivo texto estruturado `colaboradores_db.csv` (`RNF004`).
* **`dto` (Transferência de Dados):**
  * `ColaboradorDTO`: Encapsula os dados brutos trafegados entre a interface CLI, serviços e persistência CSV.

---

## 2. Hierarquia de Classes (Orientação a Objetos)

* **`Colaborador` (Classe Abstrata):**
  * **Atributos:** `matricula` (`int`), `nome` (`String`), `salarioBase` (`double`)
  * **Métodos:** `getTipo()`, `calcularAdicional()`, `calcularSalario()`
* **`ColaboradorPadrao` (Estende `Colaborador`):**
  * Salário final igual ao `salarioBase`.
* **`ColaboradorComissionado` (Estende `Colaborador`):**
  * **Atributos extras:** `totalVendas` (`double`), `percentualComissao` (`double`)
  * Salário final = `salarioBase + (totalVendas * percentualComissao / 100)`.
* **`ColaboradorProducao` (Estende `Colaborador`):**
  * **Atributos extras:** `quantidadeProduzida` (`int`), `valorPorUnidade` (`double`)
  * Salário final = `salarioBase + (quantidadeProduzida * valorPorUnidade)`.

---

## 3. Decisões de Projeto (Extensibilidade — RNF003)
* **Polimorfismo no Cálculo Salarial:** O `FolhaPagamentoService` interage exclusivamente com a abstração `Colaborador`. Para adicionar uma nova categoria (ex.: `ColaboradorTemporario`), basta criar uma nova subclasse estendendo `Colaborador` e implementar `calcularSalario()`, sem necessidade de alterar a lógica principal da folha.