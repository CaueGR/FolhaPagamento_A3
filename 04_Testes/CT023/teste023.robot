*** Settings ***
Documentation	Suite de testes de sistema - CT023 (Gerar Folha Detalhada)
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
# Caso de Teste      : CT023 - RF007
# Nivel              : Sistema
# Precondicoes       : Massa AC01-AC03 cadastrada no CSV (matriculas 1001, 1002 e 1003)
# Massa de dados     : Opcao 4 (Gerar Folha Detalhada) e Opcao 0 (Sair)
# Passos/Acao        : Executar aplicacao, selecionar opcao 4 e encerrar
# Resultado esperado : Tres linhas exibidas com salarios finais 2000,00, 2500,00 e 2500,00
# ==============================================================================
CT023 - Gerar Folha Detalhada via Terminal
	[Documentation]	Valida o RF007 exibindo o calculo detalhado da folha para os tres colaboradores.

	# --------------------------------------------------------------------------
	# ETAPA 1: PREPARACAO DO AMBIENTE E PRECONDICOES
	# --------------------------------------------------------------------------
	Create Directory	${TEMP_DIR}
	${massa_csv}=	Catenate	SEPARATOR=\n
	...	TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
	...	1,1001,Ana,2000.0,0,0,0,0
	...	2,1002,Bruno,2000.0,10000.0,5.0,0,0
	...	3,1003,Carla,1500.0,0,0,100,10.0
	Create File	${CSV_FILE}	${massa_csv}\n

	# --------------------------------------------------------------------------
	# ETAPA 2: PREPARACAO DA MASSA DE ENTRADA E EXECUCAO
	# --------------------------------------------------------------------------
	Create File	${TEMP_DIR}/inputs_ct023.txt	4\n0\n

	${result}=	Run Process	java	-jar	${JAR_PATH}
	...	cwd=${TEMP_DIR}
	...	stdin=${TEMP_DIR}/inputs_ct023.txt
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

	# Verifica exibicao dos tres colaboradores e seus respectivos salarios finais
	Should Contain	${result.stdout}	Ana
	Should Contain	${result.stdout}	2000
	Should Contain	${result.stdout}	Bruno
	Should Contain	${result.stdout}	Carla
	Should Contain	${result.stdout}	2500