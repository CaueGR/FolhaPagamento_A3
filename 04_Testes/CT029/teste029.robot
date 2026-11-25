*** Settings ***
Documentation	Suite de testes de sistema - CT029 (Robustez contra Entradas Invalidas)
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
# Caso de Teste      : CT029 - RNF002
# Nivel              : Sistema
# Precondicoes       : Aplicacao aberta com CSV temporario contendo matricula 1001
# Massa de dados     : Texto "abc" no menu principal; Opcao 1 (Cadastrar) + "abc" em campo numerico; Opcao 0
# Passos/Acao        : Enviar entradas nao numericas no menu e no cadastro, encerrando ao final
# Resultado esperado : Mensagem clara de entrada invalida; aplicacao nao trava; CSV intacto
# ==============================================================================
CT029 - Validar Robustez contra Entradas Invalidas via Terminal
	[Documentation]	Valida o RNF002 enviando texto nao numerico no menu e em campos numericos.

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
	# Envia "abc" no menu -> Tenta cadastrar (1) e envia "abc" no campo numerico -> Sair (0)
	Create File	${TEMP_DIR}/inputs_ct029.txt	abc\n1\nabc\n0\n

	${result}=	Run Process	java	-jar	${JAR_PATH}
	...	cwd=${TEMP_DIR}
	...	stdin=${TEMP_DIR}/inputs_ct029.txt
	...	timeout=10s

	# --------------------------------------------------------------------------
	# ETAPA 3: REGISTRO DE EVIDENCIAS (LOGS)
	# --------------------------------------------------------------------------
	Log	STDOUT: ${result.stdout}
	Log	STDERR: ${result.stderr}

	# --------------------------------------------------------------------------
	# ETAPA 4: VALIDACAO DOS RESULTADOS ESPERADOS
	# --------------------------------------------------------------------------
	# Verifica que o programa tratou a entrada sem fechar com erro (rc=0) e chegou ate o Encerrando
	Should Be Equal As Integers	${result.rc}	0
	Should Contain	${result.stdout}	Encerrando
	Should Not Contain	${result.stdout}	Exception
	Should Not Contain	${result.stderr}	Exception

	# Confere o CSV inteiro para garantir que nenhum dado invalido foi gravado
	File Should Exist	${CSV_FILE}
	${conteudo_csv}=	Get File	${CSV_FILE}
	${csv_esperado}=	Catenate	SEPARATOR=\n
	...	TIPO,MATRICULA,NOME,SALARIO_BASE,VENDAS,PERCENTUAL,QTD_PRODUZIDA,VALOR_UNIDADE
	...	1,1001,Ana,2000.0,0,0,0,0
	Should Be Equal As Strings	${conteudo_csv}	${csv_esperado}\n