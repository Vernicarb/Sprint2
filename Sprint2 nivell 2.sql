-- Nivell 2

-- Exercici 1
-- Identifica els cinc dies que es va generar la quantitat més gran d'ingressos a l'empresa per vendes. Mostra la data de cada transacció juntament amb el total de les vendes.

SELECT DATE(timestamp), sum(amount) AS total_vendes
FROM transaction
WHERE declined =0
GROUP BY DATE(timestamp)
ORDER BY total_vendes DESC
LIMIT 5;

-- Exercici 2
-- Quina és la mitjana de vendes per país? Presenta els resultats ordenats de major a menor mitjà.

SELECT DISTINCT company.country, AVG(amount) AS mitjana_vendes
FROM transaction
JOIN company ON transaction.company_id = company.id 
WHERE declined = 0
GROUP BY company.country
ORDER BY mitjana_vendes DESC;

-- Exercici 3
-- En la teva empresa, es planteja un nou projecte per a llançar algunes campanyes publicitàries per a fer competència a la companyia "Non Institute". Per a això, et demanen la llista de totes les transaccions realitzades per empreses que estan situades en el mateix país que aquesta companyia.
-- Mostra el llistat aplicant JOIN i subconsultes.

-- Primer es fa la subconsulta (SELECT country FROM company WHERE company_name = 'Non Institute') 

SELECT *
FROM transaction
JOIN company ON company.id = transaction.company_id
WHERE declined=0 AND country = (SELECT country FROM company WHERE company_name = 'Non Institute') 
AND company_name != 'Non Institute'
ORDER BY company_name
;

-- Mostra el llistat aplicant solament subconsultes.

SELECT *
FROM transaction
WHERE declined = 0
AND company_id IN (SELECT id FROM company
WHERE country = (SELECT country FROM company WHERE company_name = 'Non Institute')
AND company_name != 'Non Institute')
ORDER BY company_id;
