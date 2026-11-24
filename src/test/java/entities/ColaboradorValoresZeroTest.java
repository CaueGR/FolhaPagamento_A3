package entities;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class ColaboradorValoresZeroTest {

    @Test
    void ct028_deveAceitarValoresZeroECalcularSalarioFinalZero() {
        ColaboradorPadrao padrao =
                new ColaboradorPadrao("1028", "Ana", 0.0);
        ColaboradorComissionado comissionado =
                new ColaboradorComissionado("1029", "Bruno", 0.0, 0.0, 0.0);
        ColaboradorProducao producao =
                new ColaboradorProducao("1030", "Carla", 0.0, 0, 0.0);

        assertEquals(0.0, padrao.calcularSalarioFinal(), 0.001);
        assertEquals(0.0, comissionado.calcularSalarioFinal(), 0.001);
        assertEquals(0.0, producao.calcularSalarioFinal(), 0.001);
    }
}