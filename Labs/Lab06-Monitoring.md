# Lab 6 - Monitoring

In this lab, you will learn how to monitor different cloud resources using Azure Monitor.

## Learning Objectives

[TODO: Add learning objectives here]

---

# Lab: Azure Monitor Alerts for Cloud Resources

**Module:** Cloud Fundamentals
**Lab topic:** Monitoring cloud resources using Azure Monitor
**Cloud platform:** Microsoft Azure
**Subscription:** `Cloud Fundamentals Labs`
**Resource group:** `CloudFun-Lab-Monitoring`
**Role:** Contributor

This lab is based on the Microsoft Learn tutorial **“Enable recommended alerts for an Azure virtual machine”**. The tutorial explains that once enhanced monitoring is enabled for a VM, recommended alert rules can be used to notify administrators when the VM experiences issues or performance degradation. ([Microsoft Learn][1])

---

## 1. Aim of the Lab

In this lab, you will use **Azure Monitor** to create and review monitoring alerts for cloud resources.

You will focus mainly on a **Virtual Machine**, then consider how similar monitoring ideas apply to:

* Virtual Machines
* Virtual Networks
* Blob Storage
* Load Balancers

---

## 2. Learning Outcomes

By the end of this lab, you should be able to:

1. Locate monitoring tools in the Azure Portal.
2. View recommended alerts for an Azure VM.
3. Configure alert thresholds and severity levels.
4. Create or prepare an action group for email notifications.
5. View and manage created alert rules.
6. Explain why monitoring and alerts are important in cloud computing.

Microsoft Learn states that this tutorial covers enabling recommended VM alerts, configuring alert thresholds and severity, setting up email notifications using action groups, and viewing created alert rules. ([Microsoft Learn][1])

---

## 3. Before You Start

Make sure you can sign in to the Azure Portal.

You must use:

**Subscription:** `Cloud Fundamentals Labs`
**Resource group:** `CloudFun-Lab-Monitoring`

You have **Contributor** access to this resource group. This means you can make changes, so work carefully.

### Important Rules

Do not:

* Delete any resources.
* Create resources outside the given resource group.
* Change resources belonging to another student.
* Change network security rules unless your tutor tells you to.
* Create expensive resources.

---

# Task 1: Open the Correct Resource Group

## Steps

1. Sign in to the **Azure Portal**.

2. In the search bar at the top, search for:

   `Resource groups`

3. Open **Resource groups**.

4. Select:

   `CloudFun-Lab-Monitoring`

5. Check that the subscription is:

   `Cloud Fundamentals Labs`

6. Look at the list of resources in the resource group.

You should see resources such as:

* A Virtual Machine
* A Virtual Network
* A Storage Account
* A Load Balancer

## Evidence Required

Take a screenshot showing:

* The resource group name.
* The subscription name.
* The list of resources.

## Questions

Answer these in your lab notes:

1. What is the name of the resource group?
2. What is the name of the subscription?
3. What types of resources can you see?

---

# Task 2: Open Azure Monitor

## Steps

1. In the Azure Portal search bar, search for:

   `Monitor`

2. Open **Monitor**.

3. Look at the menu on the left-hand side.

4. Find the following areas:

   * Metrics
   * Alerts
   * Logs
   * Workbooks
   * Activity log

## Evidence Required

Take a screenshot of the Azure Monitor menu.

## Questions

Answer these in your lab notes:

1. What is Azure Monitor used for?
2. What is the difference between a metric and an alert?
3. Why is monitoring important in cloud computing?

---

# Task 3: Open the Virtual Machine Monitoring Page

Microsoft Learn explains that recommended alert rules are available from the VM menu by selecting **Alerts** in the **Monitoring** section, then selecting **View + set up** or **Set up recommended alerts**. ([Microsoft Learn][1])

## Steps

1. Return to the resource group:

   `CloudFun-Lab-Monitoring`

2. Select one of the **Virtual Machine** resources.

3. On the left-hand menu, find the **Monitoring** section.

4. Select **Alerts**.

5. Look for one of the following options:

   * **View + set up**
   * **Set up recommended alerts**
   * **Recommended alerts**

The exact wording may vary slightly depending on the Azure Portal layout.

## Evidence Required

Take a screenshot showing the VM **Alerts** page.

## Questions

Answer these in your lab notes:

1. What is the name of the VM you selected?
2. Where did you find the Alerts option?
3. Why might a VM need alerts?

---

# Task 4: View Recommended Alert Rules

Azure Monitor provides recommended alert rules for common VM performance scenarios. These can help administrators quickly monitor common problems such as performance degradation. ([Microsoft Learn][1])

## Steps

1. On the VM **Alerts** page, select:

   **View + set up**

   or

   **Set up recommended alerts**

2. Review the list of recommended alert rules.

3. Look for alerts related to common VM issues, such as:

   * CPU usage
   * Memory availability
   * Disk activity
   * Network activity
   * VM availability

4. Do not save anything yet.

## Evidence Required

Take a screenshot of the recommended alert rules list.

## Questions

Answer these in your lab notes:

1. Name two recommended alert rules shown for the VM.
2. What problem could a high CPU alert help detect?
3. What problem could a low memory alert help detect?

---

# Task 5: Configure Alert Thresholds

Microsoft Learn explains that students can select which recommended rules to create and can also change the recommended threshold. ([Microsoft Learn][1])

## Steps

1. Expand one of the recommended alert rules.
2. Look at the alert condition.
3. Find the threshold value.
4. Choose one alert rule to inspect more closely.

For example, you may see a rule similar to:

* CPU greater than a percentage value.
* Available memory below a specific value.
* Disk read or write activity above a specific value.

5. Do not choose an extreme value.
6. If your tutor asks you to edit a threshold, use a sensible value.

Example:

| Metric           | Example threshold              |
| ---------------- | ------------------------------ |
| Percentage CPU   | Greater than 80%               |
| Available memory | Less than recommended value    |
| Disk activity    | Greater than recommended value |

## Evidence Required

Take a screenshot showing the alert rule details and threshold.

## Questions

Answer these in your lab notes:

1. Which alert rule did you inspect?
2. What metric does it monitor?
3. What threshold value was shown?
4. What might happen if the threshold is set too low?
5. What might happen if the threshold is set too high?

---

# Task 6: Configure Alert Severity

Microsoft Learn states that each alert rule can be expanded to view its details, and that the default severity may be **Informational**. It also explains that the severity can be changed to levels such as **Warning** or **Error**, depending on how critical the condition is. ([Microsoft Learn][1])

## Steps

1. Expand one of the recommended alert rules.
2. Find the **Severity** setting.
3. Review the available severity options.
4. Choose a suitable severity level.

Suggested examples:

| Alert type                    | Suggested severity |
| ----------------------------- | ------------------ |
| High CPU usage                | Warning            |
| VM unavailable                | Error              |
| Disk activity high            | Warning            |
| Informational monitoring only | Informational      |

5. Do not save yet unless instructed by your tutor.

## Evidence Required

Take a screenshot showing the severity setting.

## Questions

Answer these in your lab notes:

1. What severity level did you choose?
2. Why did you choose that severity?
3. What is the difference between an informational alert and an error alert?

---

# Task 7: Set Up Email Notification Using an Action Group

Microsoft Learn explains that email notifications can be enabled by providing an email address, and that an **action group** can be created using that address. If an action group already exists, it can be selected instead. ([Microsoft Learn][1])

## Steps

1. In the recommended alerts setup screen, look for the notification or action group section.
2. Check whether **Email** is enabled.
3. Enter your student email address only if your tutor tells you to do so.
4. If an action group has already been provided, select it.
5. If you are asked to create a new action group, use a clear name.

Example action group name:

`StudentName-VM-Alert-ActionGroup`

6. Review the settings before saving.

## Evidence Required

Take a screenshot showing the notification or action group configuration.

## Questions

Answer these in your lab notes:

1. What is an action group?
2. What type of notification did you configure?
3. Why is it useful to send an email when an alert is triggered?

---

# Task 8: Save the Alert Rules

Microsoft Learn instructs users to select **Save** to create the alert rules. ([Microsoft Learn][1])

Only complete this task if your tutor gives permission.

## Steps

1. Review the alert rules you selected.

2. Check:

   * Alert names
   * Thresholds
   * Severity levels
   * Email/action group settings

3. Select **Save**.

## Evidence Required

Take a screenshot before or after saving the alert rules.

## Questions

Answer these in your lab notes:

1. How many alert rules did you create?
2. Which alert rule do you think is the most important?
3. Why should cloud administrators review alert settings before saving them?

---

# Task 9: View Created Alert Rules

After alert rule creation is complete, Microsoft Learn explains that users can view the VM alerts screen and select **Alert rules** to see the rules that were just created. Users can also open a rule to view its details or modify its threshold. ([Microsoft Learn][1])

## Steps

1. Open the VM again.
2. Go to **Monitoring** > **Alerts**.
3. Select **Alert rules**.
4. Find the alert rules you created.
5. Open one alert rule.
6. Review:

   * Scope
   * Condition
   * Threshold
   * Severity
   * Action group

## Evidence Required

Take a screenshot showing the list of alert rules.

Take another screenshot showing the details of one alert rule.

## Questions

Answer these in your lab notes:

1. Where can you view created alert rules?
2. What resource is the alert rule connected to?
3. What condition causes the alert to trigger?
4. How could you change the alert later?

---

# Task 10: Consider Monitoring Other Resources

You have now created or reviewed VM alert rules. Monitoring is not only useful for VMs. Cloud administrators also monitor networking, storage, and load balancing.

Use the resource group to briefly inspect monitoring options for the following resources.

---

## 10A: Virtual Network Monitoring

### Steps

1. Go to the resource group.
2. Open the **Virtual Network**.
3. Find the **Monitoring** section.
4. Open:

   * Metrics
   * Activity log

### Questions

1. What monitoring options are available for the VNet?
2. What does the Activity log show?
3. Why is network monitoring important?

### Evidence

Take a screenshot of the VNet monitoring page.

---

## 10B: Blob Storage Monitoring

### Steps

1. Go to the resource group.
2. Open the **Storage Account**.
3. Go to **Monitoring** > **Metrics**.
4. Look for Blob-related metrics such as:

   * Transactions
   * Ingress
   * Egress
   * Availability
   * Latency

### Questions

1. What is Blob storage used for?
2. What does Ingress mean?
3. What does Egress mean?
4. Why might storage latency matter?

### Evidence

Take a screenshot of a storage metric chart.

---

## 10C: Load Balancer Monitoring

### Steps

1. Go to the resource group.
2. Open the **Load Balancer**.
3. Go to **Monitoring**.
4. Open:

   * Metrics
   * Insights, if available
5. Look for metrics such as:

   * Health probe status
   * Data path availability
   * Byte count
   * Packet count

### Questions

1. What is the purpose of a load balancer?
2. What does a health probe check?
3. Why is load balancer monitoring important?

### Evidence

Take a screenshot of the Load Balancer monitoring page.

---

# Task 11: Create a Simple Monitoring Summary Table

Complete the table below in your lab report.

| Resource        | Monitoring Feature Used | Example Metric or Alert | Why It Matters |
| --------------- | ----------------------- | ----------------------- | -------------- |
| Virtual Machine | Alerts                  |                         |                |
| Virtual Network | Metrics or Activity log |                         |                |
| Blob Storage    | Metrics                 |                         |                |
| Load Balancer   | Metrics or Insights     |                         |                |

---

# Task 12: Reflection

Write a short reflection of **150–250 words**.

Your reflection should answer:

1. Why are alerts useful in cloud computing?
2. What could happen if a VM problem is not detected quickly?
3. Why might a cloud administrator want alerts for storage or load balancing?
4. What did you find easiest or hardest in this lab?

---

# Submission Checklist

Submit a short lab report containing:

* Your name and student number.
* Screenshot of the correct resource group.
* Screenshot of Azure Monitor.
* Screenshot of VM recommended alerts.
* Screenshot of one alert threshold.
* Screenshot of alert severity.
* Screenshot of action group or notification settings.
* Screenshot of created alert rules, if saved.
* Screenshots for VNet, Blob Storage, and Load Balancer monitoring.
* Completed monitoring summary table.
* Answers to all questions.
* 150–250 word reflection.

---

# Key Terms

| Term          | Meaning                                                                              |
| ------------- | ------------------------------------------------------------------------------------ |
| Azure Monitor | Azure service used to collect, view, and respond to monitoring data.                 |
| Metric        | A numerical measurement, such as CPU percentage or network traffic.                  |
| Alert rule    | A rule that checks for a condition and triggers an alert when that condition is met. |
| Threshold     | The value that causes an alert to trigger.                                           |
| Severity      | A rating that shows how important or serious an alert is.                            |
| Action group  | A set of actions, such as sending an email, that happen when an alert fires.         |
| Ingress       | Data entering a service.                                                             |
| Egress        | Data leaving a service.                                                              |
| Health probe  | A load balancer check used to see whether a backend resource is healthy.             |

[1]: https://learn.microsoft.com/en-us/azure/azure-monitor/vm/tutorial-alerts "Enable recommended alerts for an Azure virtual machine - Azure Monitor | Microsoft Learn"
