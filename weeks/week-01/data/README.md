# Synthetic teaching data

These deterministic CSV fixtures were authored for this Week 1 SQL workbook. They do not represent real customers, employers, lending performance, or Kenyan market estimates. Amounts use KES; dates are fixed teaching dates in 2024–2025. No random seed or download is needed.

The notebook embeds these exact CSV contents so it can run independently in Colab. If you intentionally change the fixtures later, update the notebook copies and expected results together.

## Tables and grain

| Table | Rows | One row represents | Key |
| --- | ---: | --- | --- |
| `customers` | 7 | One customer | `customer_id` |
| `loans` | 9 | One loan account | `loan_id` |
| `snapshots` | 21 | One loan on one reporting date | `(loan_id, snapshot_date)` |
| `payments` | 11 | One payment transaction | `payment_id` |
| `staging_snapshots` | 6 | An unvalidated incoming snapshot record | Intended key `(loan_id, snapshot_date)`; deliberately violated |

`customers` has one-to-many relationships with `loans`. Each loan can have many snapshots and payments. Joining both child tables directly by loan ID can multiply rows and overstate totals.

## Column definitions

| Table | Columns |
| --- | --- |
| `customers` | `customer_id`: synthetic identifier; `county`: teaching location label; `segment`: customer category |
| `loans` | `loan_id`, `customer_id`: identifiers; `product`: Asset, Business, or Personal; `disbursement_date`: origination date; `original_principal`: amount initially lent in KES |
| `snapshots` | `loan_id`; `snapshot_date`: month-end date; `outstanding_balance`: remaining principal in KES; `dpd`: integer days past due |
| `payments` | `payment_id`, `loan_id`; `payment_date`: payment date; `payment_amount`: gross cash received in KES |
| `staging_snapshots` | Same fields as `snapshots`, with intentional duplicate, orphan, negative-value, and missing-value errors |

Date fields are converted to SQL `DATE` and amounts to `DECIMAL(18,2)` during notebook setup. Main-table DPD is an integer; staging DPD allows nulls for the quality exercise.

## Reporting conventions

- The March portfolio includes **all records dated 2025-03-31**, including a zero-balance account. Count loans and customers separately.
- The latest available view is different: L009's latest snapshot is January. Do not silently carry that balance into March totals or infer that a missing observation means a zero balance.
- For Q4, the **30+ DPD balance share (%)** is `100 × sum(outstanding_balance where dpd >= 30) / sum(outstanding_balance)`, calculated by product at the March reporting date. Use `NULLIF` for a zero denominator. This exercise convention includes exactly 30 DPD; confirm business policy before naming a real-world metric PAR30.
- For Q5, `LAG` means the previous **observed** snapshot for that loan, not a guaranteed previous calendar month. A new loan has no previous observation. Calculate the window over all observations before filtering the output to March.
- For Q6 only, eligible loans have a March balance greater than zero. Sort by balance descending, then loan ID ascending, and select exactly two per product when available. Products with one eligible loan return one row.
- For Q7, include payments dated on or after 2025-03-01 and before 2025-04-01. Aggregate payments to loan grain before joining the March snapshots. No payment means zero recorded cash receipts for that interval; L009's receipts are outside the selected March snapshot cohort.
- Payment amounts are gross cash and are not split into principal, interest, or fees. They cannot support a precise principal-balance reconciliation.

## Deliberate learning cases

L001 has two equal-value March payments; `SUM(DISTINCT payment_amount)` would discard a real transaction. L001 and L002 have tied March balances; ranking needs a declared tie policy. L005 has exactly 30 DPD. L006 has a March observation but no February observation, so its previous observed snapshot is January. L008 has no earlier snapshot and its first recorded payment is in April. L009 has only a January snapshot. Several loans have no March payments.

The staging table is quarantined from portfolio totals. Count duplicate **key groups**, not the number of rows belonging to those groups. Other requested quality checks count offending records. A record may have more than one defect; do not add issue counts and call the sum a count of unique bad records.

This tiny sample is for SQL reasoning. It cannot establish real lending risk, a causal business diagnosis, production-scale query performance, probability of default, or IFRS 9 expected credit loss.
