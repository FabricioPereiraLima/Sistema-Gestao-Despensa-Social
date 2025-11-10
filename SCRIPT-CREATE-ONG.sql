-- -----------------------------------------------------
-- Projeto: Gestão de Despensa Social (SQL Server)
-- Autor: Fabricio Pereira Lima
-- Impacto Social: Redução de desperdício de alimentos.
-- -----------------------------------------------------

CREATE TABLE Beneficiarios (
    BeneficiarioID INT PRIMARY KEY IDENTITY(1,1),
    NomeResponsavel VARCHAR(200) NOT NULL,
    Documento VARCHAR(50) UNIQUE,
    Endereco VARCHAR(255),
    Telefone VARCHAR(20)
);

CREATE TABLE Doadores (
    DoadorID INT PRIMARY KEY IDENTITY(1,1),
    NomeDoador VARCHAR(200) NOT NULL,
    TipoPessoa CHAR(1) -- F para Fisica, J para Juridica
);

CREATE TABLE ItensEstoque (
    ItemID INT PRIMARY KEY IDENTITY(1,1),
    NomeItem VARCHAR(100) NOT NULL,
    Categoria VARCHAR(50), -- Ex: Nao-perecivel, Higiene, etc.
    QuantidadeAtual INT NOT NULL DEFAULT 0
);

CREATE TABLE DoacoesEntrada (
    EntradaID INT PRIMARY KEY IDENTITY(1,1),
    DoadorID INT,
    ItemID INT NOT NULL,
    Quantidade INT NOT NULL,
    DataEntrada DATETIME DEFAULT GETDATE(),
    DataValidade DATE NOT NULL,
    FOREIGN KEY (DoadorID) REFERENCES Doadores(DoadorID),
    FOREIGN KEY (ItemID) REFERENCES ItensEstoque(ItemID)
);

CREATE TABLE DistribuicoesSaida (
    SaidaID INT PRIMARY KEY IDENTITY(1,1),
    BeneficiarioID INT NOT NULL,
    ItemID INT NOT NULL,
    Quantidade INT NOT NULL,
    DataSaida DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (BeneficiarioID) REFERENCES Beneficiarios(BeneficiarioID),
    FOREIGN KEY (ItemID) REFERENCES ItensEstoque(ItemID)
);
