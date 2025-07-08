# 🍕 Pizza Sales SQL Analysis

This is an end-to-end SQL project where I analyzed a pizza sales dataset using MySQL.  
I followed a guided walkthrough to structure the data, write SQL queries, and extract key business insights.

---

## 📂 Dataset Overview

The project uses four related CSV files which were converted into relational tables:

- `orders` – Order ID, date, and time of each order  
- `order_details` – Contains quantity and pizza ID for each item in each order  
- `pizzas` – Lists pizza names, sizes, prices, and associated type ID  
- `pizza_types` – Describes each pizza type (category and ingredients)

---

## 🧩 Schema Design

I created a relational schema by connecting the tables using foreign keys:

- `orders.order_id` → `order_details.order_id`  
- `order_details.pizza_id` → `pizzas.pizza_id`  
- `pizzas.pizza_type_id` → `pizza_types.pizza_type_id`

The diagram is available in `schema.png`.

---

## 🔍 Key Business Questions Answered

- What is the total revenue generated?
- What are the top-selling pizzas by quantity and revenue?
- Which pizza size is most popular?
- What are the most and least popular pizza categories?
- What are the peak order times during the day?
- What is each pizza’s contribution to total revenue?

---

## 🛠 Skills Practiced

- Importing and cleaning CSV data in MySQL  
- Writing SQL queries using:
  - `JOIN`, `GROUP BY`, `ORDER BY`, `HAVING`, `LIMIT`  
  - Aggregate functions (`SUM`, `COUNT`, `AVG`)  
  - Window functions (`RANK`, `PERCENT_RANK`)  
- Schema design and database normalization

---

## 📊 Project Outputs

- `Pizza_Sales_Analysis_HayaParveen.pdf` – Final project presentation with visuals and insights
- `queries.sql` – SQL queries used in the analysis
- `schema.png` – Entity-Relationship Diagram of the tables

---

## 💡 Project Goal

The main objective of this project was to simulate a real-world data analyst task by using SQL to explore sales data, understand customer behavior, and make data-driven business recommendations.

---

## 🙋‍♀️ About Me

I'm **Haya Parveen**, an aspiring Data Analyst currently building my portfolio by working on real-world datasets and improving my SQL, Power BI, and data storytelling skills.

---

## 🔗 Connect with Me

- 🔗 [LinkedIn](https://www.linkedin.com/in/hayaparveen)  
- 🔗 [GitHub Profile](https://github.com/Haya-parveen)

