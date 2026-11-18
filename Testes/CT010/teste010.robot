*** Settings ***
Documentation     Suite de testes de sistema - CT010 (Edicao de Salario-Base)
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
# Caso de Teste      : CT010 - RF009
# Nivel              : Sistema
# Precondicoes       : Matricula 1001 (Ana, Padrao, base 2000.0) existente no CSV
# Massa de dados     : Opcao 6; Matricula 1001; Tipo 1; Nome Ana; Salario 2200; Opcao 4; Opcao 0
# Passos/Acao        : Editar salario-base de 2000 para 2200, gerar folha detalhada e encerrar
# Resultado esperado : Base e salario final atualizados para 2200,00 no CSV e na folha
# ==============================================================================
CT010 - Editar Salario-Base de Colaborador via Terminal
    [Documentation]    Valida o RF009 alterando o salario-base da matricula 1001 para 2200 e conferindo a folha.

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
    # Editar (6) -> 1001 -> Tipo 1 -> Ana -> Novo Salario 2200 -> Folha Detalhada (4) -> Sair (0)
    Create File         ${TEMP_DIR}/inputs_ct010.txt    6\n1001\n1\nAna\n2200\n4\n0\n

    ${result}=          Run Process    java    -jar    ${JAR_PATH}
    ...                 cwd=${TEMP_DIR}
    ...                 stdin=${TEMP_DIR}/inputs_ct010.txt
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
    Should Contain    ${result.stdout}    2200

    # Confere persistencia exata no CSV
    File Should Exist    ${CSV_FILE}
    ${conteudo_csv}=     Get File    ${CSV_FILE}
    ${csv_esperado}=     Catenate    SEPARATOR=\n
    ...                  TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
    ...                  1,1001,Ana,2200.0,0,0,0,0
    Should Be Equal As Strings    ${conteudo_csv}    ${csv_esperado}\n