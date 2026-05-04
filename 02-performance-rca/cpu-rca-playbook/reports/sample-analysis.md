# Sample CPU RCA Analysis

## Executive Summary

The SQL Server environment showed sustained CPU saturation during concurrent reporting workloads. The primary evidence was dominant `SOS_SCHEDULER_YIELD` waits combined with increasing runnable tasks per scheduler.

## Evidence

- CPU utilization sustained above 90% during peak reporting.
- `SOS_SCHEDULER_YIELD` was the dominant wait category.
- Runnable tasks per scheduler were consistently elevated.
- Memory grants pending were not significant.
- TempDB usage and allocation metrics did not indicate contention.
- I/O latency did not explain the observed query delays.

## Root Cause

CPU scheduler pressure under concurrent workloads.

## Recommendation

Scale compute capacity and validate via a rolling Always On upgrade approach to minimize downtime.

## Post-Change Validation

- CPU utilization stabilized.
- Runnable task queues normalized.
- Reporting workloads improved.
- User experience stabilized.
