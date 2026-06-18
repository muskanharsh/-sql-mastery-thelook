# 8-Week SQL Mastery Plan — Targeting 66degrees / Big-4-style Data Roles
**Time commitment:** 1-2 hrs/day · **Tool:** BigQuery (free tier) · **Dataset:** TheLook Ecommerce (real public dataset, already in BigQuery)

---

## Why this dataset
TheLook is a real relational e-commerce dataset (not toy data) already loaded in BigQuery's public datasets — customers, orders, order_items, products, inventory, distribution centers, web events. It's exactly the shape of data 66degrees-style consulting work involves: structured, multi-table, large enough to make partitioning/clustering actually matter.

## One-time setup (do today, ~15 min)
1. Go to console.cloud.google.com/bigquery
2. Create a free project (no credit card needed for the free tier)
3. In the Explorer panel, click **+ Add data → Star a project by name**
4. Type: `bigquery-public-data` and star it
5. Navigate to `bigquery-public-data → thelook_ecommerce` — you'll see tables: `users`, `orders`, `order_items`, `products`, `inventory_items`, `distribution_centers`, `events`
6. Run this to confirm access:
```sql
SELECT COUNT(*) FROM `bigquery-public-data.thelook_ecommerce.orders`;
```

---

## The daily loop (every single day, no exceptions)
1. **Read** the day's concept (15-20 min) — use the linked resource
2. **Write 3-5 queries** against TheLook applying that concept (40-60 min)
3. **Commit** to GitHub same day — file name + 2-line note on what you learned (10 min)

This is the "implement while learning" loop — you never have a pure reading day.

---

## WEEK 1 — SQL Fundamentals Refresher (you know some of this — go fast)
**Goal:** rock-solid SELECT, WHERE, JOIN, basic aggregation on real data.

| Day | Concept | Implement on TheLook |
|---|---|---|
| 1 | SELECT, WHERE, ORDER BY, LIMIT | Find top 10 most expensive products; users from a specific state |
| 2 | INNER JOIN, LEFT JOIN | Join orders + users; find orders with no matching order_items (data quality check) |
| 3 | GROUP BY, COUNT, SUM, AVG | Total revenue by product category; average order value by user state |
| 4 | HAVING vs WHERE | Categories with avg price > $50; states with more than 100 users |
| 5 | Multiple JOINs (3+ tables) | orders + order_items + products: total revenue per category, by month |
| 6 | DISTINCT, NULL handling, CASE WHEN | Bucket users into age groups using CASE; handle NULL shipping dates |
| 7 | **Review + GitHub commit `week1_fundamentals.sql`** | Re-run hardest 2 queries from memory, no notes |

---

## WEEK 2 — Window Functions (this is the #1 thing interviewers probe)
| Day | Concept | Implement on TheLook |
|---|---|---|
| 8 | ROW_NUMBER, RANK, DENSE_RANK | Rank products by revenue within each category |
| 9 | PARTITION BY | Top 3 best-selling products per category (PARTITION BY category) |
| 10 | LAG, LEAD | Month-over-month revenue growth |
| 11 | Running totals (SUM OVER) | Cumulative revenue per day, per user |
| 12 | FIRST_VALUE, LAST_VALUE, NTILE | First product each user bought; split users into spend quartiles (NTILE(4)) |
| 13 | Combine: window + filter (QUALIFY in BigQuery) | Use `QUALIFY ROW_NUMBER() OVER (...) = 1` to get each user's most recent order |
| 14 | **Review + commit `week2_window_functions.sql`** | Solve 2 new problems without looking at examples |

---

## WEEK 3 — CTEs, Subqueries, Set Operations
| Day | Concept | Implement on TheLook |
|---|---|---|
| 15 | Basic CTEs (WITH clause) | Rewrite a nested subquery from Week 1 as a CTE — compare readability |
| 16 | Multiple/chained CTEs | Build a 3-step CTE: filter users → join orders → aggregate by cohort month |
| 17 | Correlated subqueries | Users who spent above their state's average |
| 18 | EXISTS / NOT EXISTS | Products that have never been ordered |
| 19 | UNION, INTERSECT, EXCEPT | Combine "high spenders" and "frequent buyers" lists, dedupe |
| 20 | Recursive CTEs (concept + simple example) | Build a date-spine CTE (generate a row per day in a date range) — very common interview ask |
| 21 | **Review + commit `week3_ctes_subqueries.sql`** | |

---

## WEEK 4 — Data Modeling & Schema Design (the "from scratch" part)
| Day | Concept | Implement |
|---|---|---|
| 22 | Star schema theory: fact vs dimension | Diagram TheLook's actual schema — which tables are fact, which are dimension? Write this in your README |
| 23 | Normalization basics (1NF/2NF/3NF) | Identify any denormalization in TheLook's `order_items` table and explain why it's there |
| 24 | Design your OWN schema from scratch | Design a schema for a subscription-box business (not e-commerce) — fact_subscriptions, dim_customers, dim_plans. Write CREATE TABLE statements |
| 25 | Slowly Changing Dimensions (SCD Type 1 vs 2) | Explain + write SQL showing how you'd track a user's address change over time (SCD Type 2 pattern) |
| 26 | Indexes — concept (BigQuery doesn't use traditional indexes, but know this for Postgres-based roles) | Read about BigQuery's alternative (partitioning/clustering) vs Postgres B-tree indexes — write a comparison note |
| 27 | Build the subscription-box schema fully in BigQuery, load fake data (Python Faker or manual INSERTs) | |
| 28 | **Review + commit `week4_schema_design/`** (full mini-project folder) | |

---

## WEEK 5 — Partitioning & Clustering (BigQuery-specific, directly relevant to 66degrees)
| Day | Concept | Implement |
|---|---|---|
| 29 | Partitioning theory (range/time-based) | Read BigQuery docs on partitioned tables |
| 30 | Create a partitioned copy of `orders` (partition by `created_at` month) | Run the same query on partitioned vs unpartitioned — compare bytes scanned (shown in BigQuery UI) |
| 31 | Clustering theory | Read BigQuery docs on clustered tables |
| 32 | Add clustering by `user_id` or `status` to your partitioned table | Compare bytes scanned again with a filtered query |
| 33 | Partition pruning — write 3 queries that DO benefit and 1 that does NOT (and explain why) | This shows real understanding, not memorization |
| 34 | Cost optimization mindset | Estimate query cost before running (BigQuery shows this) — practice writing cost-efficient queries (avoid `SELECT *`, filter early) |
| 35 | **Review + commit `week5_partitioning_clustering.sql` + README explaining bytes-scanned comparisons** | |

---

## WEEK 6 — Advanced Patterns & Real Interview Problems
| Day | Concept | Implement |
|---|---|---|
| 36 | Pivoting data (CASE WHEN + aggregation, or PIVOT) | Monthly revenue as columns (Jan, Feb, Mar...) instead of rows |
| 37 | Cohort analysis | User signup cohort → retention by month (classic SaaS/e-commerce interview question) |
| 38 | Funnel analysis | Using `events` table: view → add to cart → purchase conversion rates |
| 39 | Deduplication patterns | Find and remove duplicate rows using ROW_NUMBER() + QUALIFY |
| 40 | Gaps and islands problem | Find consecutive days a user was active (classic SQL interview pattern) |
| 41 | Self-joins | Find users who share the same address (potential fraud signal) |
| 42 | **Review + commit `week6_advanced_patterns.sql`** | |

---

## WEEK 7 — Mock Assignments (simulate the actual interview/assignment format)
Treat each day as a timed take-home assignment (90 min, no solutions to peek at until done).

| Day | Mock Assignment |
|---|---|
| 43 | "Build a report showing top 5 categories by revenue per quarter, with MoM growth" |
| 44 | "Identify users at risk of churn (no order in 60+ days) and their lifetime value" |
| 45 | "Design and implement a partitioned, clustered fact table for order_items optimized for category-level reporting" |
| 46 | "Write a query showing each product's rank within its category AND its rank overall — single query" |
| 47 | "Explain (in writing, 1 page) how you'd optimize a slow query scanning 500GB on an unpartitioned table" |
| 48 | Pick 5 SQL questions from LeetCode "Database" hard section, solve cold | |
| 49 | **Review entire week, commit `week7_mock_assignments/`** | |

---

## WEEK 8 — Portfolio Polish + Applying
| Day | Task |
|---|---|
| 50-51 | Finalize GitHub repo structure (see below), write a strong root README |
| 52 | Polish your resume: add "TheLook E-commerce Analytics" project with specific metrics (e.g., "optimized query reducing bytes scanned by X%") |
| 53 | Record a 3-5 min Loom/screen-recording walkthrough of your partitioning/clustering comparison — link it in README (huge differentiator) |
| 54-56 | Start applying to 66degrees + similar GCP consulting partners (Searce, LTIMindtree GCP practice, Quantiphi, Onix) using this project as your talking point in interviews |

---

## GitHub repo structure (build this as you go, not at the end)
```
sql-mastery-thelook/
├── README.md                          (overview, schema diagram, key learnings)
├── week1_fundamentals.sql
├── week2_window_functions.sql
├── week3_ctes_subqueries.sql
├── week4_schema_design/
│   ├── schema_design_doc.md
│   └── create_tables.sql
├── week5_partitioning_clustering.sql
├── week5_bytes_scanned_comparison.md  (screenshots + numbers)
├── week6_advanced_patterns.sql
├── week7_mock_assignments/
│   ├── assignment1_revenue_report.sql
│   ├── assignment2_churn_analysis.sql
│   └── ...
```

## How to keep this from "flowing out of mind"
- Every Sunday (day 7, 14, 21...): re-solve 2 problems from 2 weeks ago WITHOUT looking — this is spaced repetition and is what actually makes it stick
- Keep a running `notes.md` of every error message you hit and how you fixed it — debugging memory is what interviewers actually test
- Don't move to the next week until you can explain (out loud, to yourself) why each query works — not just that it runs

## Companies to target alongside 66degrees (same GCP-consulting space)
Quantiphi, Searce, Onix, SADA, Datatonic, LTIMindtree (GCP practice), Accenture (Google Cloud practice) — all hire similar Associate Data Engineer / Data Analyst Intern profiles and value the exact same partitioning/clustering/schema-design skills.
