*** Settings ***
Documentation     Suite de testes de sistema - CT024 (Emitir Resumo da Folha)
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
# Caso de Teste      : CT024 - RF008
# Nivel              : Sistema
# Precondicoes       : Massa AC01-AC03 cadastrada no CSV (matriculas 1001, 1002 e 1003)
# Massa de dados     : Opcao 5 (Emitir Resumo da Folha) e Opcao 0 (Sair)
# Passos/Acao        : Executar aplicacao, selecionar opcao 5 e encerrar
# Resultado esperado : Quantidade = 3; total geral = 7000,00; totais por categoria corretos
# ==============================================================================
CT024 - Emitir Resumo da Folha via Terminal
    [Documentation]    Valida o RF008 exibindo os totalizadores consolidados da folha de pagamento.

    # --------------------------------------------------------------------------
    # ETAPA 1: PREPARACAO DO AMBIENTE E PRECONDICOES
    # --------------------------------------------------------------------------
    Create Directory    ${TEMP_DIR}
    ${massa_csv}=       Catenate    SEPARATOR=\n
    ...    TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
    ...    1,1001,Ana,2000.0,0,0,0,0
    ...    2,1002,Bruno,2000.0,10000.0,5.0,0,0
    ...    3,1003,Carla,1500.0,0,0,100,10.0
    Create File         ${CSV_FILE}    ${massa_csv}\n

    # --------------------------------------------------------------------------
    # ETAPA 2: PREPARACAO DA MASSA DE ENTRADA E EXECUCAO
    # --------------------------------------------------------------------------
    Create File         ${TEMP_DIR}/inputs_ct024.txt    5\n0\n

    ${result}=          Run Process    java    -jar    ${JAR_PATH}
    ...                 cwd=${TEMP_DIR}
    ...                 stdin=${TEMP_DIR}/inputs_ct024.txt
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

    # Verifica quantidade total de colaboradores e o montante geral (2000 + 2500 + 2500)
    Should Contain    ${result.stdout}    3
    Should Contain    ${result.stdout}    7000