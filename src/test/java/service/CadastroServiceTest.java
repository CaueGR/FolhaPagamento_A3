package service;

import dto.ColaboradorDTO;
import org.junit.jupiter.api.Test;
import repository.ColaboradorRepository;

import java.io.IOException;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.*;

class CadastroServiceTest {

    @Test
    void ct007_deveRejeitarTipoInvalidoSemSalvar() throws IOException {
        ColaboradorRepository repositorio = mock(ColaboradorRepository.class);
        when(repositorio.buscarPorMatricula("1007")).thenReturn(Optional.empty());

        CadastroService cadastro = new CadastroService(repositorio);
        ColaboradorDTO dto = new ColaboradorDTO(
                9, "1007", "Ana", 2000.0, 0.0, 0.0, 0, 0.0
        );

        IllegalArgumentException erro = assertThrows(
                IllegalArgumentException.class, () -> cadastro.cadastrar(dto)
        );

        assertEquals("Tipo de colaborador inválido.", erro.getMessage());
        verify(repositorio, never()).salvar(any());
    }
}