---

### Bronze Layer

---

#### Analysing
- Interview Source System Experts	

#### Coding
- Data Ingestion

#### Validating
- Data Completeness & Schema checks

#### Docs & Versions
- Data Documenting & Versioning in GIT

---

### Business Context & Ownership
- Who is responsible for the data? Which IT Department?
- What Business Process it supports? What systems rely on this data source?
- System & Data Documentation
- Data Model & Data Catalog

### Architecture & Technology Stack
- How and where the data is stored? Cloud? On premise? Hybrid?
- Waht are the integration capabilities? API, Kafka, File Extract, Direct DB

### Extract & Load
- Incremental vs Full Load?
- Data Scope & Historical Needs?
- What is the expected size of the extracts? Any limitations? Network bandwidth & latency?
- Are there any data volume limitations?
- How to avoid impacting the source system's performance?
- Authentication & Authorization. tokens, SSH keys, VPN, IP whitelisting, firewalls, IDS/IPS, DNS settings)

---
### Bronze Rules
- All names must start with the source system name, and table names must match their original names without renaming
- **`<sourcesystem>_<entity>`**
  - `<sourcesystem>`: Name of the source system (e.g. crm, erp).
  - `<entity>`: Exact table name from the source system.
  - Example: `crm_customer_info` -> Customer Information from CRM system
