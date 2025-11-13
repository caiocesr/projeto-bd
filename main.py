import mysql.connector

def conectar():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="sua_senha",
        database="projeto_bd"
    )

def criar_tabelas(cursor):
    tabelas = [
        """
        #Usado para  definir strings multilinha, permitindo que escreva comandos SQL com várias linhas de forma legível e organizada.
        CREATE TABLE IF NOT EXISTS CLIENTE (
            id_cliente INT AUTO_INCREMENT PRIMARY KEY,
            nome VARCHAR(50),
            sobrenome VARCHAR(50),
            endereco VARCHAR(100),
            telefone VARCHAR(15)
        );
    """,
    """
        CREATE TABLE IF NOT EXISTS FUNCIONARIO (
            id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
            nome VARCHAR(50),
            cargo VARCHAR(50),
            salario DECIMAL(10,2),
            telefone VARCHAR(15),
            email VARCHAR(100),
            data_admissao DATE
    );
    """,
    """
        CREATE TABLE IF NOT EXISTS PRODUTO (
            id_produto INT AUTO_INCREMENT PRIMARY KEY,
            nome_produto VARCHAR(50),
            categoria VARCHAR(50),
            descricao TEXT,
            preco DECIMAL(10,2),
            estoque INT,
            fornecedor VARCHAR(100)
    );
    """,
    """
        CREATE TABLE IF NOT EXISTS SERVICO (
            id_servico INT AUTO_INCREMENT PRIMARY KEY,
            descricao VARCHAR(100),
            preco DECIMAL(10,2),
            duracao_estimada INT,
            tipo VARCHAR(50)
    );
    """,
    """
        CREATE TABLE IF NOT EXISTS ATENDIMENTO (
            id_atendimento INT AUTO_INCREMENT PRIMARY KEY,
            data_hora DATETIME,
            status VARCHAR(50),
            observacoes TEXT,
            id_cliente INT,
            id_funcionario INT,
            FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
            FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO (id_funcionario)
    );
    """,
    """
        CREATE TABLE IF NOT EXISTS VENDA (
            id_venda INT AUTO_INCREMENT PRIMARY KEY,
            data_venda DATE,
            valor_total DECIMAL(10,2),
            forma_pagamento ENUM('dinheiro, cartao', 'pix'),
            id_cliente INT,
            id_funcionario INT,
            FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
            FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO (id_funcionario)
    );
    """,
    """
        CREATE TABLE IF NOT EXISTS ITEM_VENDA (
            id_item_venda INT AUTO_INCREMENT PRIMARY KEY,
            id_venda INT,
            id_produto INT,
            quantidade INT,
            preco_unitario DECIMAL(10,2),
            FOREIGN KEY(id_venda) REFERENCES VENDA(id_venda),
            FOREIGN KEY(id_produto) REFERENCES PRODUTO(id_produto),
    );
    """
]
    for sql in tabelas:
        cursor.execute(sql)
    print("Tabela criada com sucesso!")

def executar_consultas(cursor):
    print("Registros de compras de clientes:")
    cursor.execute("""
        SELECT c.nome, c.sobrenome
        FROM CLIENTE c
        INNER JOIN VENDA v ON c.id_cliente = v.id_cliente;
    """)
    for linha in cursor.fetchall():
        print(linha)

    print("Produtos em estoque > 60:")
    cursor.execute("""
        SELECT nome_produto, categoria, preco, estoque
        FROM PRODUTO
        WHERE estoque > 60;
    """)
    for linha in cursor.fetchall():
        print(linha)

    print("Valor médio de serviços:")
    cursor.execute("SELECT AVG(preco) FROM SERVICO;")
    print(cursor.fetchone())

def main():
    conexao = conectar()
    cursor = conexao.cursor()
    criar_tabelas(cursor)

    executar_consultas(cursor)
    conexao.commit()
    cursor.close()
    conexao.close()

if __name__ == "__main__":
    main()
