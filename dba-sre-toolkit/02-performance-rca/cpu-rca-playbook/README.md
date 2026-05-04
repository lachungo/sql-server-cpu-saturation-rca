# SQL Server CPU RCA Playbook
### Diagnosing CPU Saturation in SQL Server Always On Environments

**Author:** Louis Achungo  
**Role:** Principal SQL Architect & Cloud DBA (Azure | AWS)

---

## Purpose

This playbook provides a repeatable, evidence-based framework for diagnosing SQL Server CPU saturation, especially in Always On Availability Group environments running on Azure VMs.

The goal is to avoid guesswork and prove whether high CPU is caused by query inefficiency, concurrency, scheduler pressure, or another subsystem.

---

## Scenario

A 4-node SQL Server Always On environment experienced sustained high CPU during reporting workloads. The investigation focused on proving the bottleneck rather than assuming query tuning alone would resolve the issue.

---

## RCA Flow

1. Confirm CPU pressure.
2. Check wait statistics.
3. Analyze runnable tasks per scheduler.
4. Rule out memory pressure.
5. Rule out TempDB contention.
6. Rule out I/O bottlenecks.
7. Correlate workload concurrency with CPU pressure.
8. Build capacity model.
9. Scale safely using a rolling Always On upgrade pattern.
10. Validate post-change stability.

---

## Key Diagnostic Signals

| Signal | Interpretation |
|---|---|
| High `SOS_SCHEDULER_YIELD` | Workers are yielding CPU and waiting for CPU time. |
| Runnable tasks consistently above 0 | Workers are queued for CPU. |
| High CPU + high runnable tasks | CPU scheduler pressure. |
| Normal memory, TempDB, and I/O | CPU is likely the primary bottleneck. |

---

## Included Scripts

| Script | Purpose |
|---|---|
| `01-wait-stats.sql` | Identify dominant wait types. |
| `02-scheduler-analysis.sql` | Review runnable tasks and worker pressure. |
| `03-cpu-utilization-ring-buffer.sql` | Review SQL and system CPU history. |
| `04-memory-pressure-check.sql` | Rule out memory grant pressure. |
| `05-tempdb-check.sql` | Review TempDB allocation and usage. |
| `06-io-latency-check.sql` | Review database file I/O latency. |
| `07-active-requests.sql` | Identify currently executing CPU-heavy requests. |

---

## Root Cause Pattern

```text
High CPU
  + SOS_SCHEDULER_YIELD dominance
  + Runnable tasks per scheduler increasing
  + No significant memory / TempDB / I/O pressure
  = CPU scheduler pressure under concurrency
```

---

## Outcome

A properly executed RCA should provide enough evidence to support one of the following actions:

- Query tuning
- Index tuning
- Workload isolation
- Reporting offload
- Compute scaling
- Rolling AG upgrade

In this case, the evidence supported compute scaling and a near-zero downtime rolling AG upgrade.
