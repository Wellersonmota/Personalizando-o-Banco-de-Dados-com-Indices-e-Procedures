# 🗄️ Desafio de Projeto: Modelagem e Implementação de Banco de Dados SQL

Este repositório contém a resolução dos desafios de projeto do Bootcamp da DIO (Digital Innovation One). O objetivo foi modelar cenários do mundo real (E-commerce e Oficina Mecânica), implementá-los em SQL e aplicar técnicas avançadas de otimização e automação.

## 📋 Conteúdo do Repositório

O projeto está dividido em três partes principais:

1.  **E-commerce Refinado:** Modelagem lógica com refinamentos de regras de negócio.
2.  **Oficina Mecânica:** Criação de um esquema do zero para gerenciamento de ordens de serviço.
3.  **Otimização e Automação:** Criação de Índices para performance e Stored Procedures para manipulação de dados.

---

## 🚀 Parte 1: E-commerce (Refinado)

O modelo original foi evoluído para suportar regras de negócio mais complexas e realistas.

### 🔧 Refinamentos Aplicados
* **Cliente PJ e PF:** Implementação de especialização/herança. Um cliente não pode ser PJ e PF ao mesmo tempo (garantido via tabela e lógica de inserção).
* **Pagamento:** Suporte a múltiplas formas de pagamento por cliente.
* **Entrega:** Nova tabela com status de entrega e código de rastreio independente do pedido.

### 📂 Arquivos
* `src/ecommerce/1_esquema_bd.sql`: Estrutura DDL.
* `src/ecommerce/2_persistencia.sql`: Massa de dados para testes.
* `src/ecommerce/3_queries.sql`: Consultas analíticas (JOINs, HAVING, etc).

---

## 🚗 Parte 2: Oficina Mecânica

Modelagem completa de um sistema para gerenciar o fluxo de trabalho de uma oficina.

### ⚙️ Regras de Negócio
* **Clientes e Veículos:** Relação 1:N (Um cliente pode ter vários carros).
* **Equipes de Mecânicos:** As OS são atribuídas a equipes, não apenas a um mecânico isolado.
* **Ordem de Serviço (OS):** Entidade central que agrega **Peças** (Estoque) e **Serviços** (Mão de obra) através de relacionamentos N:M.

### 📂 Arquivos
* `src/oficina/schema_oficina.sql`: Estrutura DDL.
* `src/oficina/data_oficina.sql`: Inserção de dados.
* `src/oficina/queries_oficina.sql`: Consultas complexas para relatórios.

---

## ⚡ Parte 3: Performance e Automação

Nesta etapa, focamos em otimizar consultas no cenário "Company" e automatizar o CRUD no E-commerce.

### 🔍 Otimização com Índices (Company DB)

Abaixo, a justificativa para a criação dos índices baseada nas queries solicitadas:

| Query / Pergunta | Índice Criado | Motivo da Escolha |
| :--- | :--- | :--- |
| **Qual o departamento com maior número de pessoas?** | `idx_employee_dno` em `employee(Dno)` | A consulta realiza um `JOIN` massivo e um `GROUP BY` na chave estrangeira. O índice B-Tree agiliza o agrupamento dos funcionários por departamento. |
| **Quais são os departamentos por cidade?** | `idx_dept_location` em `dept_locations(Dlocation)` | A cláusula `WHERE` filtra por uma cidade específica. Sem índice, ocorreria um *Full Table Scan*. O índice permite acesso direto aos registros da cidade alvo. |
| **Relação de empregados por departamento** | `idx_dept_name_employee` (Composto ou na ordenação) | Para evitar *File Sort* (ordenação em disco/memória) durante o `ORDER BY`, índices nas colunas de ordenação aceleram a entrega do resultado. |

> **Nota:** Foi utilizado o algoritmo **B-Tree** (padrão do MySQL/InnoDB), pois é o mais eficiente para buscas de igualdade, intervalos e ordenação, cobrindo todos os casos acima.

### 🤖 Automação com Stored Procedures

Foi criada a procedure `ManageClient` para padronizar o acesso aos dados dos clientes, tratando a complexidade de inserir em tabelas genéricas (`clients`) e especializadas (`clients_pf` / `clients_pj`) automaticamente.

**Variável de Controle (`op_code`):**
* `1`: **Insert** (Insere na tabela pai e na tabela filha correta baseada no tipo).
* `2`: **Update** (Atualiza dados cadastrais).
* `3`: **Delete** (Remove em cascata).

---

## 🛠️ Tecnologias Utilizadas
* **Banco de Dados:** MySQL
* **Ferramenta de Modelagem:** MySQL Workbench
* **Linguagem:** SQL (DDL, DML, DQL, TCL)

## 👤 Autor

Desenvolvido por **[Seu Nome Aqui]** como parte do Bootcamp Database Experience.
