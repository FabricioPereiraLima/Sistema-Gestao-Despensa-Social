-- -----------------------------------------------------
-- Stored Procedures (T-SQL) - Gestão de Despensa Social
-- -----------------------------------------------------

-- Procedure para registrar a entrada de uma doação e atualizar o estoque
CREATE PROCEDURE sp_RegistrarDoacao
    @DoadorID INT,
    @ItemID INT,
    @Quantidade INT,
    @DataValidade DATE
AS
BEGIN
    -- Insere o registro da doação
    INSERT INTO DoacoesEntrada (DoadorID, ItemID, Quantidade, DataValidade)
    VALUES (@DoadorID, @ItemID, @Quantidade, @DataValidade);

    -- Atualiza o estoque central
    UPDATE ItensEstoque
    SET QuantidadeAtual = QuantidadeAtual + @Quantidade
    WHERE ItemID = @ItemID;
END
GO

-- PROCEDURE COM IMPACTO SOCIAL: Alerta de itens próximos ao vencimento
CREATE PROCEDURE sp_AlertarVencimento
    @DiasParaVencer INT
AS
BEGIN
    SELECT 
        i.NomeItem,
        d.DataValidade,
        d.Quantidade
    FROM DoacoesEntrada d
    JOIN ItensEstoque i ON d.ItemID = i.ItemID
    WHERE d.DataValidade <= DATEADD(day, @DiasParaVencer, GETDATE())
      AND d.Quantidade > 0; -- Apenas itens que ainda estão em estoque
END
GO
