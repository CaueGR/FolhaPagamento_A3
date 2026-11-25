*** Settings ***
Documentation     Suite de testes de sistema - CT011 (Edicao de Tipo de Colaborador)
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
# Caso de Teste      : CT011 - RF009
# Nivel              : Sistema
# Precondicoes       : Matricula 1001 (Padrao, base 2000.0) existente no CSV
# Massa de dados     : Opcao 6; 1001; Tipo 2 (Comissionado); Ana; Base 2000; Vendas 10000; Percentual 5; Opcao 4; Opcao 0
# Passos/Acao        : Alterar tipo de 1001 para comissionado, gerar folha detalhada e encerrar
# Resultado esperado : Tipo e campos especificos atualizados no CSV; salario final calculado (2500,00)
# ==============================================================================
CT011 - Editar Tipo de Colaborador via Terminal
    [Documentation]    Valida o RF009 convertendo colaborador 1001 de Padrao para Comissionado.

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
    # Editar (6) -> 1001 -> Tipo 2 -> Ana -> Base 2000 -> Vendas 10000 -> Perc 5 -> Folha (4) -> Sair (0)
    Create File         ${TEMP_DIR}/inputs_ct011.txt    6\n1001\n2\nAna\n2000\n10000\n5\n4\n0\n

    ${result}=          Run Process    java    -jar    ${JAR_PATH}
    ...                 cwd=${TEMP_DIR}
    ...                 stdin=${TEMP_DIR}/inputs_ct011.txt
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
    Should Contain    ${result.stdout}    2500

    # Confere persistencia exata no CSV
    File Should Exist    ${CSV_FILE}
    ${conteudo_csv}=     Get File    ${CSV_FILE}
    ${csv_esperado}=     Catenate    SEPARATOR=\n
    ...                  TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
    ...                  2,1001,Ana,2000.0,10000.0,5.0,0,0
    Should Be Equal As Strings    ${conteudo_csv}    ${csv_esperado}\n