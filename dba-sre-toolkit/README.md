# DBA SRE Toolkit
### Enterprise SQL Server Reliability Engineering Platform

**Author:** Louis Achungo  
**Title:** Principal SQL Architect & Cloud DBA (Azure | AWS)  
**Portfolio:** https://sql-it-techsolutions.com/  
**LinkedIn:** https://www.linkedin.com/in/louis-achungo/  
**GitHub:** https://github.com/lachungo

---

## Overview

The **DBA SRE Toolkit** is an enterprise SQL Server reliability engineering repository built around real-world production patterns: observability, root-cause analysis, Always On operations, capacity engineering, and automation.

This is not a random script dump. It is a structured platform for diagnosing and operating SQL Server environments with an SRE mindset.

> **Measure → Correlate → Prove → Act**

---

## What This Toolkit Covers

| Area | Purpose |
|---|---|
| Observability | Capture SQL Server health, waits, long-running queries, blocking, and workload signals. |
| Performance RCA | Diagnose CPU, memory, TempDB, and I/O issues using repeatable playbooks. |
| Automation Frameworks | Package operational processes such as AG refreshes, alerting, and VLDB maintenance. |
| Always On Platform | Validate AG health, replica synchronization, failover readiness, and latency signals. |
| Capacity Engineering | Translate workload evidence into scaling and infrastructure decisions. |
| Dashboards | Provide executive-ready reports and operational health summaries. |

---

## Featured Playbook: CPU RCA

The first production-ready module is the **SQL Server CPU RCA Playbook**, focused on diagnosing CPU saturation in SQL Server Always On environments hosted on Azure VMs.

Key signals:

- `SOS_SCHEDULER_YIELD` dominance
- Runnable tasks per scheduler
- Sustained CPU pressure under concurrency
- No significant memory, TempDB, or I/O bottlenecks

Outcome pattern:

- Identify scheduler pressure
- Build a capacity model
- Scale compute safely
- Validate after the change

See: `02-performance-rca/cpu-rca-playbook/README.md`

---

## Repository Structure

```text
dba-sre-toolkit/
├── 01-observability/
├── 02-performance-rca/
│   └── cpu-rca-playbook/
├── 03-automation-frameworks/
├── 04-alwayson-platform/
├── 05-capacity-engineering/
├── 06-dashboards/
└── diagrams/
```

---

## Disclaimer

These scripts and examples are provided as a professional toolkit and learning resource. Review and test in a non-production environment before use. Adjust thresholds, mail profiles, database names, file paths, and security settings for your environment.
