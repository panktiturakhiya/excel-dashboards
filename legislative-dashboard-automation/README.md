# 📊 Legislative Dashboard Automation (Excel + Power Query)

> Built for a nonprofit advocacy organization to improve accessibility of legislative insights using low-cost tools  
> 🔗 [View Impact Story on Catchafire](https://catchafire.org/impact/match/4113159/promo--excel-dashboard-creation/)

---

## 🚀 Overview
This project delivers a fully automated Excel-based dashboard to track and analyze legislative data.  
Designed for a resource-constrained environment, it replaces manual tracking with a scalable, repeatable reporting workflow using Power Query.

---

## ⚠️ Problem
- Manual tracking across categories, subjects, positions, and years  
- Inconsistent reporting logic  
- High dependency on manual effort  
- Difficult for non-technical users to maintain  

---

## 💡 Solution
- Built an automated ETL pipeline using Power Query  
- Transformed raw exports into structured, analysis-ready data  
- Enabled dynamic filtering and consistent KPI tracking  
- Designed for **self-service reporting with minimal manual effort**  

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|--------|
| Excel | Dashboard & reporting layer |
| Power Query | Data ingestion & transformation |
| Pivot Tables | Aggregation & analysis |
| Data Modeling | Structured reporting logic |

---

## ⭐ Key Features
- Automated data ingestion from exported files  
- Multi-value column normalization (Lists, Subjects, Positions)  
- Dynamic filtering across categories, topics, and years  
- KPI tracking across multiple dimensions  
- Designed for non-technical users  

---

## 🔄 Data Transformation Approach
- Split multi-select columns into multiple rows  
- Standardized categorical values  
- Handled null/missing values (`Uncategorized`)  
- Created derived analytical fields  
- Enabled multi-dimensional analysis  

---

## 🔁 Workflow
1. Raw legislative data is exported  
2. Power Query performs data ingestion and transformation (ETL)  
3. Data is cleaned and structured for analysis  
4. Pivot tables are used for aggregation  
5. Interactive dashboard enables reporting and insights  

---

## 📉 Constraints
- No advanced BI tools (Power BI/Tableau not used)  
- Built entirely in Excel for accessibility  
- Optimized for maintainability over complexity  

---

## 📈 Impact
- ⏱️ Reduced manual reporting effort significantly  
- 📊 Improved consistency and reliability  
- ⚡ Faster insight generation  
- 🧠 Enabled data-driven advocacy decisions  
- 💰 Delivered a low-cost analytics solution  

---

## 🔒 Data Privacy
All data, categories, and examples have been anonymized to ensure confidentiality.

---

## 📁 Repository Structure
excel-dashboards/
└── legislative-dashboard-automation/
├── README.md
├── queries/
│ └── combined_legislative_data.m

## Notes
This repository documents the technical workflow and dashboard design approach.  
All data, categories, and examples have been anonymized or generalized to ensure privacy and confidentiality.
