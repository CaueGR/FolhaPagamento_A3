package entities;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class ColaboradorPadraoTest {

    @Test
    void ct001_deveRetornarSalarioBaseComoSalarioFinal() {
        // Preparar: criar um colaborador com dados conhecidos.
        ColaboradorPadrao colaborador =
                new ColaboradorPadrao("1001", "Ana", 2000.0);

        // Executar: chamar o método que queremos testar.
        double salarioFinal = colaborador.calcularSalarioFinal();

        // Verificar: comparar o resultado esperado com o obtido.
        assertEquals(2000.0, salarioFinal, 0.001);
    }
}
