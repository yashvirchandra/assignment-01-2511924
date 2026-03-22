## Storage Systems

In my design, I have used three main storage systems to support the different goals of the hospital data platform.

First, I used an OLTP database (SQL) to store structured patient records coming from the EHR system. This database is optimized for fast read and write operations, which is important because doctors need real-time access to patient data. It supports the NLP query system, where doctors can ask questions in plain English and get immediate responses based on patient history. Since this system handles day-to-day operations, it must be highly reliable and efficient.

Second, I used a data lake to store raw and large-scale data, including historical treatment data and real-time ICU vitals. The data lake is useful because it can handle both structured and unstructured data, such as sensor data from monitoring devices. It is also highly scalable, making it suitable for storing continuously growing data. This storage plays a key role in machine learning tasks, especially for predicting patient readmission risk, and also supports real-time monitoring systems.

Third, I used a data warehouse for analytics and reporting. Data from billing systems and processed data from the data lake are stored here in a structured format. The data warehouse is optimized for complex queries and is used to generate monthly reports such as bed occupancy and department-wise costs. This helps hospital management make data-driven decisions.

--------------------------------------------

## OLTP vs OLAP Boundary

In this design, the OLTP system includes the PostgreSQL database connected to the EHR system. This system handles real-time transactions such as updating patient records and responding to doctor queries through the NLP query system. It is designed for speed and consistency, ensuring that doctors always get accurate and up-to-date information.

The OLAP system begins when data is moved from the OLTP database and other sources into the data lake and data warehouse using batch and streaming pipelines. The data lake stores raw data, including streaming ICU data and historical records, while the data warehouse stores cleaned and processed data for analysis.

All analytical operations such as machine learning models for readmission prediction and reporting dashboards are part of the OLAP layer. This separation ensures better performance, as transactional workloads do not interfere with analytical processing.

--------------------------------------------

## Trade-offs

One major trade-off in this design is between real-time processing and system complexity. Supporting real-time ICU data requires additional components like streaming pipelines and real-time monitoring systems. This increases the complexity of the architecture and also adds to the cost of maintaining the system.

To mitigate this, I used a hybrid approach. Only critical data, such as ICU vitals, is processed in real-time because it is time-sensitive and important for patient care. Other data, such as historical treatment records and reporting data, is processed in batch mode using ETL pipelines. This reduces the overall system complexity while still meeting the important requirements of the system.

Additionally, this approach improves resource utilization, as real-time systems are only used where necessary, while less critical workloads are handled more efficiently in batch processing.

--------------------------------------------
