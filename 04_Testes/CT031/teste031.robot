*** Settings ***
Documentation	Suite de testes de sistema - CT031 (Validacao de Fluxo Completo e Usabilidade)
Library	Process
Library	OperatingSystem

*** Variables ***
${JAR_PATH}	D:/A3Qualidade/FolhaPagamento_A3/FolhaPagamento_A3_jar/FolhaPagamento_A3.jar
${TEMP_DIR}	${CURDIR}/temp_test_dir
${CSV_FILE}	${TEMP_DIR}/colaboradores_db.csv

*** Test Cases ***
# ==============================================================================
# TEST DESCRIPTION
# ------------------------------------------------------------------------------
# Caso de Teste      : CT031 - RNF001 (Usabilidade / Fluxo Ponta-a-Ponta)
# Nivel              : Sistema / Aceitacao
# Precondicoes       : CSV temporario vazio (ambiente limpo)
# Massa de dados     : Fluxo completo: Cadastrar (1) -> Consultar (2) -> Editar (6) -> Folha Indiv. (7) -> Detalhada (4) -> Resumo (5) -> Excluir (3) -> Sair (0)
# Passos/Acao        : Executar ciclo completo de operacao do utilizador no terminal sem interrupcoes
# Resultado esperado : Menus autoexplicativos exibidos a cada passo e operacoes concluidas com sucesso
# ==============================================================================
CT031 - Validar Fluxo Completo de Usabilidade via Terminal
	[Documentation]	Valida a fluidez e clareza dos menus executando todas as opcoes do sistema em sequencia.

	# --------------------------------------------------------------------------
	# ETAPA 1: PREPARACAO DO AMBIENTE E PRECONDICOES
	# --------------------------------------------------------------------------
	Create Directory	${TEMP_DIR}
	Remove File	${CSV_FILE}

	# --------------------------------------------------------------------------
	# ETAPA 2: PREPARACAO DA MASSA DE ENTRADA E EXECUCAO
	# --------------------------------------------------------------------------
	# Simula a jornada completa de um operador no terminal:
	# 1. Cadastra matricula 2001 (Lucas, Padrao, 3000)
	# 2. Consulta colaboradores (2)
	# 3. Edita salario de 2001 para 3500 (6)
	# 4. Gera folha individual de 2001 (7)
	# 5. Gera folha detalhada (4)
	# 6. Emite resumo da folha (5)
	# 7. Exclui matricula 2001 (3)
	# 8. Encerra o sistema (0)
	${fluxo_e2e}=	Catenate	SEPARATOR=\n
	...	1
	...	1
	...	2001
	...	Lucas
	...	3000
	...	2
	...	6
	...	2001
	...	1
	...	Lucas
	...	3500
	...	7
	...	2001
	...	4
	...	5
	...	3
	...	2001
	...	0
	Create File	${TEMP_DIR}/inputs_ct031.txt	${fluxo_e2e}\n

	${result}=	Run Process	java	-jar	${JAR_PATH}
	...	cwd=${TEMP_DIR}
	...	stdin=${TEMP_DIR}/inputs_ct031.txt
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

	# Confirma que os prompts de orientacao ao utilizador foram exibidos claramente
	Should Contain	${result.stdout}	SISTEMA DE FOLHA DE PAGAMENTO
	Should Contain	${result.stdout}	cadastrado com sucesso
	Should Contain	${result.stdout}	atualizado com sucesso
	Should Contain	${result.stdout}	3500
	Should Contain	${result.stdout}	Encerrando

	# Confirma ausencia de erros de execucao durante todo o ciclo
	Should Not Contain	${result.stdout}	Exception
	Should Not Contain	${result.stderr}	Exception