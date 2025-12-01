USE ecommerce_refinado;

DELIMITER $$

CREATE PROCEDURE ManageClient(
    IN op_code INT,              -- Variável de controle: 1=Insert, 2=Update, 3=Delete
    IN p_idClient INT,           -- ID (Necessário para Update/Delete)
    IN p_Fname VARCHAR(15),      -- Dados para Insert/Update
    IN p_Minit VARCHAR(3),
    IN p_Lname VARCHAR(20),
    IN p_Address VARCHAR(255),
    IN p_clientType VARCHAR(5),  -- 'PF' ou 'PJ'
    IN p_Identification VARCHAR(20) -- CPF ou CNPJ (Simplificado para o exemplo)
)
BEGIN
    -- Lógica Condicional para determinar a ação
    CASE op_code
        -- 1. INSERÇÃO
        WHEN 1 THEN
            INSERT INTO clients (Fname, Minit, Lname, Address, clientType)
            VALUES (p_Fname, p_Minit, p_Lname, p_Address, p_clientType);
            
            -- Recupera o ID gerado para inserir na tabela especializada
            SET @new_id = LAST_INSERT_ID();
            
            IF p_clientType = 'PF' THEN
                INSERT INTO clients_pf (idClient, CPF) VALUES (@new_id, p_Identification);
            ELSEIF p_clientType = 'PJ' THEN
                INSERT INTO clients_pj (idClient, CNPJ) VALUES (@new_id, p_Identification);
            END IF;
            
            SELECT 'Cliente cadastrado com sucesso!' AS Mensagem;

        -- 2. ATUALIZAÇÃO
        WHEN 2 THEN
            UPDATE clients 
            SET Fname = p_Fname, 
                Lname = p_Lname, 
                Address = p_Address 
            WHERE idClient = p_idClient;
            
            SELECT 'Dados do cliente atualizados!' AS Mensagem;

        -- 3. REMOÇÃO
        WHEN 3 THEN
            -- Primeiro remove das tabelas filhas (constraint FK)
            DELETE FROM clients_pf WHERE idClient = p_idClient;
            DELETE FROM clients_pj WHERE idClient = p_idClient;
            -- Depois remove da tabela pai
            DELETE FROM clients WHERE idClient = p_idClient;
            
            SELECT 'Cliente removido com sucesso!' AS Mensagem;

        -- OPÇÃO INVÁLIDA
        ELSE
            SELECT 'Opção inválida. Use: 1-Insert, 2-Update, 3-Delete' AS Erro;
    END CASE;
END $$

DELIMITER ;