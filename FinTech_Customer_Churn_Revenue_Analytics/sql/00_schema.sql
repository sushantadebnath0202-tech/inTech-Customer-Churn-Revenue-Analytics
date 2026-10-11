-- MySQL 8.0+ | All records are synthetic
CREATE DATABASE IF NOT EXISTS fintech_churn_analytics;
USE fintech_churn_analytics;
CREATE TABLE IF NOT EXISTS customers (
 customer_id INT PRIMARY KEY,signup_date DATE,plan VARCHAR(20),country VARCHAR(32),
 acquisition_channel VARCHAR(30),age_band VARCHAR(10)
);
CREATE TABLE IF NOT EXISTS monthly_metrics (
 customer_id INT NOT NULL,month_start DATE NOT NULL,is_active TINYINT NOT NULL,
 transaction_count INT,transaction_volume_usd DECIMAL(12,2),
 subscription_revenue_usd DECIMAL(12,2),interchange_revenue_usd DECIMAL(12,2),
 fx_fee_revenue_usd DECIMAL(12,2),total_revenue_usd DECIMAL(12,2),
 PRIMARY KEY(customer_id,month_start),FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
 INDEX idx_month(month_start)
);
CREATE TABLE IF NOT EXISTS support_tickets (
 ticket_id INT PRIMARY KEY,customer_id INT,created_date DATE,issue_type VARCHAR(40),
 status VARCHAR(12),resolution_hours INT,satisfaction_score INT,
 FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);
