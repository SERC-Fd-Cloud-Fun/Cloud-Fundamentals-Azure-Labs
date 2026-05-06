# Lab 6 - Azure Monitor (Create and Monitor Resources)

In this lab, you will create Azure resources and then monitor them by using Azure Monitor.

## Learning Objectives

By the end of this lab, you should be able to:

1. Create core Azure resources for a monitoring scenario.
2. Use Azure Monitor to view metrics and logs.
3. Create and review VM alert rules.
4. Explore monitoring for VNets, Blob storage, and Load Balancers.
5. Explain why monitoring is important for cloud operations.

---

## Lab Scope

You will create and monitor the following resources:

1. Virtual Machine (VM)
2. Virtual Network (VNet)
3. Storage Account (Blob)
4. Load Balancer

Use low-cost settings and only create resources in your assigned subscription and resource group.

---

## Before You Start

1. Sign in to the Azure portal: https://portal.azure.com
2. Confirm your assigned subscription with your tutor.
3. Choose a region close to your location.
4. Use this naming pattern (replace `xx` with your initials or student ID):
   - Resource group: `rg-monitoring-xx`
   - VNet: `vnet-monitoring-xx`
   - VM: `vm-monitoring-xx`
   - Storage account: `stmonitorxx` (must be globally unique, lowercase, no hyphens)
   - Load balancer: `lb-monitoring-xx`

---

## Task 1 - Create a Resource Group

1. In Azure portal, search for `Resource groups`.
2. Select `+ Create`.
3. Set:
   - Subscription: your assigned subscription
   - Resource group: `rg-monitoring-xx`
   - Region: your chosen region
4. Select `Review + create`, then `Create`.

---

## Task 2 - Create a Virtual Network

1. Search for `Virtual networks`.
2. Select `+ Create`.
3. Configure:
   - Resource group: `rg-monitoring-xx`
   - Name: `vnet-monitoring-xx`
   - Region: same as resource group
4. In `IP addresses`, keep default IPv4 range.
5. Keep one default subnet (or create `subnet-default`).
6. Select `Review + create`, then `Create`.

---

## Task 3 - Create a Virtual Machine

1. Search for `Virtual machines`.
2. Select `+ Create` > `Azure virtual machine`.
3. In `Basics`, configure:
   - Resource group: `rg-monitoring-xx`
   - Virtual machine name: `vm-monitoring-xx`
   - Region: same region
   - Availability options: `No infrastructure redundancy required`
   - Image: `Ubuntu Server 22.04 LTS` (or tutor-approved image)
   - Size: choose a small size (for example `Standard_B1s`)
   - Authentication type: `Password` or `SSH public key`
4. In `Networking`, ensure:
   - Virtual network: `vnet-monitoring-xx`
   - Public inbound ports: `None` (recommended for this lab)
5. Keep remaining settings at defaults unless instructed.
6. Select `Review + create`, then `Create`.

Note: You do not need to log in to the VM for this lab.

---

## Task 4 - Create a Storage Account for Blob Monitoring

1. Search for `Storage accounts`.
2. Select `+ Create`.
3. Configure:
   - Resource group: `rg-monitoring-xx`
   - Storage account name: `stmonitorxx`
   - Region: same region
   - Primary service: `Azure Blob Storage or Azure Data Lake Storage Gen2`
   - Performance: `Standard`
   - Redundancy: `LRS`
4. Select `Review + create`, then `Create`.

### Create a Blob Container

1. Open your new storage account.
2. Go to `Data storage` > `Containers`.
3. Select `+ Container`.
4. Name it `labdata`.
5. Set public access level to `Private (no anonymous access)`.
6. Select `Create`.

---

## Task 5 - Create a Load Balancer

1. Search for `Load balancers`.
2. Select `+ Create`.
3. Configure:
   - Resource group: `rg-monitoring-xx`
   - Name: `lb-monitoring-xx`
   - Region: same region
   - Type: `Public`
   - SKU: `Standard`
4. Create a new public IP with a clear name (for example `pip-lb-monitoring-xx`).
5. Select `Review + create`, then `Create`.

Note: A backend pool is not required for this monitoring lab.

---

## Task 6 - Open Azure Monitor

1. Search for `Monitor` in the Azure portal.
2. Open `Monitor`.
3. In the left menu, locate:
   - Metrics
   - Alerts
   - Activity log
   - Logs
   - Workbooks

---

## Task 7 - VM Monitoring and Alerts

### 7A. Open VM Monitoring

1. Go to `Resource groups` > `rg-monitoring-xx`.
2. Open `vm-monitoring-xx`.
3. In the left menu, open `Monitoring` > `Alerts`.

### 7B. Configure Recommended VM Alerts

1. Select one of these options if shown:
   - `View + set up`
   - `Set up recommended alerts`
   - `Recommended alerts`
2. Review suggested rules (CPU, memory, disk, availability, networking).
3. Expand at least two rules and inspect:
   - Metric
   - Threshold
   - Evaluation period
   - Severity
4. Keep sensible thresholds (example: CPU > 80%).

### 7C. Configure an Action Group (Email Optional)

1. In alert setup, find the `Action group` section.
2. Select an existing action group, or create one:
   - Name: `ag-monitoring-xx`
   - Notification type: `Email/SMS message/Push/Voice`
   - Email: use your student email only if your tutor allows it
3. Save the action group.

### 7D. Create Alert Rules

1. Choose at least two VM alerts to create.
2. Confirm severity and threshold values.
3. Select `Save` or `Create`.
4. Return to `Monitoring` > `Alerts` > `Alert rules` and verify rules exist.

---

## Task 8 - VNet Monitoring

1. Go to `Resource groups` > `rg-monitoring-xx` > `vnet-monitoring-xx`.
2. Open `Monitoring` > `Metrics`.
3. Select a metric namespace and inspect available metrics.
4. Open `Monitoring` > `Activity log`.
5. Filter activity log to the last 24 hours.
6. Identify at least one operation (for example create/update action).

---

## Task 9 - Blob Storage Monitoring

1. Go to `Resource groups` > `rg-monitoring-xx` > `stmonitorxx`.
2. Open `Monitoring` > `Metrics`.
3. Set scope to your storage account.
4. Select Blob-relevant metrics, such as:
   - Transactions
   - Ingress
   - Egress
   - Availability
   - Success E2E Latency
5. Change the chart time range (for example Last 1 hour, Last 24 hours).

Optional: Upload a small text file to the `labdata` container, then refresh metrics after a few minutes.

---

## Task 10 - Load Balancer Monitoring

1. Go to `Resource groups` > `rg-monitoring-xx` > `lb-monitoring-xx`.
2. Open `Monitoring` > `Metrics`.
3. Inspect available metrics, such as:
   - Data path availability
   - Health probe status
   - Byte count
   - Packet count
4. If `Insights` is available, open it and review summary information.

---

## Task 11 - Complete a Monitoring Summary

Fill in this table in your lab notes.

| Resource | Monitoring feature used | Example metric or alert | Why it matters |
| --- | --- | --- | --- |
| Virtual Machine | Alerts |  |  |
| Virtual Network | Metrics or Activity log |  |  |
| Blob Storage | Metrics |  |  |
| Load Balancer | Metrics or Insights |  |  |

---

## Knowledge Check Questions

1. What is the difference between a metric and an alert?
2. Why are thresholds important when creating alerts?
3. Why would a cloud administrator monitor both compute and networking resources?
4. What does ingress and egress mean for Blob storage?
5. Why is load balancer health monitoring important for application availability?

---

## Cost and Cleanup Guidance

To reduce cost after the lab:

1. Stop (deallocate) the VM when not in use.
2. If your tutor allows cleanup, delete the resource group `rg-monitoring-xx` after completing the lab.

---

## Key Terms

| Term | Meaning |
| --- | --- |
| Azure Monitor | Azure service for collecting and analyzing telemetry from resources. |
| Metric | Numeric measurement over time (for example CPU percentage). |
| Alert rule | A rule that triggers when a condition is met. |
| Threshold | The trigger value for an alert condition. |
| Severity | Importance level of an alert (for example informational, warning, critical). |
| Action group | Notification/action target used by alert rules (email, SMS, webhook, etc.). |
| Activity log | Control-plane record of create, update, and delete operations in Azure. |
| Ingress | Data entering a service. |
| Egress | Data leaving a service. |
| Health probe | A check used by load balancers to determine backend health. |

---

Reference: https://learn.microsoft.com/azure/azure-monitor/vm/tutorial-alerts
