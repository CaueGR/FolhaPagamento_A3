package dto;

// Usando o formato 'record' (disponível no Java 14+), ideal para DTOs por ser imutável e conciso.
public record ColaboradorDTO(
        int tipo,
        String matricula,
        String nome,
        double salarioBase,
        double valorVendas,
        double percentualComissao,
        int quantidadeProduzida,
        double valorPorUnidade
) {}