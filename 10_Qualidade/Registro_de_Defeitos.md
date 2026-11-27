# Registro de Defeitos — Sistema de Folha de Pagamento

Este documento registra as não conformidades e defeitos identificados durante os ciclos de testes unitários, de integração e de sistema, bem como suas respectivas correções antes da homologação final.

| ID | Descrição do Defeito | Severidade | Prioridade | Status | Solução Aplicada |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **DEF-001** | **Quebra de execução (`InputMismatchException`)** ao digitar letras em campos numéricos no menu principal ou cadastro (`CT029`). | Alta | Alta | **Fechado / Corrigido** | Implementado tratamento de exceção na leitura do `Scanner` em `Main.java` com limpeza de buffer e mensagem amigável ao usuário. |
| **DEF-002** | **Acoplamento do caminho do CSV** no diretório raiz dificultava o isolamento durante execuções paralelas de testes (`CT028` / `CT030`). | Média | Alta | **Fechado / Corrigido** | Ajustada a resolução do arquivo `colaboradores_db.csv` relativa ao diretório de trabalho (`cwd`), permitindo isolamento por pasta temporária (`temp_test_dir`). |
| **DEF-003** | **Exibição de relatório com base vazia** não apresentava mensagem orientativa clara antes da validação do `CT025`. | Baixa | Média | **Fechado / Corrigido** | Adicionada verificação prévia de lista vazia em `FolhaPagamentoService` exibindo aviso informativo sem valores nulos ou `NaN`. |
| **DEF-004** | **Persistência parcial em falha de escrita** poderia deixar o CSV inconsistente em caso de interrupção de I/O. | Alta | Média | **Fechado / Corrigido** | Implementada gravação em arquivo temporário seguida de substituição atômica (`Files.move` com `ATOMIC_MOVE`) no `ColaboradorRepository`. |