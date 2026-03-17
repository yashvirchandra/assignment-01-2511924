#Part 1 — Normalization Analysis

##Anomaly Analysis

###Insert Anomaly
Suppose the company hires a fourth sales representative who hasn't done any deals yet. In orders_flat.csv, there is no way to store the new person's details because every row requires an order to exist. The sales rep's ID, name, email, and office address are all tied to order rows — so a rep with no or zero sales simply has no place in the table. We would have to insert a fake order just to record the new persosn's details, which leads to corrupts the data. Affected columns: sales_rep_id, sales_rep_name, sales_rep_email, office_address.

###Update Anomaly
Customer C008 (Kavya Rao, kavya@gmail.com) appears across 28 times on different order rows in the file, including ORD1131, ORD1025, ORD1021, ORD1180, and ORD1047 among many others. Her email address kavya@gmail.com is written 28 times, once for every order she have placed. If Kavya ask to update her email address, a developer must correctly update all 28 rows at the exact same time. If even one row gets missed, the database now has two different email addresses for the same customer with no way to tell which one is current email address. This kind of mistake is very hard to detect and can cause real problems like sending confirmations to the wrong email or failed account logins. Affected columns: customer_name, customer_email, customer_city Affected rows: ORD1131, ORD1025, ORD1021, ORD1180, ORD1047
