package entities;

import org.junit.jupiter.api.Test;

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
}