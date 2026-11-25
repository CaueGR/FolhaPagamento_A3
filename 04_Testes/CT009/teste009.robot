*** Settings ***
Documentation     Suite de testes de sistema - CT009 (Edicao de Nome de Colaborador)
Library           Process
Library           OperatingSystem

*** Variables ***
${JAR_PATH}       ${CURDIR}/../../FolhaPagamento_A3_jar/FolhaPagamento_A3.jar
${TEMP_DIR}       ${CURDIR}/temp_test_dir
${CSV_FILE}       ${TEMP_DIR}/colaboradores_db.csv

*** Test Cases ***
# ==============================================================================
# TEST DESCRIPTION
# ------------------------------------------------------------------------------
# Caso de Teste      : CT009 - RF009
# Nivel              : Sistema
# Precondicoes       : Matricula 1001 (Ana) existente no CSV temporario
# Massa de dados     : Opcao 6; Matricula 1001; Tipo 1; Nome "Ana Souza"; Salario 2000; Opcao 2; Opcao 0
# Passos/Acao        : Editar o nome do colaborador 1001 para "Ana Souza", consultar e encerrar
# Resultado esperado : Nome atualizado no CSV e exibido na consulta; matricula 1001 preservada
# ==============================================================================
CT009 - Editar Nome de Colaborador via Terminal
    [Documentation]    Valida o RF009 alterando o nome da matricula 1001 de Ana para Ana Souza.

    # --------------------------------------------------------------------------
    # ETAPA 1: PREPARACAO DO AMBIENTE E PRECONDICOES
    # --------------------------------------------------------------------------
    # Cria o diretorio temporario isolado e popula o CSV com a matricula 1001 (Ana)
    Create Directory    ${TEMP_DIR}
    ${massa_csv}=       Catenate    SEPARATOR=\n
    ...    TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
    ...    1,1001,Ana,2000.0,0,0,0,0
    Create File         ${CSV_FILE}    ${massa_csv}\n

    # --------------------------------------------------------------------------
    # ETAPA 2: PREPARACAO DA MASSA DE ENTRADA E EXECUCAO
    # --------------------------------------------------------------------------
    # Simula: Editar (6) -> Matricula (1001) -> Tipo (1) -> Nome (Ana Souza) -> Salario (2000) -> Consultar (2) -> Sair (0)
    Create File         ${TEMP_DIR}/inputs_ct009.txt    6\n1001\n1\nAna Souza\n2000\n2\n0\n

    # Inicia o processo Java isolado dentro da pasta temporaria
    ${result}=          Run Process    java    -jar    ${JAR_PATH}
    ...                 cwd=${TEMP_DIR}
    ...                 stdin=${TEMP_DIR}/inputs_ct009.txt
    ...                 timeout=10s

    # --------------------------------------------------------------------------
    # ETAPA 3: REGISTRO DE EVIDENCIAS (LOGS)
    # --------------------------------------------------------------------------
    # Grava a saida padrao e de erro no log.html para rastreabilidade
    Log                 STDOUT: ${result.stdout}
    Log                 STDERR: ${result.stderr}

    # --------------------------------------------------------------------------
    # ETAPA 4: VALIDACAO DOS RESULTADOS ESPERADOS
    # --------------------------------------------------------------------------
    # Verifica encerramento limpo da aplicacao (codigo 0)
    Should Be Equal As Integers    ${result.rc}    0

    # Confirma a atualizacao e a linha exibida especificamente pela consulta
    Should Contain    ${result.stdout}    atualizado com sucesso
    Should Contain    ${result.stdout}    1001 | Nome: Ana Souza | Tipo:

    # Confere o CSV inteiro para detectar campos alterados ou registros extras
    File Should Exist    ${CSV_FILE}
    ${conteudo_csv}=     Get File    ${CSV_FILE}
    ${csv_esperado}=     Catenate    SEPARATOR=\n
    ...                  TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
    ...                  1,1001,Ana Souza,2000.0,0,0,0,0
    Should Be Equal As Strings    ${conteudo_csv}    ${csv_esperado}\n