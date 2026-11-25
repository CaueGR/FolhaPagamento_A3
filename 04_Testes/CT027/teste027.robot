*** Settings ***
Documentation	Suite de testes de sistema - CT027 (Encerramento Limpo da Aplicacao)
Library	Process
Library	OperatingSystem

*** Variables ***
${JAR_PATH}	${CURDIR}/../../FolhaPagamento_A3_jar/FolhaPagamento_A3.jar
${TEMP_DIR}	${CURDIR}/temp_test_dir
${CSV_FILE}	${TEMP_DIR}/colaboradores_db.csv

*** Test Cases ***
# ==============================================================================
# TEST DESCRIPTION
# ------------------------------------------------------------------------------
# Caso de Teste      : CT027 - UC07
# Nivel              : Sistema
# Precondicoes       : Aplicacao aberta com CSV temporario contendo matricula 1001
# Massa de dados     : Opcao 0 (Sair)
# Passos/Acao        : Executar aplicacao, selecionar opcao 0 no menu principal e aguardar encerramento
# Resultado esperado : Processo finaliza com codigo de saida 0, sem travamento e CSV inalterado
# ==============================================================================
CT027 - Encerrar Aplicacao Limpamente via Terminal
	[Documentation]	Valida o UC07 garantindo encerramento limpo ao selecionar a opcao 0.

	# --------------------------------------------------------------------------
	# ETAPA 1: PREPARACAO DO AMBIENTE E PRECONDICOES
	# --------------------------------------------------------------------------
	Create Directory	${TEMP_DIR}
	${massa_csv}=	Catenate	SEPARATOR=\n
	...	TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
	...	1,1001,Ana,2000.0,0,0,0,0
	Create File	${CSV_FILE}	${massa_csv}\n

	# --------------------------------------------------------------------------
	# ETAPA 2: PREPARACAO DA MASSA DE ENTRADA E EXECUCAO
	# --------------------------------------------------------------------------
	Create File	${TEMP_DIR}/inputs_ct027.txt	0\n

	${result}=	Run Process	java	-jar	${JAR_PATH}
	...	cwd=${TEMP_DIR}
	...	stdin=${TEMP_DIR}/inputs_ct027.txt
	...	timeout=10s

	# --------------------------------------------------------------------------
	# ETAPA 3: REGISTRO DE EVIDENCIAS (LOGS)
	# --------------------------------------------------------------------------
	Log	STDOUT: ${result.stdout}
	Log	STDERR: ${result.stderr}

	# --------------------------------------------------------------------------
	# ETAPA 4: VALIDACAO DOS RESULTADOS ESPERADOS
	# --------------------------------------------------------------------------
	Should Be Equal As Integers	${result.rc}	0
	Should Contain	${result.stdout}	Encerrando

	# Confere integridade do CSV apos encerramento
	File Should Exist	${CSV_FILE}
	${conteudo_csv}=	Get File	${CSV_FILE}
	${csv_esperado}=	Catenate	SEPARATOR=\n
	...	TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
	...	1,1001,Ana,2000.0,0,0,0,0
	Should Be Equal As Strings	${conteudo_csv}	${csv_esperado}\n