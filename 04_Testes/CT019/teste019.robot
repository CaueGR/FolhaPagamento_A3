*** Settings ***
Documentation     Suite de testes de sistema - CT019 (Cadastro de Colaborador Padrao)
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
# Caso de Teste      : CT019 - RF001
# Nivel              : Sistema
# Precondicoes       : CSV temporario vazio (ambiente limpo)
# Massa de dados     : Opcao 1 (Cadastrar); Tipo 1 (Padrao); Matricula 1001; Nome Ana; Salario 2000; Opcao 0 (Sair)
# Passos/Acao        : Executar aplicacao, preencher dados do colaborador padrao via terminal e encerrar
# Resultado esperado : Mensagem de sucesso no terminal e registro gravado no CSV
# ==============================================================================
CT019 - Cadastrar Colaborador Padrao via Terminal
    [Documentation]    Valida o RF001 cadastrando um colaborador padrao e verificando a persistencia no CSV.

    # --------------------------------------------------------------------------
    # ETAPA 1: PREPARACAO DO AMBIENTE E PRECONDICOES
    # --------------------------------------------------------------------------
    # Cria o diretorio temporario isolado e garante que nao ha CSV residual
    Create Directory    ${TEMP_DIR}
    Remove File         ${CSV_FILE}

    # --------------------------------------------------------------------------
    # ETAPA 2: PREPARACAO DA MASSA DE ENTRADA E EXECUCAO
    # --------------------------------------------------------------------------
    # Gera o arquivo de stdin simulando cadastro (1), tipo padrao (1), dados e saida (0)
    Create File         ${TEMP_DIR}/inputs_ct019.txt    1\n1\n1001\nAna\n2000\n0\n

    # Inicia o processo Java isolado dentro da pasta temporaria
    ${result}=          Run Process    java    -jar    ${JAR_PATH}
    ...                 cwd=${TEMP_DIR}
    ...                 stdin=${TEMP_DIR}/inputs_ct019.txt
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

    # Verifica a confirmacao especifica do cadastro realizado
    Should Contain    ${result.stdout}    [OK] Colaborador Ana cadastrado com sucesso.

    # Confere o CSV inteiro para detectar campos alterados ou registros extras
    File Should Exist    ${CSV_FILE}
    ${conteudo_csv}=     Get File    ${CSV_FILE}
    ${csv_esperado}=     Catenate    SEPARATOR=\n
    ...                  TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
    ...                  1,1001,Ana,2000.0,0,0,0,0
    Should Be Equal As Strings    ${conteudo_csv}    ${csv_esperado}\n