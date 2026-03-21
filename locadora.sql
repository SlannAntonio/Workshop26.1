-- Tabela que armazena os dados dos clientes da locadora
CREATE TABLE Cliente (
    id_cliente       SERIAL        PRIMARY KEY,
    cpf              VARCHAR(11)   NOT NULL UNIQUE,
    nome_completo    VARCHAR(100)  NOT NULL,
    data_nascimento  DATE,
    cnh              VARCHAR(20)   NOT NULL UNIQUE,
    telefone         VARCHAR(20),
    email            VARCHAR(100),
    endereco         VARCHAR(255)
);
 
-- Tabela que armazena os dados dos funcionários da locadora
CREATE TABLE Funcionario (
    id_func     SERIAL        PRIMARY KEY,
    mat_rh      VARCHAR(20)   NOT NULL UNIQUE,
    cpf         VARCHAR(11)   NOT NULL UNIQUE,
    nome        VARCHAR(100)  NOT NULL,
    telefone    VARCHAR(20),
    salario     NUMERIC(10,2) NOT NULL,
    email       VARCHAR(100),
    dt_contrat  DATE          NOT NULL
);
 
-- Tabela que armazena os veículos disponíveis para locação
CREATE TABLE Veiculo (
    id_veic  SERIAL        PRIMARY KEY,
    cor      VARCHAR(30),
    km       NUMERIC(10,2) NOT NULL DEFAULT 0,
    dspnb    BOOLEAN       NOT NULL DEFAULT TRUE,  -- disponibilidade
    modelo   VARCHAR(50)   NOT NULL,
    marca    VARCHAR(50)   NOT NULL,
    placa    VARCHAR(10)   NOT NULL UNIQUE,
    ano_fab  SMALLINT      NOT NULL
);
 
-- Tabela que registra os contratos de aluguel entre cliente e locadora
CREATE TABLE Contrato (
    id_contrato     SERIAL        PRIMARY KEY,
    dt_emi          DATE          NOT NULL DEFAULT CURRENT_DATE,
    dt_inicio       DATE          NOT NULL,
    dt_dv_real      DATE,                          -- data real de devolução (pode ser nula se ainda ativo)
    dt_dv_prevista  DATE          NOT NULL,
    status_contrato VARCHAR(20)   NOT NULL DEFAULT 'ATIVO',
    valor_total     NUMERIC(10,2) NOT NULL,
    id_func         INT           NOT NULL,
    id_cliente      INT           NOT NULL,
    id_veic         INT           NOT NULL,
    CONSTRAINT fk_contrato_funcionario FOREIGN KEY (id_func)    REFERENCES Funcionario (id_func),
    CONSTRAINT fk_contrato_cliente     FOREIGN KEY (id_cliente) REFERENCES Cliente     (id_cliente),
    CONSTRAINT fk_contrato_veiculo     FOREIGN KEY (id_veic)    REFERENCES Veiculo     (id_veic)
);
 
-- Tabela que registra os pagamentos vinculados a cada contrato
CREATE TABLE Pagamento (
    id_pag            SERIAL        PRIMARY KEY,
    dt_transacao      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor_pag         NUMERIC(10,2) NOT NULL,
    metodo_pag        VARCHAR(30)   NOT NULL,
    status_aprov      VARCHAR(20)   NOT NULL DEFAULT 'PENDENTE',
    cdg_bancario      VARCHAR(50),
    observacao_fatura TEXT,
    id_contrato       INT           NOT NULL,
    CONSTRAINT fk_pagamento_contrato FOREIGN KEY (id_contrato) REFERENCES Contrato (id_contrato)
);
 
-- Tabela que registra as manutenções realizadas nos veículos
CREATE TABLE Manutencao (
    id_manutencao  SERIAL        PRIMARY KEY,
    ofcn_terc      BOOLEAN       NOT NULL DEFAULT FALSE, -- oficina terceirizada
    pcas_trcds     BOOLEAN       NOT NULL DEFAULT FALSE, -- peças trocadas
    custo          NUMERIC(10,2) NOT NULL DEFAULT 0,
    tipo_serv      VARCHAR(100)  NOT NULL,
    valor_pago     NUMERIC(10,2),
    dt_transacao   TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_veic        INT           NOT NULL,
    CONSTRAINT fk_manutencao_veiculo FOREIGN KEY (id_veic) REFERENCES Veiculo (id_veic)
);
 
-- Inserindo os 13 clientes cadastrados na locadora
INSERT INTO Cliente (id_cliente, cpf, nome_completo, data_nascimento, cnh, telefone, email, endereco) VALUES
(1,  '111.222.333-01', 'Ana Paula Ferreira',    '1990-03-15', '0001112220',  '(83)99001-1001', 'ana.ferreira@email.com',  'Rua das Flores, 10, João Pessoa-PB'),
(2,  '222.333.444-02', 'Bruno Henrique Costa',  '1985-07-22', '00022233302', '(83)99002-2002', 'bruno.costa@email.com',   'Av. Epitácio Pessoa, 200, João Pessoa-PB'),
(3,  '333.444.555-03', 'Carla Souza Lima',      '1993-11-08', '00033344403', '(81)99003-3003', 'carla.lima@email.com',    'Rua do Sol, 55, Recife-PE'),
(4,  '444.555.666-04', 'Diego Alves Martins',   '1988-01-30', '00044455504', '(85)99004-4004', 'diego.martins@email.com', 'Rua Tibúrcio, 78, Fortaleza-CE'),
(5,  '555.666.777-05', 'Eduarda Nunes Rocha',   '1995-05-17', '00055566605', '(84)99005-5005', 'eduarda.rocha@email.com', 'Av. Hermes Fontes, 900, Natal-RN'),
(6,  '666.777.888-06', 'Felipe Torres Gomes',   '1982-09-03', '00066677706', '(71)99006-6006', 'felipe.gomes@email.com',  'Rua Chile, 300, Salvador-BA'),
(7,  '777.888.999-07', 'Gabriela Pinto Reis',   '1997-12-25', '00077788807', '(11)99007-7007', 'gabriela.reis@email.com', 'Rua Augusta, 1400, São Paulo-SP'),
(8,  '888.999.000-08', 'Henrique Dias Melo',    '1980-04-11', '00088899908', '(31)99008-8008', 'henrique.melo@email.com', 'Av. Afonso Pena, 50, Belo Horizonte-MG'),
(9,  '999.000.111-09', 'Isabela Castro Faria',  '1992-06-19', '00099900009', '(21)99009-9009', 'isabela.faria@email.com', 'Rua Visconde, 22, Rio de Janeiro-RJ'),
(10, '000.111.222-10', 'Jonas Barbosa Vieira',  '1987-08-07', '00010011210', '(62)99010-1010', 'jonas.vieira@email.com',  'Rua 44, 88, Goiânia-GO'),
(11, '100.200.300-11', 'Karina Mendes Araújo',  '1994-02-28', '0001112001',  '(83)99011-1011', 'karina.araujo@email.com', 'Rua Duque de Caxias, 5, Campina Grande-PB'),
(12, '200.300.400-12', 'Leonardo Freitas Luz',  '1991-10-14', '00012030012', '(79)99012-1012', 'leonardo.luz@email.com',  'Av. Ivo do Prado, 700, Aracaju-SE'),
(13, '300.400.500-13', 'Marina Cardoso Vaz',    '1986-03-01', '00013040013', '(82)99013-1013', 'marina.vaz@email.com',    'Rua do Comércio, 150, Maceió-AL');
 
-- Inserindo os 12 funcionários da locadora
INSERT INTO Funcionario (id_func, mat_rh, cpf, nome, telefone, salario, email, dt_contrat) VALUES
(1,  'RH-0001', '010.020.030-01', 'Roberto Almeida',   '(83)98001-0001', 3500.00, 'roberto.almeida@locadora.com',   '2018-02-01'),
(2,  'RH-0002', '020.030.040-02', 'Simone Cavalcanti', '(83)98002-0002', 4200.00, 'simone.cavalcanti@locadora.com', '2019-05-15'),
(3,  'RH-0003', '030.040.050-03', 'Thiago Nascimento', '(83)98003-0003', 3800.00, 'thiago.nascimento@locadora.com', '2020-08-20'),
(4,  'RH-0004', '040.050.060-04', 'Úrsula Pimentel',   '(83)98004-0004', 5000.00, 'ursula.pimentel@locadora.com',   '2017-11-10'),
(5,  'RH-0005', '050.060.070-05', 'Victor Hugo Leal',  '(83)98005-0005', 3200.00, 'victor.leal@locadora.com',       '2021-01-05'),
(6,  'RH-0006', '060.070.080-06', 'Wanda Correia',     '(83)98006-0006', 4800.00, 'wanda.correia@locadora.com',     '2016-07-18'),
(7,  'RH-0007', '070.080.090-07', 'Xavier Moraes',     '(83)98007-0007', 3600.00, 'xavier.moraes@locadora.com',     '2022-03-22'),
(8,  'RH-0008', '080.090.100-08', 'Yasmin Fonseca',    '(83)98008-0008', 4100.00, 'yasmin.fonseca@locadora.com',    '2020-09-30'),
(9,  'RH-0009', '090.100.110-09', 'Zeca Rodrigues',    '(83)98009-0009', 3900.00, 'zeca.rodrigues@locadora.com',    '2019-12-01'),
(10, 'RH-0010', '100.110.120-10', 'Amanda Saraiva',    '(83)98010-0010', 4500.00, 'amanda.saraiva@locadora.com',    '2015-06-14'),
(11, 'RH-0011', '110.120.130-11', 'Bernardo Queiroz',  '(83)98011-0011', 3300.00, 'bernardo.queiroz@locadora.com',  '2023-01-10'),
(12, 'RH-0012', '120.130.140-12', 'Cecília Wanderley', '(83)98012-0012', 4700.00, 'cecilia.wanderley@locadora.com', '2018-10-05');
 
-- Inserindo os 15 veículos da frota
INSERT INTO Veiculo (id_veic, cor, km, dspnb, modelo, placa, marca, ano_fab) VALUES
(1,  'Prata',    12000, TRUE,  'Onix',     'PBX-1A01', 'Chevrolet',  2021),
(2,  'Branco',   34000, TRUE,  'HB20',     'PBX-2B02', 'Hyundai',    2020),
(3,  'Preto',     8500, TRUE,  'Polo',     'PBX-3C03', 'Volkswagen', 2022),
(4,  'Vermelho', 21000, FALSE, 'Argo',     'PBX-4D04', 'Fiat',       2019),
(5,  'Azul',     15000, TRUE,  'Sandero',  'PBX-5E05', 'Renault',    2021),
(6,  'Branco',   40000, FALSE, 'Kicks',    'PBX-6F06', 'Nissan',     2018),
(7,  'Cinza',     5000, TRUE,  'T-Cross',  'PBX-7G07', 'Volkswagen', 2023),
(8,  'Prata',    27000, TRUE,  'Creta',    'PBX-8H08', 'Hyundai',    2020),
(9,  'Preto',    18000, TRUE,  'Renegade', 'PBX-9I09', 'Jeep',       2021),
(10, 'Branco',    9000, TRUE,  'Tracker',  'PBX-0J10', 'Chevrolet',  2022),
(11, 'Azul',     33000, FALSE, 'Compass',  'PBX-1K11', 'Jeep',       2019),
(12, 'Prata',    11000, TRUE,  'Corolla',  'PBX-2L12', 'Toyota',     2022),
(13, 'Cinza',    22000, TRUE,  'Hilux',    'PBX-3M13', 'Toyota',     2020),
(14, 'Vermelho',  7000, TRUE,  'Mobi',     'PBX-4N14', 'Fiat',       2023),
(15, 'Branco',   45000, FALSE, 'Strada',   'PBX-5O15', 'Fiat',       2018);
 
-- Inserindo os 13 contratos de aluguel
INSERT INTO Contrato (id_contrato, dt_emi, dt_inicio, dt_dv_real, dt_dv_prevista, status_contrato, valor_total, id_func, id_cliente, id_veic) VALUES
(1,  '2024-01-05', '2024-01-06', '2024-01-13', '2024-01-13', 'Encerrado',  700.00,  1,  1,  1),
(2,  '2024-01-10', '2024-01-11', '2024-01-18', '2024-01-18', 'Encerrado',  840.00,  2,  2,  2),
(3,  '2024-02-01', '2024-02-02', '2024-02-09', '2024-02-09', 'Encerrado',  630.00,  3,  3,  3),
(4,  '2024-02-15', '2024-02-16', NULL,          '2024-02-23', 'Ativo',      560.00,  4,  4,  5),
(5,  '2024-03-01', '2024-03-02', '2024-03-10', '2024-03-09', 'Encerrado',  960.00,  5,  5,  8),
(6,  '2024-03-10', '2024-03-11', NULL,          '2024-03-18', 'Ativo',     1200.00,  6,  6,  9),
(7,  '2024-03-20', '2024-03-21', '2024-03-28', '2024-03-28', 'Encerrado',  490.00,  7,  7, 14),
(8,  '2024-04-01', '2024-04-02', NULL,          '2024-04-09', 'Ativo',      770.00,  8,  8,  7),
(9,  '2024-04-10', '2024-04-11', '2024-04-18', '2024-04-18', 'Encerrado',  880.00,  9,  9, 12),
(10, '2024-04-20', '2024-04-21', '2024-04-28', '2024-04-28', 'Encerrado', 1050.00, 10, 10, 13),
(11, '2024-05-05', '2024-05-06', NULL,          '2024-05-13', 'Ativo',      420.00,  1, 11,  3),
(12, '2024-05-12', '2024-05-13', '2024-05-20', '2024-05-20', 'Encerrado',  660.00,  2, 12, 10),
(13, '2024-06-01', '2024-06-02', NULL,          '2024-06-09', 'Cancelado',  350.00,  3, 13,  2);
 
-- Inserindo os 14 pagamentos referentes aos contratos
INSERT INTO Pagamento (id_pag, dt_transacao, valor_pag, metodo_pag, status_aprov, cdg_bancario, observacao_fatura, id_contrato) VALUES
(1,  '2024-01-06',  700.00, 'Cartão Crédito', 'Aprovado', 'TXN-BC-001', 'Pagamento integral',           1),
(2,  '2024-01-11',  420.00, 'PIX',            'Aprovado', 'TXN-BC-002', 'Entrada 50%',                  2),
(3,  '2024-01-18',  420.00, 'Cartão Débito',  'Aprovado', 'TXN-BC-003', 'Saldo restante',               2),
(4,  '2024-02-02',  630.00, 'PIX',            'Aprovado', 'TXN-BC-004', 'Pagamento integral',           3),
(5,  '2024-02-16',  560.00, 'Boleto',         'Pendente', 'TXN-BC-005', 'Aguardando compensação',       4),
(6,  '2024-03-02',  960.00, 'Cartão Crédito', 'Aprovado', 'TXN-BC-006', 'Pago com 1 dia de atraso',    5),
(7,  '2024-03-11',  600.00, 'PIX',            'Aprovado', 'TXN-BC-007', 'Entrada parcial',              6),
(8,  '2024-03-21',  490.00, 'Cartão Débito',  'Aprovado', 'TXN-BC-008', 'Pagamento integral',           7),
(9,  '2024-04-02',  770.00, 'PIX',            'Aprovado', 'TXN-BC-009', 'Pagamento integral',           8),
(10, '2024-04-11',  880.00, 'Cartão Crédito', 'Aprovado', 'TXN-BC-010', 'Pagamento integral',           9),
(11, '2024-04-21', 1050.00, 'Transferência',  'Aprovado', 'TXN-BC-011', 'Pagamento integral',          10),
(12, '2024-05-06',  210.00, 'PIX',            'Aprovado', 'TXN-BC-012', 'Entrada 50%',                 11),
(13, '2024-05-13',  660.00, 'Cartão Crédito', 'Aprovado', 'TXN-BC-013', 'Pagamento integral',          12),
(14, '2024-06-02',  350.00, 'Boleto',         'Recusado', 'TXN-BC-014', 'Contrato cancelado – estorno',13);
 
-- Inserindo os 15 registros de manutenção dos veículos
INSERT INTO Manutencao (id_manutencao, ofcn_terc, pcas_trcds, custo, tipo_serv, valor_pago, dt_transacao, id_veic) VALUES
(1,  TRUE,  TRUE,  250.00, 'Preventiva',    250.00, '2024-01-20',  1),
(2,  TRUE,  TRUE,  180.00, 'Corretiva',     180.00, '2024-01-25',  4),
(3,  TRUE,  TRUE,  320.00, 'Troca de pneu', 320.00, '2024-02-10',  6),
(4,  TRUE,  TRUE,  400.00, 'Preventiva',    400.00, '2024-02-18',  2),
(5,  TRUE,  TRUE,  350.00, 'Corretiva',     350.00, '2024-02-28', 11),
(6,  TRUE,  TRUE,  480.00, 'Preventiva',    480.00, '2024-03-05',  6),
(7,  TRUE,  TRUE,  900.00, 'Corretiva',     900.00, '2024-03-12', 15),
(8,  FALSE, FALSE, 120.00, 'Preventiva',    120.00, '2024-03-22',  7),
(9,  TRUE,  TRUE,  550.00, 'Corretiva',     550.00, '2024-04-05',  8),
(10, TRUE,  TRUE,  310.00, 'Troca de pneu', 310.00, '2024-04-14', 13),
(11, TRUE,  TRUE,  620.00, 'Corretiva',     620.00, '2024-04-22',  4),
(12, TRUE,  FALSE, 450.00, 'Preventiva',    450.00, '2024-05-03',  8),
(13, TRUE,  TRUE,  780.00, 'Corretiva',     780.00, '2024-05-15', 15),
(14, FALSE, FALSE,  90.00, 'Limpeza',        90.00, '2024-05-25',  1),
(15, TRUE,  TRUE,  160.00, 'Preventiva',    160.00, '2024-06-02', 12);
 
 
-- Reajuste de 8% para funcionários contratados antes de 2020
UPDATE Funcionario
SET salario = ROUND(salario * 1.08, 2)
WHERE dt_contrat < '2020-01-01';
 
-- Marca o Argo como disponível após conclusão da manutenção e atualiza KM
UPDATE Veiculo
SET
    dspnb = TRUE,
    km    = 21350
WHERE id_veic = 4;
 

 
-- C1: Conta quantos clientes existem em cada estado (UF)
SELECT
    SUBSTR(endereco, LENGTH(endereco) - 1, 2) AS uf,
    COUNT(*) AS total_clientes
FROM Cliente
GROUP BY uf
ORDER BY total_clientes DESC;
 
-- C2: Agrupa clientes em faixas etárias usando o ano de nascimento
SELECT
    CASE
        WHEN (STRFTIME('%Y', 'now') - STRFTIME('%Y', data_nascimento)) BETWEEN 18 AND 29 THEN '18-29'
        WHEN (STRFTIME('%Y', 'now') - STRFTIME('%Y', data_nascimento)) BETWEEN 30 AND 39 THEN '30-39'
        WHEN (STRFTIME('%Y', 'now') - STRFTIME('%Y', data_nascimento)) BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50+'
    END AS faixa_etaria,
    COUNT(*) AS total
FROM Cliente
GROUP BY faixa_etaria
ORDER BY faixa_etaria;
 
-- F1: Agrupa funcionários por faixa salarial e calcula a média de cada faixa
SELECT
    CASE
        WHEN salario < 3500                    THEN 'Ate R$ 3.500'
        WHEN salario BETWEEN 3500 AND 4500     THEN 'R$ 3.500 a R$ 4.500'
        ELSE 'Acima de R$ 4.500'
    END AS faixa_salarial,
    COUNT(*)               AS total_funcionarios,
    ROUND(AVG(salario), 2) AS media_salarial
FROM Funcionario
GROUP BY faixa_salarial
ORDER BY media_salarial DESC;
 
-- F2: Mostra o maior, menor salário e total da folha por ano de contratação
SELECT
    STRFTIME('%Y', dt_contrat) AS ano_contratacao,
    MAX(salario)               AS maior_salario,
    MIN(salario)               AS menor_salario,
    SUM(salario)               AS folha_total
FROM Funcionario
GROUP BY ano_contratacao
ORDER BY ano_contratacao;
 
-- V1: Conta veículos e calcula a média de KM por marca
SELECT
    marca,
    COUNT(*)          AS total_veiculos,
    ROUND(AVG(km), 2) AS media_km
FROM Veiculo
GROUP BY marca
ORDER BY total_veiculos DESC;
 
-- V2: Mostra quantos veículos estão disponíveis e indisponíveis por ano de fabricação
SELECT
    ano_fab,
    SUM(CASE WHEN dspnb = 1 THEN 1 ELSE 0 END) AS disponiveis,
    SUM(CASE WHEN dspnb = 0 THEN 1 ELSE 0 END) AS indisponiveis,
    COUNT(*)                                    AS total
FROM Veiculo
GROUP BY ano_fab
ORDER BY ano_fab;
 
-- K1: Conta contratos e soma a receita gerada por status
SELECT
    status_contrato,
    COUNT(*)         AS total_contratos,
    SUM(valor_total) AS receita_total
FROM Contrato
GROUP BY status_contrato
ORDER BY receita_total DESC;
 
-- K2: Mostra quantos contratos cada funcionário realizou e o valor médio
SELECT
    f.nome,
    COUNT(c.id_contrato)         AS contratos_realizados,
    ROUND(AVG(c.valor_total), 2) AS ticket_medio
FROM Contrato c
JOIN Funcionario f ON f.id_func = c.id_func
GROUP BY f.nome
ORDER BY contratos_realizados DESC;
 
-- P1: Agrupa pagamentos por método e calcula total arrecadado e ticket médio
SELECT
    metodo_pag,
    COUNT(*)                 AS total_transacoes,
    SUM(valor_pag)           AS valor_total_arrecadado,
    ROUND(AVG(valor_pag), 2) AS ticket_medio
FROM Pagamento
GROUP BY metodo_pag
ORDER BY valor_total_arrecadado DESC;
 
-- P2: Agrupa pagamentos por mês e status para acompanhar a evolução mensal
SELECT
    STRFTIME('%Y-%m', dt_transacao) AS mes,
    status_aprov,
    COUNT(*)                        AS qtd_pagamentos,
    SUM(valor_pag)                  AS valor_total
FROM Pagamento
GROUP BY mes, status_aprov
ORDER BY mes, status_aprov;
 
-- M1: Agrupa manutenções por tipo de serviço e calcula custo total e médio
SELECT
    tipo_serv,
    COUNT(*)             AS total_manutencoes,
    SUM(custo)           AS custo_total,
    ROUND(AVG(custo), 2) AS custo_medio
FROM Manutencao
GROUP BY tipo_serv
ORDER BY custo_total DESC;
 
-- M2: Soma o custo de manutenção por veículo e indica uso de oficina e troca de peças
SELECT
    v.modelo,
    v.placa,
    COUNT(m.id_manutencao)                             AS total_manutencoes,
    SUM(m.custo)                                       AS custo_total,
    SUM(CASE WHEN m.ofcn_terc  = 1 THEN 1 ELSE 0 END) AS qtd_oficina_terceirizada,
    SUM(CASE WHEN m.pcas_trcds = 1 THEN 1 ELSE 0 END) AS qtd_com_troca_pecas
FROM Manutencao m
JOIN Veiculo v ON v.id_veic = m.id_veic
GROUP BY v.modelo, v.placa
ORDER BY custo_total DESC;
 

-- JOIN 1: INNER JOIN – lista contratos ativos com cliente, funcionário e veículo
SELECT
    c.id_contrato,
    c.dt_inicio,
    c.dt_dv_prevista,
    c.status_contrato,
    c.valor_total,
    cl.nome_completo AS cliente,
    f.nome           AS funcionario,
    v.modelo         AS veiculo,
    v.placa
FROM Contrato c
INNER JOIN Cliente     cl ON cl.id_cliente = c.id_cliente
INNER JOIN Funcionario f  ON f.id_func     = c.id_func
INNER JOIN Veiculo     v  ON v.id_veic     = c.id_veic
WHERE c.status_contrato = 'Ativo'
ORDER BY c.dt_inicio;
 
-- JOIN 2: LEFT JOIN – lista todos os veículos com o total gasto em manutenção
-- (veículos sem manutenção aparecem com custo 0)
SELECT
    v.modelo,
    v.placa,
    v.marca,
    v.ano_fab,
    COUNT(m.id_manutencao)    AS total_manutencoes,
    COALESCE(SUM(m.custo), 0) AS custo_total_manutencao
FROM Veiculo v
LEFT JOIN Manutencao m ON m.id_veic = v.id_veic
GROUP BY v.id_veic, v.modelo, v.placa, v.marca, v.ano_fab
ORDER BY custo_total_manutencao DESC;
 
-- JOIN 3: LEFT JOIN – lista todos os clientes com total de contratos e valor pago
-- (clientes sem contrato aparecem com valores zerados)
SELECT
    cl.nome_completo              AS cliente,
    cl.email,
    COUNT(DISTINCT c.id_contrato) AS total_contratos,
    COALESCE(SUM(p.valor_pag), 0) AS total_pago
FROM Cliente cl
LEFT JOIN Contrato  c ON c.id_cliente  = cl.id_cliente
LEFT JOIN Pagamento p ON p.id_contrato = c.id_contrato
GROUP BY cl.id_cliente, cl.nome_completo, cl.email
ORDER BY total_pago DESC;
 
-- JOIN 4: INNER JOIN – lista pagamentos aprovados com o veículo e método usado
SELECT
    p.id_pag,
    p.dt_transacao,
    p.metodo_pag,
    p.valor_pag,
    p.status_aprov,
    v.modelo AS veiculo,
    v.placa
FROM Pagamento p
INNER JOIN Contrato c ON c.id_contrato = p.id_contrato
INNER JOIN Veiculo  v ON v.id_veic     = c.id_veic
WHERE p.status_aprov = 'Aprovado'
ORDER BY p.valor_pag DESC;