*** Settings ***
Documentation     Suite de testes de sistema - CT025 (Folha e Resumo com CSV Vazio)
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
# Caso de Teste      : CT025 - RF007/RF008
# Nivel              : Sistema
# Precondicoes       : CSV temporario vazio (sem colaboradores cadastrados)
# Massa de dados     : Opcao 4 (Folha Detalhada); Opcao 5 (Resumo da Folha); Opcao 0 (Sair)
# Passos/Acao        : Executar opcoes 4 e 5 sem registros cadastrados e encerrar
# Resultado esperado : Mensagem informativa de ausencia de dados; sem erro ou valores indefinidos
# ==============================================================================
CT025 - Emitir Relatorios com Base Vazia via Terminal
    [Documentation]    Valida RF007 e RF008 quando nao existem colaboradores cadastrados.

    # --------------------------------------------------------------------------
    # ETAPA 1: PREPARACAO DO AMBIENTE E PRECONDICOES
    # --------------------------------------------------------------------------
    Create Directory    ${TEMP_DIR}
    Remove File         ${CSV_FILE}

    # --------------------------------------------------------------------------
    # ETAPA 2: PREPARACAO DA MASSA DE ENTRADA E EXECUCAO
    # --------------------------------------------------------------------------
    Create File         ${TEMP_DIR}/inputs_ct025.txt    4\n5\n0\n

    ${result}=          Run Process    java    -jar    ${JAR_PATH}
    ...                 cwd=${TEMP_DIR}
    ...                 stdin=${TEMP_DIR}/inputs_ct025.txt
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

    # Verifica ausencia de valores indefinidos ou excecoes no terminal
    Should Not Contain    ${result.stdout}    NaN
    Should Not Contain    ${result.stdout}    null
    Should Not Contain    ${result.stdout}    Exception