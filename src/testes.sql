-- Teste 1: Inserir um novo cliente PF (Opção 1)
-- Parâmetros: Op, ID(0), Nome, M, Sobrenome, Endereço, Tipo, CPF
CALL ManageClient(1, 0, 'Novo', 'T', 'User', 'Rua Teste 1', 'PF', '99988877700');

-- Teste 2: Atualizar o endereço do cliente ID 1 (Opção 2)
CALL ManageClient(2, 1, 'Maria', 'M', 'Silva', 'Novo Endereço Atualizado', 'PF', NULL);

-- Teste 3: Deletar o cliente que acabamos de criar (Verifique o ID gerado antes)
-- Supondo que o ID gerado no teste 1 foi 5
CALL ManageClient(3, 5, NULL, NULL, NULL, NULL, NULL, NULL);