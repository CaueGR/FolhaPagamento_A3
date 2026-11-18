*** Settings ***
Documentation     Suite de testes de sistema - CT012 (Edicao de Vendas de Comissionado)
Library           Process
Library           OperatingSystem

*** Variables ***
${JAR_PATH}       D:/A3Qualidade/FolhaPagamento_A3/FolhaPagamento_A3_jar/FolhaPagamento_A3.jar
${TEMP_DIR}       ${CURDIR}/temp_test_dir
${CSV_FILE}       ${TEMP_DIR}/colaboradores_db.csv

*** Test Cases ***
# ==============================================================================
# TEST DESCRIPTION
# ------------------------------------------------------------------------------
# Caso de Teste      : CT012 - RF009
# Nivel              : Sistema
# Precondicoes       : Comissionado 1002 (Bruno, base 2000, vendas 10000, perc 5) no CSV
# Massa de dados     : Opcao 6; 1002; Tipo 2; Bruno; Base 2000; Vendas 12000; Perc 5; Opcao 4; Opcao 0
# Passos/Acao        : Editar vendas de 10000 para 12000, gerar folha detalhada e encerrar
# Resultado esperado : CSV atualizado e salario final recalculado para 2600,00
# ==============================================================================
CT012 - Editar Vendas de Colaborador Comissionado via Terminal
    [Documentation]    Valida o RF009 alterando as vendas do colaborador 1002 para 12000.

    # --------------------------------------------------------------------------
    # ETAPA 1: PREPARACAO DO AMBIENTE E PRECONDICOES
    # --------------------------------------------------------------------------
    Create Directory    ${TEMP_DIR}
    ${massa_csv}=       Catenate    SEPARATOR=\n
    ...    TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
    ...    2,1002,Bruno,2000.0,10000.0,5.0,0,0
    Create File         ${CSV_FILE}    ${massa_csv}\n

    # --------------------------------------------------------------------------
    # ETAPA 2: PREPARACAO DA MASSA DE ENTRADA E EXECUCAO
    # --------------------------------------------------------------------------
    # Editar (6) -> 1002 -> Tipo 2 -> Bruno -> Base 2000 -> Vendas 12000 -> Perc 5 -> Folha (4) -> Sair (0)
    Create File         ${TEMP_DIR}/inputs_ct012.txt    6\n1002\n2\nBruno\n2000\n12000\n5\n4\n0\n

    ${result}=          Run Process    java    -jar    ${JAR_PATH}
    ...                 cwd=${TEMP_DIR}
    ...                 stdin=${TEMP_DIR}/inputs_ct012.txt
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
    Should Contain    ${result.stdout}    atualizado com sucesso
    Should Contain    ${result.stdout}    2600

    # Confere persistencia exata no CSV
    File Should Exist    ${CSV_FILE}
    ${conteudo_csv}=     Get File    ${CSV_FILE}
    ${csv_esperado}=     Catenate    SEPARATOR=\n
    ...                  TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
    ...                  2,1002,Bruno,2000.0,12000.0,5.0,0,0
    Should Be Equal As Strings    ${conteudo_csv}    ${csv_esperado}\n