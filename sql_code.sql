
USE corporate_kyc_aml;
USE corporate_kyc_aml;
SHOW DATABASES;
SELECT DATABASE();
USE corporate_kyc_aml;

CREATE TABLE companies (
    client_id INT PRIMARY KEY,
    company_name VARCHAR(200),
    company_type VARCHAR(100),
    country VARCHAR(100),
    industry VARCHAR(100),
    annual_revenue BIGINT,
    onboarding_date DATE,
    risk_status VARCHAR(50)
);

SHOW TABLES;

DESC companies;
CREATE TABLE documents (
    document_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    document_name VARCHAR(200),
    status VARCHAR(50),
    submission_date DATE,
    expiry_date DATE,
    FOREIGN KEY (client_id)
        REFERENCES companies(client_id)
);
CREATE TABLE ownership (
    owner_id INT PRIMARY KEY,
    client_id INT,
    owner_name VARCHAR(200),
    ownership_percentage DECIMAL(5,2),
    owner_type VARCHAR(50),
    FOREIGN KEY (client_id)
        REFERENCES companies(client_id)
);
CREATE TABLE ubo_details (
    ubo_id INT PRIMARY KEY,
    client_id INT,
    ubo_name VARCHAR(200),
    ownership_percent DECIMAL(5,2),
    country VARCHAR(100),
    pep_status VARCHAR(20),
    FOREIGN KEY (client_id)
        REFERENCES companies(client_id)
);
CREATE TABLE transactions (
    txn_id VARCHAR(20) PRIMARY KEY,
    client_id INT,
    txn_amount DECIMAL(15,2),
    currency VARCHAR(10),
    country VARCHAR(100),
    risk_flag VARCHAR(10),
    FOREIGN KEY (client_id)
        REFERENCES companies(client_id)
);
CREATE TABLE sanctions_list (
    entity_name VARCHAR(200),
    country VARCHAR(100),
    sanction_status VARCHAR(50)
);
SHOW TABLES;
SHOW DATABASES;
SHOW TABLES;
DESC companies;
SELECT COUNT(*) FROM companies;
SELECT COUNT(*) FROM ownership;
SELECT COUNT(*) FROM ubo_details;
SELECT COUNT(*) FROM documents;
SELECT COUNT(*) FROM transactions;
SELECT COUNT(*) FROM sanctions_list;
SELECT * FROM companies LIMIT 5;
DESC ownership;
SELECT
    c.company_name,
    o.owner_name,
    o.ownership_percentage
FROM companies c
JOIN ownership o
    ON c.client_id = o.client_id;
SELECT
    c.company_name,
    o.owner_name,
    o.ownership_percentage
FROM companies c
JOIN ownership o
    ON c.client_id = o.client_id;
DESC ubo_details;
DESC transactions;
DESC documents;
DESC sanctions_list;
SELECT COUNT(*) AS companies FROM companies;
SELECT COUNT(*) AS ownership FROM ownership;
SELECT COUNT(*) AS ubo_details FROM ubo_details;
SELECT COUNT(*) AS documents FROM documents;
SELECT COUNT(*) AS transactions FROM transactions;
SELECT COUNT(*) AS sanctions_list FROM sanctions_list;
SELECT
    c.company_name,
    o.owner_name,
    o.ownership_percentage
FROM companies c
JOIN ownership o
ON c.client_id = o.client_id;
SELECT *
FROM companies c
JOIN ubo_details u
ON c.client_id = u.client_id;
SELECT *
FROM companies c
JOIN documents d
ON c.client_id = d.client_id;
SELECT *
FROM companies c
JOIN transactions t
ON c.client_id = t.client_id;
SELECT
    company_name,
    annual_revenue
FROM companies
ORDER BY annual_revenue DESC;
SELECT
    industry,
    COUNT(*) AS total_companies
FROM companies
GROUP BY industry;
DESC companies;
DESC transactions;
SELECT
    owner_name,
    ownership_percentage
FROM ownership
WHERE ownership_percentage > 25;
SELECT *
FROM transactions
WHERE txn_amount > 1000000;
SELECT *
FROM transactions
WHERE risk_flag = 'Yes';
SELECT
    country,
    COUNT(*) AS total_transactions,
    SUM(txn_amount) AS total_amount
FROM transactions
GROUP BY country;
SELECT
    c.company_name,
    SUM(t.txn_amount) AS total_transaction_amount
FROM companies c
JOIN transactions t
ON c.client_id = t.client_id
GROUP BY c.company_name
ORDER BY total_transaction_amount DESC;
SELECT
    company_name,
    annual_revenue
FROM companies
ORDER BY annual_revenue DESC;
SELECT
    industry,
    COUNT(*) AS total_companies
FROM companies
GROUP BY industry;
SELECT
    c.company_name,
    o.owner_name,
    o.owner_type,
    o.ownership_percentage
FROM companies c
JOIN ownership o
ON c.client_id = o.client_id;
SELECT
    c.company_name,
    o.owner_name,
    o.ownership_percentage
FROM companies c
JOIN ownership o
ON c.client_id = o.client_id
WHERE o.ownership_percentage > 25;
DESC ubo_details;
SELECT
    company_name,
    annual_revenue
FROM companies
ORDER BY annual_revenue DESC;
SELECT
    industry,
    COUNT(*) AS total_companies
FROM companies
GROUP BY industry;
SELECT
    c.company_name,
    o.owner_name,
    o.ownership_percentage
FROM companies c
JOIN ownership o
ON c.client_id = o.client_id
WHERE o.ownership_percentage > 25;
SELECT
    c.company_name,
    u.ubo_name,
    u.country,
    u.pep_status
FROM companies c
JOIN ubo_details u
ON c.client_id = u.client_id
WHERE u.pep_status = 'Yes';
SELECT
    c.company_name,
    t.txn_amount,
    t.currency,
    t.risk_flag
FROM companies c
JOIN transactions t
ON c.client_id = t.client_id
WHERE t.risk_flag = 'Yes';
SELECT
    c.company_name,
    SUM(t.txn_amount) AS total_transaction_value
FROM companies c
JOIN transactions t
ON c.client_id = t.client_id
GROUP BY c.company_name
ORDER BY total_transaction_value DESC;
SELECT
    c.company_name,
    d.document_name,
    d.expiry_date
FROM companies c
JOIN documents d
ON c.client_id = d.client_id
WHERE d.expiry_date < CURDATE();
SELECT
    c.company_name,
    d.document_name,
    d.status
FROM companies c
JOIN documents d
ON c.client_id = d.client_id
WHERE d.status <> 'Verified';
SELECT
    c.company_name,
    u.ubo_name,
    t.txn_amount
FROM companies c
JOIN ubo_details u
ON c.client_id = u.client_id
JOIN transactions t
ON c.client_id = t.client_id
WHERE u.pep_status = 'Yes'
AND t.risk_flag = 'Yes';
SELECT
    (SELECT COUNT(*) FROM companies) AS total_companies,
    (SELECT COUNT(*) FROM transactions WHERE risk_flag='Yes') AS risky_transactions,
    (SELECT COUNT(*) FROM ubo_details WHERE pep_status='Yes') AS pep_ubos,
    (SELECT COUNT(*) FROM sanctions_list WHERE sanction_status='Active') AS sanctioned_entities;

DESC documents;
DESC sanctions_list;