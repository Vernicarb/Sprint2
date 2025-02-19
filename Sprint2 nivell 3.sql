-- Nivell 3

-- Exercici 1
-- Presenta el nom, telèfon, país, data i amount, d'aquelles empreses que van realitzar transaccions amb un valor comprès entre 100 i 200 euros i en alguna d'aquestes dates: 29 d'abril del 2021, 20 de juliol del 2021 i 13 de març del 2022. Ordena els resultats de major a menor quantitat.

SELECT company_name, phone, country, timestamp,amount
FROM company
JOIN transaction ON company.id = transaction.company_id
WHERE declined = 0
AND amount BETWEEN 100 AND 200
AND DATE(timestamp) IN ('2021-04-29', '2021-07-20', '2022-03-13')
ORDER BY amount DESC;

-- Exercici 2
-- Necessitem optimitzar l'assignació dels recursos i dependrà de la capacitat operativa que es requereixi, per la qual cosa et demanen la informació sobre la quantitat de transaccions que realitzen les empreses, però el departament de recursos humans és exigent i vol un llistat de les empreses on especifiquis si tenen més de 4 transaccions o menys.

SELECT company_name, COUNT(transaction.id),
CASE WHEN COUNT(transaction.id) > 4 THEN 'Més de 4 transaccions'ELSE '4 o menys transaccions'
END AS classificacio
FROM company
LEFT JOIN transaction ON company.id = transaction.company_id AND declined = 0
GROUP BY company_name
ORDER BY COUNT(transaction.id) DESC;