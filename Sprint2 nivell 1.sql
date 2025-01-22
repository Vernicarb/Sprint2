-- Nivell 1
-- Exercici 2
-- (Utilitzant JOIN realitzaràs les següents consultes):

-- Llistat dels països que estan fent compres.

SELECT DISTINCT country 
FROM company
JOIN transaction ON company.id = transaction.company_id
WHERE declined = 0;

-- Des de quants països es realitzen les compres.

SELECT COUNT(DISTINCT country)
FROM company
JOIN transaction ON company.id = transaction.company_id
WHERE declined = 0;

-- Identifica la companyia amb la mitjana més gran de vendes.

SELECT company_name, ROUND(AVG(amount),2) AS mitjana_vendes
FROM company
JOIN transaction ON company.id = transaction.company_id
WHERE declined = 0
GROUP BY company_name
ORDER BY mitjana_vendes DESC
LIMIT 1;

-- Exercici 3
-- Utilitzant només subconsultes (sense utilitzar JOIN):

-- Mostra totes les transaccions realitzades per empreses d'Alemanya.

-- Primero hago la subconsulta: SELECT id FROM company WHERE country = "Germany"

SELECT *
FROM transaction
WHERE company_id IN (SELECT id FROM company WHERE country = 'Germany') 
AND declined = 0;

-- Llista les empreses que han realitzat transaccions per un amount superior a la mitjana de totes les transaccions.

-- Primero se busca la subconsulta:

-- SELECT DISTINCT company_id FROM transaction WHERE amount > (SELECT AVG(amount) FROM transaction WHERE declined =0) AND declined =0;

SELECT company_name
FROM company
WHERE id IN (
SELECT DISTINCT company_id FROM transaction WHERE amount > (SELECT AVG(amount) FROM transaction WHERE declined =0) 
AND declined =0);

-- Eliminaran del sistema les empreses que no tenen transaccions registrades, entrega el llistat d'aquestes empreses.

-- Primero se hace la subconsulta de las empresas que si han hecho transacciones: 
-- SELECT DISTINCT company_id FROM transaction WHERE declined =0;

SELECT *
FROM company
WHERE id NOT IN (SELECT DISTINCT company_id FROM transaction WHERE declined = 0);

-- Otro método
SELECT *
FROM company
WHERE NOT EXISTS (SELECT DISTINCT company_id FROM transaction WHERE declined = 0);

