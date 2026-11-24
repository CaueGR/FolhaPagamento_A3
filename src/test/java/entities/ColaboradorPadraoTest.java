package entities;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertThrows;

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
    @Test
    void ct002_deveRejeitarSalarioBaseNegativo() {
        assertThrows(
                IllegalArgumentException.class,
                () -> new ColaboradorPadrao("1002", "Bruno", -500.0)
        );
    }

    @Test
    void ct005_deveRejeitarNomeVazioENomeNulo() {
        assertThrows(IllegalArgumentException.class,
                () -> new ColaboradorPadrao("1005", "", 2000.0));

        assertThrows(IllegalArgumentException.class,
                () -> new ColaboradorPadrao("1005", null, 2000.0));
    }
}
