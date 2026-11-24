package entities;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

class ColaboradorComissionadoTest {

    @Test
    void ct003_deveSomarComissaoAoSalarioBase() {
        ColaboradorComissionado colaborador = new ColaboradorComissionado(
                "1002", "Bruno", 2000.0, 10000.0, 5.0
        );

        double salarioFinal = colaborador.calcularSalarioFinal();
        double comissaoObtida = salarioFinal - colaborador.getSalarioBase();

        assertEquals(500.0, comissaoObtida, 0.001);
        assertEquals(2500.0, salarioFinal, 0.001);
    }

    @Test
    void ct015_deveRejeitarValorDeVendasNegativo() {
        assertThrows(IllegalArgumentException.class,
                () -> new ColaboradorComissionado("1015", "Ana", 2000.0, -1.0, 5.0));
    }
}