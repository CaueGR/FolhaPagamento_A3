package entities;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertThrows;

import static org.junit.jupiter.api.Assertions.assertEquals;

class ColaboradorProducaoTest {

    @Test
    void ct004_deveSomarAdicionalDeProducaoAoSalarioBase() {
        ColaboradorProducao colaborador = new ColaboradorProducao(
                "1003", "Ana", 1500.0, 100, 10.0
        );

        double salarioFinal = colaborador.calcularSalarioFinal();
        double adicionalObtido = salarioFinal - colaborador.getSalarioBase();

        assertEquals(1000.0, adicionalObtido, 0.001);
        assertEquals(2500.0, salarioFinal, 0.001);
    }

    @Test
    void ct017_deveRejeitarQuantidadeProduzidaNegativa() {
        assertThrows(IllegalArgumentException.class,
                () -> new ColaboradorProducao("1017", "Ana", 1500.0, -1, 10.0));
    }

    @Test
    void ct018_deveRejeitarValorPorUnidadeNegativo() {
        assertThrows(IllegalArgumentException.class,
                () -> new ColaboradorProducao("1018", "Ana", 1500.0, 100, -1.0));
    }
}