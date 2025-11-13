use clinica_pspsvet;

CREATE TABLE CLIENTE (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(150),
    data_cadastro DATE
);

CREATE TABLE ANIMAL (
    id_animal INT PRIMARY KEY AUTO_INCREMENT,
    nome_animal VARCHAR(50) NOT NULL,
    especie VARCHAR(30),
    raca VARCHAR(50),
    data_nascimento DATE,
    peso DECIMAL(5,2),
    observacoes VARCHAR(300),
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);

CREATE TABLE FUNCIONARIO (
    id_func INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10,2),
    telefone VARCHAR(20),
    email VARCHAR(100),
    data_admissao DATE
);

CREATE TABLE SERVICO (
    id_servico INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(100) NOT NULL,
    preco DECIMAL(8,2),
    duracao_media INT, -- em minutos
    tipo VARCHAR(30) -- 'Consulta', 'Banho', 'Tosa', 'Vacina', etc.
);

CREATE TABLE PRODUTO (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(80) NOT NULL,
    categoria VARCHAR(30),
    descricao VARCHAR(200),
    preco DECIMAL(8,2),
    estoque INT,
    fornecedor VARCHAR(100)
);

CREATE TABLE ATENDIMENTO (
    id_atendimento INT PRIMARY KEY AUTO_INCREMENT,
    data_atendimento DATETIME,
    status VARCHAR(20), -- 'Agendado', 'Realizado', 'Cancelado'
    observacoes VARCHAR(300),
    id_animal INT NOT NULL,
    id_func INT NOT NULL,
    FOREIGN KEY (id_animal) REFERENCES ANIMAL(id_animal),
    FOREIGN KEY (id_func) REFERENCES FUNCIONARIO(id_func)
);

CREATE TABLE ATENDIMENTO_SERVICO (
    id_atendimento INT,
    id_servico INT,
    PRIMARY KEY (id_atendimento, id_servico),
    FOREIGN KEY (id_atendimento) REFERENCES ATENDIMENTO(id_atendimento),
    FOREIGN KEY (id_servico) REFERENCES SERVICO(id_servico)
);

CREATE TABLE VENDA (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATETIME,
    valor_total DECIMAL(10,2),
    forma_pagamento VARCHAR(20), -- 'Dinheiro', 'Cartão', 'PIX'
    id_cliente INT NOT NULL,
    id_func INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_func) REFERENCES FUNCIONARIO(id_func)
);

CREATE TABLE ITEM_VENDA (
    id_venda INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(8,2),
    PRIMARY KEY (id_venda, id_produto),
    FOREIGN KEY (id_venda) REFERENCES VENDA(id_venda),
    FOREIGN KEY (id_produto) REFERENCES PRODUTO(id_produto)
);

CREATE TABLE VACINA (
    id_vacina INT PRIMARY KEY AUTO_INCREMENT,
    nome_vacina VARCHAR(80) NOT NULL,
    fabricante VARCHAR(50),
    dose VARCHAR(20), -- 'Primeira', 'Segunda', 'Reforço'
    validade DATE,
    lote VARCHAR(30)
);

CREATE TABLE VACINACAO (
    id_vacinacao INT PRIMARY KEY AUTO_INCREMENT,
    data_aplicacao DATE,
    proxima_dose DATE,
    id_animal INT NOT NULL,
    id_vacina INT NOT NULL,
    id_func INT NOT NULL,
    FOREIGN KEY (id_animal) REFERENCES ANIMAL(id_animal),
    FOREIGN KEY (id_vacina) REFERENCES VACINA(id_vacina),
    FOREIGN KEY (id_func) REFERENCES FUNCIONARIO(id_func)
);

INSERT INTO CLIENTE (nome, telefone, email, endereco, data_cadastro) VALUES
('Ana Silva', '(86) 99999-1111', 'ana.silva@email.com', 'Rua das Flores, 123 - Centro', '2023-01-15'),
('Carlos Oliveira', '(86) 99999-2222', 'carlos.oliveira@email.com', 'Av. Principal, 456 - Norte', '2023-02-20'),
('Mariana Santos', '(86) 99999-3333', 'mariana.santos@email.com', 'Travessa da Paz, 789 - Sul', '2023-03-10'),
('Roberto Costa', '(86) 99999-4444', 'roberto.costa@email.com', 'Rua dos Animais, 321 - Leste', '2023-04-05'),
('Fernanda Lima', '(86) 99999-5555', 'fernanda.lima@email.com', 'Alameda das Árvores, 654 - Oeste', '2023-05-12'),
('Paulo Souza', '(86) 99999-6666', 'paulo.souza@email.com', 'Praça Central, 987 - Centro', '2023-06-18'),
('Juliana Pereira', '(86) 99999-7777', 'juliana.pereira@email.com', 'Rua Nova, 159 - Norte', '2023-07-22'),
('Ricardo Alves', '(86) 99999-8888', 'ricardo.alves@email.com', 'Av. Comercial, 753 - Sul', '2023-08-30'),
('Patrícia Martins', '(86) 99999-9999', 'patricia.martins@email.com', 'Travessa do Sol, 246 - Leste', '2023-09-14'),
('Bruno Ferreira', '(86) 99999-0000', 'bruno.ferreira@email.com', 'Rua da Esperança, 864 - Oeste', '2023-10-25');

SELECT * FROM CLIENTE;

INSERT INTO ANIMAL (nome_animal, especie, raca, data_nascimento, peso, observacoes, id_cliente) VALUES
('Rex', 'Cachorro', 'Labrador', '2020-05-15', 25.50, 'Animal dócil e brincalhão', 1),
('Mimi', 'Gato', 'Siamês', '2021-08-20', 4.20, 'Gato arisco, cuidado ao manusear', 1),
('Thor', 'Cachorro', 'Pastor Alemão', '2019-03-10', 32.00, 'Animal grande, necessita focinheira', 2),
('Luna', 'Gato', 'Persa', '2022-01-25', 3.80, 'Pelagem longa, necessita escovação', 3),
('Bob', 'Cachorro', 'Poodle', '2020-11-30', 8.50, 'Idoso, problemas articulares', 4),
('Nina', 'Cachorro', 'Vira-lata', '2021-07-12', 12.30, 'Resgatada da rua, medrosa', 5),
('Simba', 'Gato', 'Maine Coon', '2019-12-05', 6.80, 'Gato grande e tranquilo', 6),
('Mel', 'Cachorro', 'Golden Retriever', '2020-09-18', 28.00, 'Muito energético', 7),
('Bichano', 'Gato', 'Vira-lata', '2022-03-22', 4.50, 'Filhote, primeira consulta', 8),
('Pandora', 'Cachorro', 'Bulldog Francês', '2021-04-14', 10.20, 'Problemas respiratórios', 9);

SELECT * FROM ANIMAL;

INSERT INTO FUNCIONARIO (nome, cargo, salario, telefone, email, data_admissao) VALUES
('Dr. João Mendes', 'Veterinário', 6500.00, '(86) 98888-1111', 'joao.mendes@petcare.com', '2020-03-15'),
('Dra. Maria Santos', 'Veterinária', 6200.00, '(86) 98888-2222', 'maria.santos@petcare.com', '2021-06-10'),
('Carlos Lima', 'Atendente', 1850.00, '(86) 98888-3333', 'carlos.lima@petcare.com', '2023-01-10'),
('Fernanda Costa', 'Tosadora', 2200.50, '(86) 98888-4444', 'fernanda.costa@petcare.com', '2022-08-22'),
('Roberto Silva', 'Auxiliar Veterinário', 2800.75, '(86) 98888-5555', 'roberto.silva@petcare.com', '2021-05-30'),
('Juliana Oliveira', 'Gerente', 4200.00, '(86) 98888-6666', 'juliana.oliveira@petcare.com', '2019-11-05'),
('Pedro Almeida', 'Veterinário', 5800.00, '(86) 98888-7777', 'pedro.almeida@petcare.com', '2022-02-14'),
('Amanda Rocha', 'Atendente', 1800.00, '(86) 98888-8888', 'amanda.rocha@petcare.com', '2023-03-20'),
('Ricardo Nunes', 'Banhista', 1950.25, '(86) 98888-9999', 'ricardo.nunes@petcare.com', '2022-11-08'),
('Camila Torres', 'Recepcionista', 1750.00, '(86) 98888-0000', 'camila.torres@petcare.com', '2023-07-01');

SELECT * FROM FUNCIONARIO;

INSERT INTO SERVICO (descricao, preco, duracao_media, tipo) VALUES
('Consulta Veterinária Básica', 120.00, 30, 'Consulta'),
('Consulta de Emergência', 250.00, 60, 'Consulta'),
('Banho Completo', 50.00, 45, 'Banho'),
('Tosa Higiênica', 40.00, 30, 'Tosa'),
('Tosa Completa', 80.00, 60, 'Tosa'),
('Vacinação V10', 90.00, 15, 'Vacina'),
('Vacinação Antirrábica', 60.00, 15, 'Vacina'),
('Limpeza de Ouvidos', 25.00, 15, 'Limpeza'),
('Corte de Unhas', 20.00, 10, 'Cuidados'),
('Aplicação de Medicamento', 15.00, 10, 'Medicamento');

INSERT INTO PRODUTO (nome_produto, categoria, descricao, preco, estoque, fornecedor) VALUES
('Ração Premium Cães Adultos', 'Alimentação', 'Ração 15kg para cães adultos', 180.00, 50, 'PetFood Ltda'),
('Ração Premium Gatos Castrados', 'Alimentação', 'Ração 10kg para gatos castrados', 120.00, 40, 'PetFood Ltda'),
('Shampoo Hidratante', 'Higiene', 'Shampoo para pets com pele sensível', 25.00, 100, 'CleanPet'),
('Brinquedo Osso de Borracha', 'Brinquedos', 'Brinquedo resistente para cães', 18.00, 75, 'ToyPet'),
('Coleira Antipulgas', 'Acessórios', 'Coleira com proteção contra pulgas', 35.00, 60, 'PetSafe'),
('Antipulgas e Carrapatos', 'Medicamento', 'Pipeta para controle de parasitas', 45.00, 80, 'VetPharma'),
('Areia Sanitária', 'Higiene', 'Areia para gatos 5kg', 22.00, 120, 'CleanPet'),
('Cama para Cães M', 'Conforto', 'Cama tamanho médio para cães', 85.00, 25, 'PetComfort'),
('Vermífugo', 'Medicamento', 'Vermífugo para cães e gatos', 30.00, 90, 'VetPharma'),
('Tapete Higiênico', 'Higiene', 'Tapete absorvente para treinamento', 55.00, 45, 'CleanPet');

INSERT INTO ATENDIMENTO (data_atendimento, status, observacoes, id_animal, id_func) VALUES
('2024-01-10 09:00:00', 'Realizado', 'Animal saudável, vacinação em dia', 1, 1),
('2024-01-12 10:30:00', 'Realizado', 'Problema de pele, tratamento iniciado', 2, 2),
('2024-01-15 14:00:00', 'Realizado', 'Consulta de rotina, tudo normal', 3, 1),
('2024-01-18 11:00:00', 'Realizado', 'Castração agendada', 4, 2),
('2024-01-20 08:30:00', 'Realizado', 'Animal com febre, medicado', 5, 7),
('2024-01-22 15:30:00', 'Realizado', 'Banho e tosa realizados', 6, 4),
('2024-01-25 13:00:00', 'Realizado', 'Vacinação anual', 7, 1),
('2024-01-28 16:00:00', 'Realizado', 'Problema dental identificado', 8, 2),
('2024-02-01 10:00:00', 'Agendado', 'Consulta de acompanhamento', 9, 7),
('2024-02-05 09:30:00', 'Cancelado', 'Cliente desmarcou', 10, 1);

INSERT INTO ATENDIMENTO_SERVICO (id_atendimento, id_servico) VALUES
(1, 1), (1, 6),
(2, 1), (2, 10),
(3, 1),
(4, 1),
(5, 2), (5, 10),
(6, 3), (6, 4),
(7, 1), (7, 6),
(8, 1), (8, 8),
(9, 1),
(10, 1);

INSERT INTO VENDA (data_venda, valor_total, forma_pagamento, id_cliente, id_func) VALUES
('2024-01-10 09:30:00', 270.00, 'Cartão', 1, 3),
('2024-01-12 11:00:00', 85.00, 'Dinheiro', 2, 8),
('2024-01-15 14:30:00', 120.00, 'PIX', 3, 3),
('2024-01-18 11:45:00', 45.00, 'Cartão', 4, 8),
('2024-01-20 09:00:00', 180.00, 'Cartão', 5, 3),
('2024-01-22 16:00:00', 60.00, 'Dinheiro', 6, 8),
('2024-01-25 13:30:00', 95.00, 'PIX', 7, 3),
('2024-01-28 16:30:00', 140.00, 'Cartão', 8, 8),
('2024-02-01 10:30:00', 75.00, 'Dinheiro', 9, 3),
('2024-02-05 09:00:00', 200.00, 'Cartão', 10, 8);

INSERT INTO ITEM_VENDA (id_venda, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 180.00), (1, 6, 2, 45.00),
(2, 3, 1, 25.00), (2, 5, 1, 35.00), (2, 9, 1, 30.00),
(3, 2, 1, 120.00),
(4, 6, 1, 45.00),
(5, 1, 1, 180.00),
(6, 9, 2, 30.00),
(7, 7, 1, 22.00), (7, 8, 1, 85.00),
(8, 4, 2, 18.00), (8, 10, 1, 55.00), (8, 3, 1, 25.00),
(9, 5, 1, 35.00), (9, 3, 1, 25.00), (9, 9, 1, 30.00),
(10, 1, 1, 180.00), (10, 6, 1, 45.00);

INSERT INTO VACINA (nome_vacina, fabricante, dose, validade, lote) VALUES
('V10', 'Zoetis', 'Reforço', '2024-12-31', 'LOTE-V10-2024'),
('Antirrábica', 'Merial', 'Única', '2025-06-30', 'LOTE-RAIVA-2024'),
('Giardia', 'Virbac', 'Primeira', '2024-09-15', 'LOTE-GIARDIA-2024'),
('Leishmaniose', 'Hertape', 'Segunda', '2024-11-20', 'LOTE-LEISH-2024'),
('V4', 'Zoetis', 'Reforço', '2024-10-25', 'LOTE-V4-2024'),
('Gripe Canina', 'Merial', 'Primeira', '2024-08-10', 'LOTE-GRIPE-2024'),
('V5', 'Virbac', 'Segunda', '2024-07-30', 'LOTE-V5-2024'),
('Calicivirose', 'Hertape', 'Reforço', '2024-12-15', 'LOTE-CALICI-2024'),
('Panleucopenia', 'Zoetis', 'Primeira', '2024-09-05', 'LOTE-PANLEU-2024'),
('Clamidiose', 'Merial', 'Única', '2025-03-20', 'LOTE-CLAMID-2024');

INSERT INTO VACINACAO (data_aplicacao, proxima_dose, id_animal, id_vacina, id_func) VALUES
('2024-01-10', '2025-01-10', 1, 1, 1),
('2024-01-12', '2025-01-12', 2, 2, 2),
('2024-01-15', '2024-07-15', 3, 3, 1),
('2024-01-18', '2024-04-18', 4, 4, 2),
('2024-01-20', '2025-01-20', 5, 1, 7),
('2024-01-22', '2024-07-22', 6, 5, 1),
('2024-01-25', '2024-04-25', 7, 6, 2),
('2024-01-28', '2025-01-28', 8, 2, 7),
('2024-02-01', '2024-08-01', 9, 7, 1),
('2024-02-05', '2024-05-05', 10, 8, 2);

SELECT c.nome, COUNT(a.id_animal) as total_animais
FROM CLIENTE c
INNER JOIN ANIMAL a ON c.id_cliente = a.id_cliente
WHERE a.especie IN ('Cachorro', 'Gato')
GROUP BY c.id_cliente, c.nome;

SELECT v.data_venda, c.nome as cliente, v.valor_total, v.forma_pagamento
FROM VENDA v
INNER JOIN CLIENTE c ON v.id_cliente = c.id_cliente
WHERE v.data_venda BETWEEN '2024-01-15' AND '2024-01-30'
ORDER BY v.data_venda;

SELECT nome, cargo, salario
FROM FUNCIONARIO
WHERE salario >= 2000.00 AND salario <= 4000.00
ORDER BY salario DESC;

SELECT nome_produto, categoria, preco, estoque
FROM PRODUTO
WHERE (preco > 50.00) OR (estoque < 60)
ORDER BY preco DESC;

SELECT nome_produto, categoria, preco
FROM PRODUTO
ORDER BY preco ASC
LIMIT 5;

SELECT f.nome, f.cargo, COUNT(a.id_atendimento) as total_atendimentos
FROM FUNCIONARIO f
INNER JOIN ATENDIMENTO a ON f.id_func = a.id_func
WHERE f.cargo LIKE '%Veterinári%'
GROUP BY f.id_func, f.nome, f.cargo
ORDER BY total_atendimentos DESC;

SELECT c.nome as cliente, a.nome_animal, a.especie
FROM CLIENTE c
LEFT JOIN ANIMAL a ON c.id_cliente = a.id_cliente
ORDER BY c.nome;

SELECT tipo, AVG(preco) as preco_medio, COUNT(*) as total_servicos
FROM SERVICO
GROUP BY tipo
HAVING AVG(preco) > 60.00
ORDER BY preco_medio DESC;

SELECT nome, 'Cliente' as tipo FROM CLIENTE
UNION
SELECT nome, 'Funcionário' as tipo FROM FUNCIONARIO
ORDER BY nome;

SELECT 
    a.data_atendimento,
    cli.nome as cliente,
    ani.nome_animal,
    ani.especie,
    f.nome as veterinario,
    s.descricao as servico
FROM ATENDIMENTO a
INNER JOIN ANIMAL ani ON a.id_animal = ani.id_animal
INNER JOIN CLIENTE cli ON ani.id_cliente = cli.id_cliente
INNER JOIN FUNCIONARIO f ON a.id_func = f.id_func
INNER JOIN ATENDIMENTO_SERVICO asr ON a.id_atendimento = asr.id_atendimento
INNER JOIN SERVICO s ON asr.id_servico = s.id_servico
ORDER BY a.data_atendimento DESC
