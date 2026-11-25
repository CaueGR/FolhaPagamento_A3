*** Settings ***
Documentation     Suite de testes de sistema - CT033 (Gerar Folha Individual)
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
# Caso de Teste      : CT033 - RF010/UC08
# Nivel              : Sistema
# Precondicoes       : Matricula 1002 (Bruno, Comissionado) disponivel no CSV
# Massa de dados     : Opcao 7; Matricula 1002; Opcao 7; Matricula 9999; Opcao 0
# Passos/Acao        : Emitir folha individual para 1002 e testar aviso para 9999
# Resultado esperado : Exibe matricula, tipo, base, adicional e final (2500); aviso para inexistente
# ==============================================================================
CT033 - Gerar Folha Individual via Terminal
    [Documentation]    Valida o RF010 gerando a folha individual de matricula existente e inexistente.

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
    # Folha Individual (7) -> 1002 -> Folha Individual (7) -> 9999 -> Sair (0)
    Create File         ${TEMP_DIR}/inputs_ct033.txt    7\n1002\n7\n9999\n0\n

    ${result}=          Run Process    java    -jar    ${JAR_PATH}
    ...                 cwd=${TEMP_DIR}
    ...                 stdin=${TEMP_DIR}/inputs_ct033.txt
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

    # Verifica exibicao dos dados da folha individual da matricula 1002
    Should Contain    ${result.stdout}    1002
    Should Contain    ${result.stdout}    Bruno
    Should Contain    ${result.stdout}    Comissionado
    Should Contain    ${result.stdout}    2000
    Should Contain    ${result.stdout}    500
    Should Contain    ${result.stdout}    2500

    # Verifica aviso para matricula inexistente (9999)
    Should Contain    ${result.stdout}    encontrad    ignore_case=True