-- Reference answers: attempt the diagnostic before reading these.
-- DuckDB 1.4.3; all amounts are KES and data is synthetic.

-- Q1
SELECT COUNT(*) AS loan_count,
       COUNT(DISTINCT l.customer_id) AS customer_count,
       SUM(s.outstanding_balance) AS total_outstanding
FROM snapshots s
JOIN loans l ON l.loan_id = s.loan_id
WHERE s.snapshot_date = DATE '2025-03-31';

-- Q2
SELECT l.product,
       COUNT(*) AS loan_count,
       SUM(s.outstanding_balance) AS total_outstanding,
       ROUND(AVG(s.outstanding_balance), 2) AS average_outstanding
FROM snapshots s
JOIN loans l ON l.loan_id = s.loan_id
WHERE s.snapshot_date = DATE '2025-03-31'
GROUP BY l.product
ORDER BY l.product;

-- Q3
WITH ranked AS (
    SELECT loan_id, snapshot_date, outstanding_balance,
           ROW_NUMBER() OVER (
               PARTITION BY loan_id ORDER BY snapshot_date DESC
           ) AS observation_rank
    FROM snapshots
)
SELECT loan_id, snapshot_date, outstanding_balance
FROM ranked
WHERE observation_rank = 1
ORDER BY loan_id;

-- Q4
WITH product_balances AS (
    SELECT l.product,
           SUM(s.outstanding_balance) AS total_outstanding,
           SUM(CASE WHEN s.dpd >= 30 THEN s.outstanding_balance ELSE 0 END)
               AS overdue_30plus_balance
    FROM snapshots s
    JOIN loans l ON l.loan_id = s.loan_id
    WHERE s.snapshot_date = DATE '2025-03-31'
    GROUP BY l.product
)
SELECT product, total_outstanding, overdue_30plus_balance,
       ROUND(100.0 * overdue_30plus_balance / NULLIF(total_outstanding, 0), 2)
           AS overdue_30plus_pct
FROM product_balances
ORDER BY product;

-- Q5
WITH observations AS (
    SELECT loan_id, snapshot_date, outstanding_balance,
           LAG(snapshot_date) OVER (
               PARTITION BY loan_id ORDER BY snapshot_date
           ) AS previous_snapshot_date,
           LAG(outstanding_balance) OVER (
               PARTITION BY loan_id ORDER BY snapshot_date
           ) AS previous_balance
    FROM snapshots
)
SELECT loan_id, snapshot_date, previous_snapshot_date,
       outstanding_balance, previous_balance,
       outstanding_balance - previous_balance AS balance_change
FROM observations
WHERE snapshot_date = DATE '2025-03-31'
ORDER BY loan_id;

-- Q6
WITH ranked AS (
    SELECT l.product, s.loan_id, s.outstanding_balance,
           ROW_NUMBER() OVER (
               PARTITION BY l.product
               ORDER BY s.outstanding_balance DESC, s.loan_id ASC
           ) AS position
    FROM snapshots s
    JOIN loans l ON l.loan_id = s.loan_id
    WHERE s.snapshot_date = DATE '2025-03-31'
      AND s.outstanding_balance > 0
)
SELECT product, loan_id, outstanding_balance, position
FROM ranked
WHERE position <= 2
ORDER BY product, position;

-- Q7
WITH march_payments AS (
    SELECT loan_id, SUM(payment_amount) AS march_payments
    FROM payments
    WHERE payment_date >= DATE '2025-03-01'
      AND payment_date < DATE '2025-04-01'
    GROUP BY loan_id
)
SELECT s.loan_id, s.outstanding_balance,
       COALESCE(p.march_payments, 0) AS march_payments
FROM snapshots s
LEFT JOIN march_payments p ON p.loan_id = s.loan_id
WHERE s.snapshot_date = DATE '2025-03-31'
ORDER BY s.loan_id;

-- Q8
SELECT 'duplicate_key_groups' AS issue, COUNT(*) AS issue_count
FROM (
    SELECT loan_id, snapshot_date
    FROM staging_snapshots
    GROUP BY loan_id, snapshot_date
    HAVING COUNT(*) > 1
) duplicates
UNION ALL
SELECT 'orphan_loan_rows', COUNT(*)
FROM staging_snapshots s
LEFT JOIN loans l ON l.loan_id = s.loan_id
WHERE l.loan_id IS NULL
UNION ALL
SELECT 'negative_balance_rows', COUNT(*)
FROM staging_snapshots
WHERE outstanding_balance < 0
UNION ALL
SELECT 'missing_dpd_rows', COUNT(*)
FROM staging_snapshots
WHERE dpd IS NULL
UNION ALL
SELECT 'negative_dpd_rows', COUNT(*)
FROM staging_snapshots
WHERE dpd < 0
ORDER BY issue;
