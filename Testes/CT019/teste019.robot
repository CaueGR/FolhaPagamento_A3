*** Settings ***
Documentation     Teste do caso CT019 para cadastro de Colaborador Padrao
Library           Process
Library           OperatingSystem

*** Variables ***
# Ajuste o caminho do JAR de acordo com a estrutura do seu projeto
${JAR_PATH}       D:/A3Qualidade/FolhaPagamento_A3/FolhaPagamento_A3_jar/FolhaPagamento_A3.jar
${TEMP_DIR}       ${CURDIR}/temp_test_dir
${CSV_FILE}       ${TEMP_DIR}/colaboradores_db.csv

*** Test Cases ***
CT019 - Cadastrar Colaborador Padrao via Terminal
    [Documentation]    Testa o RF001 cadastrando um colaborador padrão.
    
    # Prepara o ambiente isolado
    Create Directory    ${TEMP_DIR}
    Remove File         ${CSV_FILE}

    Create File    ${TEMP_DIR}/inputs_ct019.txt    1\n1\n1001\nAna\n2000\n0\n
    
    # Executa a aplicação Java lendo o stdin a partir do ficheiro criado
    ${result}=    Run Process    java    -jar    ${JAR_PATH}
    ...    cwd=${TEMP_DIR}
    ...    stdin=${TEMP_DIR}/inputs_ct019.txt
    ...    timeout=10s
    
    # 1. IMPRIMIR OS LOGS PRIMEIRO (Para capturar a exceção do Java)
    Log    STDOUT: ${result.stdout}
    Log    STDERR: ${result.stderr}

    # 2. VALIDAR O RESULTADO DEPOIS
    Should Be Equal As Integers    ${result.rc}    0

    # 3. VALIDAÇÕES FINAIS (Terminal e Arquivo CSV)
    # ATENÇÃO: Troque "sucesso" pela palavra exata que o seu programa imprime quando o cadastro dá certo
    Should Contain    ${result.stdout}    sucesso    ignore_case=True
    
    # Valida se o ficheiro certo foi criado e tem os dados gravados
    File Should Exist    ${CSV_FILE}
    ${conteudo_csv}=     Get File    ${CSV_FILE}
    Should Contain       ${conteudo_csv}    1001
    Should Contain       ${conteudo_csv}    Ana