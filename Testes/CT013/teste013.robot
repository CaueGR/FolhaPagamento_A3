*** Settings ***
Documentation     Suite de testes de sistema - CT013 (Edicao de Quantidade Produzida)
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
# Caso de Teste      : CT013 - RF009
# Nivel              : Sistema
# Precondicoes       : Producao 1003 (Carla, base 1500, qtd 100, valor unidade 10) no CSV
# Massa de dados     : Opcao 6; 1003; Tipo 3; Carla; Base 1500; Qtd 120; Valor 10; Opcao 4; Opcao 0
# Passos/Acao        : Editar quantidade produzida de 100 para 120, gerar folha detalhada e encerrar
# Resultado esperado : CSV atualizado e salario final recalculado para 2700,00
# ==============================================================================
CT013 - Editar Quantidade Produzida via Terminal
    [Documentation]    Valida o RF009 alterando a quantidade produzida do colaborador 1003 para 120.

    # --------------------------------------------------------------------------
    # ETAPA 1: PREPARACAO DO AMBIENTE E PRECONDICOES
    # --------------------------------------------------------------------------
    Create Directory    ${TEMP_DIR}
    ${massa_csv}=       Catenate    SEPARATOR=\n
    ...    TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
    ...    3,1003,Carla,1500.0,0,0,100,10.0
    Create File         ${CSV_FILE}    ${massa_csv}\n

    # --------------------------------------------------------------------------
    # ETAPA 2: PREPARACAO DA MASSA DE ENTRADA E EXECUCAO
    # --------------------------------------------------------------------------
    # Editar (6) -> 1003 -> Tipo 3 -> Carla -> Base 1500 -> Qtd 120 -> Valor 10 -> Folha (4) -> Sair (0)
    Create File         ${TEMP_DIR}/inputs_ct013.txt    6\n1003\n3\nCarla\n1500\n120\n10\n4\n0\n

    ${result}=          Run Process    java    -jar    ${JAR_PATH}
    ...                 cwd=${TEMP_DIR}
    ...                 stdin=${TEMP_DIR}/inputs_ct013.txt
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
    Should Contain    ${result.stdout}    2700

    # Confere persistencia exata no CSV
    File Should Exist    ${CSV_FILE}
    ${conteudo_csv}=     Get File    ${CSV_FILE}
    ${csv_esperado}=     Catenate    SEPARATOR=\n
    ...                  TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
    ...                  3,1003,Carla,1500.0,0,0,120,10.0
    Should Be Equal As Strings    ${conteudo_csv}    ${csv_esperado}\n