# Multi-Sector Career Optimisation

A learning portfolio following the supplied **52-week enterprise mastery curriculum**, starting at section 4. Learn in Google Colab and keep evidence, reflections, and progress in GitHub.

## Start Week 1

[![Open Week 1 in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/dianawambugha/Multi-Sector-Career-Optimisation/blob/main/weeks/week-01/week-01-sql.ipynb)

1. Read the [Week 1 plan](weeks/week-01/README.md).
2. Open the notebook above in Colab. Use a **Python 3 CPU runtime**; no GPU or external database is needed.
3. Run the setup cells, then attempt the eight SQL diagnostic questions before reading the solutions.
4. Record your first attempt, retry score, time, and reflections in the [progress log](progress/weekly-log.md).
5. In Colab, choose **File → Save a copy in GitHub**, select this repository and branch `main`, and use `weeks/week-01/week-01-sql.ipynb` as the file path. Use a descriptive commit message, such as `week 01: attempt Q1 and explain table grain`.
6. Edit `progress/weekly-log.md` separately on GitHub and commit the update. Saving a notebook does **not** automatically update the progress log.

If GitHub saving is unavailable in Colab, save a copy in Drive, download the `.ipynb`, and upload it to the same repository path on GitHub. A private repository may require you to grant Colab access through its GitHub sign-in flow.

## What you are building

Weeks 1–4 focus on advanced SQL and database engineering. Week 1 establishes a small, reproducible loan-portfolio database and a diagnostic baseline. Later weeks extend the analysis, data quality, and database engineering work.

The curriculum's first-month checklist also mentions Python and Power BI in Week 3. This learning sequence follows section 4's four-week SQL phase; dashboard development can follow after the SQL foundation.

| Material | Purpose |
| --- | --- |
| [Week 1 notebook](weeks/week-01/week-01-sql.ipynb) | Guided setup, diagnostic exercises, feedback, and short lessons |
| [Week 1 plan](weeks/week-01/README.md) | Seven sessions totaling 20 hours |
| [Data dictionary](weeks/week-01/data/README.md) | Table grain, metric definitions, provenance, and limitations |
| [Progress log](progress/weekly-log.md) | Your learning evidence and actual hours |
| [Career and communication worksheet](weeks/week-01/career-and-communication.md) | Resume audit, role positioning, and a short briefing |
| [Reference SQL](weeks/week-01/solutions.sql) | Worked answers to review after the diagnostic |

All data is **synthetic**, denominated in KES, and unrelated to actual customers or employers. The notebook embeds the small CSV fixtures so it runs without fetching private files or mounting Drive. Re-running setup recreates an in-memory database; save your notebook edits before disconnecting.

DuckDB is a practical Colab learning engine. Its query planner, indexes, storage, and some SQL syntax differ from Oracle and PostgreSQL; engine-specific performance work will need those actual databases later.

## Progress policy

Prepared materials and automated answer checks are not evidence that you have completed a lesson. All initial learning tasks remain unchecked. Record a completion only after you do the work, can explain it, and save a link or commit identifying the evidence.
