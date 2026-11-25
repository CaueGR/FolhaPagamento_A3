*** Settings ***
Documentation     Suite de testes de sistema - CT021 (Edicao de Matricula Inexistente)
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
# Caso de Teste      : CT021 - RF009
# Nivel              : Sistema
# Precondicoes       : Matricula 9999 ausente no CSV temporario (contendo apenas 1001)
# Massa de dados     : Opcao 6 (Editar); Matricula 9999; Opcao 0 (Sair)
# Passos/Acao        : Tentar editar matricula inexistente 9999 e encerrar aplicacao
# Resultado esperado : Mensagem informando que a matricula nao foi encontrada; CSV inalterado
# ==============================================================================
CT021 - Editar Matricula Inexistente via Terminal
    [Documentation]    Valida o RF009 garantindo tratamento adequado ao tentar editar matricula inexistente.

    # --------------------------------------------------------------------------
    # ETAPA 1: PREPARACAO DO AMBIENTE E PRECONDICOES
    # --------------------------------------------------------------------------
    Create Directory    ${TEMP_DIR}
    ${massa_csv}=       Catenate    SEPARATOR=\n
    ...    TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
    ...    1,1001,Ana,2000.0,0,0,0,0
    Create File         ${CSV_FILE}    ${massa_csv}\n

    # --------------------------------------------------------------------------
    # ETAPA 2: PREPARACAO DA MASSA DE ENTRADA E EXECUCAO
    # --------------------------------------------------------------------------
    Create File         ${TEMP_DIR}/inputs_ct021.txt    6\n9999\n0\n

    ${result}=          Run Process    java    -jar    ${JAR_PATH}
    ...                 cwd=${TEMP_DIR}
    ...                 stdin=${TEMP_DIR}/inputs_ct021.txt
    ...                 timeout=10s

    # --------------------------------------------------------------------------
    # ETAPA 3: REGISTRO DE EVIDENCIAS (LOGS)
    # --------------------------------------------------------------------------
    Log                 STDOUT: ${result.stdout}
    Log                 STDERR: ${result.stderr}

    # --------------------------------------------------------------------------
    # ETAPA 4: VALIDACAO DOS RESULTADOS ESPERADOS
    # --------------------------------------------------------------------------
    Should Be Equal As Integers    ${result.rc}    0
    Should Contain    ${result.stdout}    encontrad    ignore_case=True

    File Should Exist    ${CSV_FILE}
    ${conteudo_csv}=     Get File    ${CSV_FILE}
    ${csv_esperado}=     Catenate    SEPARATOR=\n
    ...                  TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
    ...                  1,1001,Ana,2000.0,0,0,0,0
    Should Be Equal As Strings    ${conteudo_csv}    ${csv_esperado}\n