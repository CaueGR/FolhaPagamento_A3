*** Settings ***
Documentation     Suite de testes de sistema - CT020 (Consulta de Colaboradores)
Library           Process
Library           OperatingSystem
Library           String

*** Variables ***
${JAR_PATH}       ${CURDIR}/../../FolhaPagamento_A3_jar/FolhaPagamento_A3.jar
${TEMP_DIR}       ${CURDIR}/temp_test_dir
${CSV_FILE}       ${TEMP_DIR}/colaboradores_db.csv

*** Test Cases ***
# ==============================================================================
# TEST DESCRIPTION
# ------------------------------------------------------------------------------
# Caso de Teste      : CT020 - RF005
# Nivel              : Sistema
# Precondicoes       : CSV temporario pre-carregado com matriculas 1001, 1002 e 1003
# Massa de dados     : Opcao 2 (Consultar Colaboradores) e Opcao 0 (Sair)
# Passos/Acao        : Executar aplicacao, selecionar opcao 2 e encerrar com 0
# Resultado esperado : Tres registros apresentados com matricula, nome e tipo
# ==============================================================================

CT020 - Consultar Colaboradores via Terminal
    [Documentation]    Valida o RF005 listando os tres registros pre-cadastrados no CSV.

    # --------------------------------------------------------------------------
    # ETAPA 1: PREPARACAO DO AMBIENTE E PRECONDICOES
    # --------------------------------------------------------------------------
    # Cria o diretorio temporario isolado e popula o CSV com a massa AC01-AC03
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
    # Gera o arquivo de stdin simulando a escolha da opcao 2 (Consultar) e 0 (Sair)
    Create File         ${TEMP_DIR}/inputs_ct020.txt    2\n0\n

    # Inicia o processo Java isolado dentro da pasta temporaria
    ${result}=          Run Process    java    -jar    ${JAR_PATH}
    ...                 cwd=${TEMP_DIR}
    ...                 stdin=${TEMP_DIR}/inputs_ct020.txt
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

    # Verifica que a consulta apresentou exatamente tres registros
    Should Contain    ${result.stdout}    --- LISTA DE COLABORADORES ---
    ${linhas_consulta}=    Get Lines Containing String    ${result.stdout}    | Nome:
    ${quantidade_linhas}=    Get Line Count    ${linhas_consulta}
    Should Be Equal As Integers    ${quantidade_linhas}    3

    # Confere matricula, nome e tipo em cada linha da consulta
    Should Contain    ${result.stdout}    1001 | Nome: Ana | Tipo: Padr
    Should Contain    ${result.stdout}    1002 | Nome: Bruno | Tipo: Comissionado
    Should Contain    ${result.stdout}    1003 | Nome: Carla | Tipo: Produ