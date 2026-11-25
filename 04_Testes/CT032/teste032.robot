*** Settings ***
Documentation	Suite de testes de arquitetura - CT032 (Extensibilidade Orientada a Objetos)
Library	OperatingSystem

*** Variables ***
${SRC_DIR}	D:/A3Qualidade/FolhaPagamento_A3/src/main/java

*** Test Cases ***
# ==============================================================================
# TEST DESCRIPTION
# ------------------------------------------------------------------------------
# Caso de Teste      : CT032 - RNF003 (Extensibilidade da Arquitetura)
# Nivel              : Estrutural / Revisao Tecnica Automatizada
# Precondicoes       : Codigo-fonte Java estruturado em pacotes (entities, service, repository)
# Massa de dados     : Arquivos Colaborador.java e FolhaPagamentoService.java
# Passos/Acao        : Inspecionar a hierarquia de heranca, polimorfismo e desacoplamento do servico de folha
# Resultado esperado : Classe base abstrata com metodo polimorfico e servico de folha desacoplado de tipos concretos
# ==============================================================================
CT032 - Validar Extensibilidade da Hierarquia de Colaboradores
	[Documentation]	Valida o RNF003 verificando polimorfismo na classe base e desacoplamento no calculo da folha.

	# --------------------------------------------------------------------------
	# ETAPA 1: PREPARACAO E LOCALIZACAO DOS ARTEFATOS DE CODIGO
	# --------------------------------------------------------------------------
	File Should Exist	${SRC_DIR}/entities/Colaborador.java
	File Should Exist	${SRC_DIR}/entities/ColaboradorPadrao.java
	File Should Exist	${SRC_DIR}/entities/ColaboradorComissionado.java
	File Should Exist	${SRC_DIR}/entities/ColaboradorProducao.java
	File Should Exist	${SRC_DIR}/service/FolhaPagamentoService.java

	# --------------------------------------------------------------------------
	# ETAPA 2: LEITURA DOS CODIGOS-FONTE PARA INSPECAO ESTRUTURAL
	# --------------------------------------------------------------------------
	${colaborador_java}=	Get File	${SRC_DIR}/entities/Colaborador.java
	${padrao_java}=	Get File	${SRC_DIR}/entities/ColaboradorPadrao.java
	${comissionado_java}=	Get File	${SRC_DIR}/entities/ColaboradorComissionado.java
	${producao_java}=	Get File	${SRC_DIR}/entities/ColaboradorProducao.java
	${folha_service}=	Get File	${SRC_DIR}/service/FolhaPagamentoService.java

	# --------------------------------------------------------------------------
	# ETAPA 3: REGISTRO DE EVIDENCIAS (LOGS)
	# --------------------------------------------------------------------------
	Log	Verificando contrato polimorfico em Colaborador.java e FolhaPagamentoService.java

	# --------------------------------------------------------------------------
	# ETAPA 4: VALIDACAO DOS CRITERIOS DE EXTENSIBILIDADE
	# --------------------------------------------------------------------------
	# 1. Verifica se Colaborador e uma classe abstrata com metodo de calculo polimorfico
	Should Contain	${colaborador_java}	abstract class Colaborador
	Should Contain	${colaborador_java}	calcularSalario

	# 2. Verifica se as subclasses concretas estendem a classe base Colaborador
	Should Contain	${padrao_java}	extends Colaborador
	Should Contain	${comissionado_java}	extends Colaborador
	Should Contain	${producao_java}	extends Colaborador

	# 3. Verifica se o servico de folha opera sobre a abstracao sem acoplar regras por instanceof
	Should Not Contain	${folha_service}	instanceof