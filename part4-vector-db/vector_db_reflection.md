## Vector DB Use Case
A traditional keyword-based search would not be sufficient for this system. Keyword search relies on exact word matching, which means it may fail when the wording in the contract is different from the user’s query. For instance, a lawyer might search for “termination clauses,” while the contract may use phrases like “ending the agreement” or “conditions for contract cancellation.” In such cases, a keyword-based system could miss relevant sections, making it unreliable for large and complex legal documents. Keyword search cannot understand context or synonyms, while vector search can.

In contrast, a vector database enables semantic search, which focuses on the meaning of the text rather than the exact words . It uses embeddings to convert both the contract content and the user’s query into numerical vectors that capture their underlying meaning. These vectors are then compared using similarity measures such as cosine similarity to find relevant matches.

In this system, the contract would be divided into smaller sections, and each section would be stored as an embedding in the vector database. When a lawyer asks a question, the system converts the query into an embedding and retrieves the most similar sections based on meaning.

Overall, the vector database improves accuracy and ensures better understanding of queries, and makes searching of long legal documents much more effective & efficient.
