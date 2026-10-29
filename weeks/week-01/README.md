# Week 1 — SQL diagnostic and loan-portfolio foundations

**Phase:** Weeks 1–4, advanced SQL and database engineering. **Budget:** 20 hours. Start with Day 1 whenever you are ready; the days are session numbers, not fixed calendar dates.

**Business brief:** A credit manager wants to understand the March 2025 portfolio: balances by product, accounts with repayment delays, changes from previous observations, and March collections. Produce correct SQL and explain what the data can and cannot support.

By the end of the week, you should be able to explain table grain, aggregate a portfolio safely, use CTEs and window functions, detect basic data defects, and communicate one defensible finding.

## Your 20-hour schedule

| Session | Hours | Work | Evidence to save |
| --- | ---: | --- | --- |
| Day 1 | 2 | 20 min: open Colab and run setup. 75 min: attempt all eight diagnostic questions without solutions. 25 min: record scores, confidence, and gaps. | First-attempt notebook and diagnostic baseline |
| Day 2 | 3 | 45 min: study grain, joins, and aggregation. 90 min: revisit Q1–Q2 and Q7. 45 min: explain why joining multiple child tables inflates totals. | Revised SQL and one explanation of a failed approach |
| Day 3 | 3 | 45 min: study CTEs and metric definitions. 90 min: revisit Q4 and Q8. 45 min: document assumptions and inspect data checks. | Metric definition, quality checks, and data dictionary notes |
| Day 4 | 3 | 45 min: study ROW_NUMBER, LAG, partitions, and ordering. 90 min: revisit Q3, Q5, and Q6. 45 min: compare latest-available versus same-month reporting. | Window queries and explanation of a missing-month trap |
| Day 5 | 2 | 45 min: write a 150–200 word decision brief. 30 min: record a three-minute explanation. 45 min: listen back and revise. | Brief and self-review; recording may stay private |
| Day 6 | 5 | 90 min: finish and retest the notebook. 60 min: inspect EXPLAIN for Q2 and Q7. 60 min: rerun from a fresh runtime and save work to GitHub. 90 min: audit your resume and build a factual evidence inventory. | Reproducible notebook, two plan notes, and resume audit |
| Day 7 | 2 | 45 min: solve two selected questions again without references. 30 min: give a mock interview explanation. 30 min: compare one relevant job description with your evidence. 15 min: update the weekly review. | Independent retry, interview notes, skill gap, and next steps |
| **Total** | **20** | | |

Week 1 covers all four curriculum pillars: technical practice, interview preparation, communication, and career positioning. The full 20-problem/five-plan assessment belongs to the **four-week phase**, not this first week.

## Start now: the first 20 minutes

1. Open [`week-01-sql.ipynb`](week-01-sql.ipynb) through the Colab button in the root README.
2. Connect a Python 3 CPU runtime and run the install, data setup, integrity check, and answer-check setup cells in order.
3. Read the data dictionary. Say aloud: **one snapshot row represents one loan on one reporting date**.
4. Run the demonstration query. Then begin Q1 by replacing the empty string in `answers["Q1"]` with your SQL.

Python is only the notebook wrapper this week. Write your SQL between triple quotes; you do not need to build a Python application.

## Diagnostic rules

Use a 75-minute timer. Attempt what you can; leave unfamiliar questions blank. Run each question's check cell to see whether its result matches. Record your **first submission per question** before changing it, and keep that baseline separate from later retries. Do not read `solutions.sql` or the later lesson cells until you finish the baseline.

| Question | Skill | Points |
| --- | --- | ---: |
| Q1 | Correct snapshot grain and distinct customers | 10 |
| Q2 | Product aggregation | 10 |
| Q3 | Latest observation with ROW_NUMBER | 15 |
| Q4 | CTEs and a balance-weighted delinquency metric | 15 |
| Q5 | LAG and filtering after the window calculation | 15 |
| Q6 | Deterministic top two loans per product | 10 |
| Q7 | Pre-aggregation before joining payments | 15 |
| Q8 | Duplicate, orphan, missing, and invalid-value checks | 10 |
| **Total** | | **100** |

The automatic score checks results on this teaching dataset. Review the SQL and reasoning as well: hard-coded results or a query that happens to work here are not mastery. Use first-attempt results to choose where to spend practice time; a low baseline is useful information.

## Completion criteria

- [ ] Save a genuine first-attempt diagnostic result, including unanswered questions.
- [ ] Resolve all eight questions with feedback and explain why each query works.
- [ ] Independently retry two questions without looking at solutions.
- [ ] Explain the reporting date, grain, denominator, and missing-data limitation of a metric.
- [ ] Show why pre-aggregating payments prevents duplicate balances.
- [ ] Capture two EXPLAIN observations; distinguish estimated plans from measured performance.
- [ ] Run the notebook from a fresh runtime and save it to GitHub.
- [ ] Complete the decision brief, speaking practice, and resume audit.
- [ ] Fill in actual hours, evidence links, and Week 2 learning priorities.

Earning at least 80% of the available points on your selected independent retry questions is a suggested review target, not a validated certification threshold. If results improve only with the solutions open, revisit those concepts before advancing.

## Focused references

Use these after your diagnostic, only where you need help:

- [DuckDB SELECT syntax](https://duckdb.org/docs/stable/sql/query_syntax/select.html)
- [DuckDB WITH / CTEs](https://duckdb.org/docs/stable/sql/query_syntax/with.html)
- [DuckDB window functions](https://duckdb.org/docs/stable/sql/functions/window_functions.html)
- [DuckDB EXPLAIN](https://duckdb.org/docs/stable/guides/meta/explain.html)
- [PostgreSQL window-function tutorial](https://www.postgresql.org/docs/current/tutorial-window.html)
- [Oracle ROW_NUMBER](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/ROW_NUMBER.html)

Next week can extend this foundation to portfolio-at-risk definitions, vintages, roll rates, and more rigorous data-quality checks. Your Week 1 results should guide the pace.
