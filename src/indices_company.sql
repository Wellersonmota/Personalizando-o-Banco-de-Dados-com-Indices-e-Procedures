/*
  PARTE 1: OTIMIZAÇÃO COM ÍNDICES - CENÁRIO COMPANY
  Objetivo: Criar queries e otimizar a performance com índices.
*/

-- 1. Qual o departamento com maior número de pessoas?
-- Query:
SELECT d.Dname, COUNT(e.Ssn) as Num_Employees
FROM department d
JOIN employee e ON d.Dnumber = e.Dno
GROUP BY d.Dname
ORDER BY Num_Employees DESC
LIMIT 1;

-- Criação do Índice para a Pergunta 1:
-- Motivo: A query realiza um JOIN em 'Dno' e agrupa os dados. 
-- Um índice na chave estrangeira (fk) da tabela employee acelera a junção.
CREATE INDEX idx_employee_dno ON employee(Dno);


-- 2. Quais são os departamentos por cidade?
-- Query:
SELECT d.Dname, l.Dlocation
FROM department d
JOIN dept_locations l ON d.Dnumber = l.Dnumber
WHERE l.Dlocation = 'Houston'; -- Exemplo de cidade

-- Criação do Índice para a Pergunta 2:
-- Motivo: A cláusula WHERE busca por uma cidade específica. 
-- Um índice na coluna de localização evita o "Full Table Scan".
CREATE INDEX idx_dept_location ON dept_locations(Dlocation);


-- 3. Relação de empregados por departamento
-- Query:
SELECT d.Dname, e.Fname, e.Lname
FROM department d
JOIN employee e ON d.Dnumber = e.Dno
ORDER BY d.Dname, e.Fname;

-- Criação do Índice para a Pergunta 3:
-- Motivo: Além do JOIN (já coberto pelo índice idx_employee_dno), 
-- a ordenação beneficia-se de índices compostos se a busca for muito frequente.
-- Aqui criamos um índice composto para cobrir a ordenação.
CREATE INDEX idx_dept_name_employee ON department(Dname);