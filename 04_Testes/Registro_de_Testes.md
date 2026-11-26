# Registro de testes unitários — Sistema de Folha de Pagamento

Em 24/11/2026, às 20h11 (horário de Brasília), o Maven executou os 11 testes unitários previstos no plano. **Todos passaram**, com zero falhas, erros ou testes ignorados.

## Preparação e execução

Organizamos o código da aplicação em `src/main/java` e os testes em `src/test/java`. O projeto usa Java 21, Maven e JUnit Jupiter 5.12.2.

Em 10/11, o Maven falhou ao acessar o repositório local de dependências. Depois de configurar o caminho `C:\maven-repository` no IntelliJ, conseguimos compilar os nove arquivos da aplicação e executar o CT001. Em 18/11, acrescentamos o CT002 e o CT003. A rodada de 24/11 reuniu os 11 casos.

Para repetir a execução no IntelliJ, abra **Maven → Lifecycle → test**. O Surefire gera os relatórios em `target/surefire-reports/`.

## Resultados por caso

Os links abrem a pasta com os relatórios XML e TXT de cada caso. Nos testes de rejeição, verificamos se a entrada inválida provocava `IllegalArgumentException`.

| Caso | Requisito | Resultado observado |
|---|---|---|
| [CT001](Evidencias/CT001/) | RF002 e RF006 | Com salário-base de R$ 2.000,00, o colaborador padrão recebeu salário final de R$ 2.000,00. |
| [CT002](Evidencias/CT002/) | RN003 | O construtor rejeitou o salário-base de −R$ 500,00. |
| [CT003](Evidencias/CT003/) | RF003 e RF006 | Sobre R$ 10.000,00 em vendas, a comissão de 5% foi de R$ 500,00. Somada à base de R$ 2.000,00, resultou em salário final de R$ 2.500,00. |
| [CT004](Evidencias/CT004/) | RF004 e RF006 | A produção de 100 unidades a R$ 10,00 gerou um adicional de R$ 1.000,00. Com a base de R$ 1.500,00, o salário final foi de R$ 2.500,00. |
| [CT005](Evidencias/CT005/) | RN002 | O construtor rejeitou tanto o nome vazio (`""`) quanto o nome nulo (`null`). |
| [CT007](Evidencias/CT007/) | RNF002 | Ao receber o tipo `9`, o serviço retornou a mensagem “Tipo de colaborador inválido.”. O Mockito confirmou que `salvar()` não foi chamado. |
| [CT015](Evidencias/CT015/) | RN004 | O colaborador comissionado rejeitou o valor de vendas de −R$ 1,00. |
| [CT016](Evidencias/CT016/) | RN005 | O colaborador comissionado rejeitou o percentual de comissão de −1%. |
| [CT017](Evidencias/CT017/) | RN006 | O colaborador por produção rejeitou `-1` como quantidade produzida. |
| [CT018](Evidencias/CT018/) | RN007 | O colaborador por produção rejeitou o valor de −R$ 1,00 por unidade. |
| [CT028](Evidencias/CT028/) | RN003 a RN007 | Os três tipos de colaborador aceitaram salário-base zero. Com vendas, percentual de comissão, quantidade e valor por unidade também zerados nos tipos correspondentes, cada cálculo retornou R$ 0,00. |

A medição da cobertura de código ficou pendente após essa rodada.