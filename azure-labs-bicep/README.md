# Azure Labs Bicep Bootstrap

Reusable lab bootstrap system for the **Cloud Fundamentals Azure Labs** course.

## Overview

This system scaffolds Azure lab environments using Bicep. For every lab/student pair it:

1. Creates a dedicated **Resource Group** using a consistent naming convention.
2. Defines per-lab **Azure Policy definitions** and a **Policy Set (initiative)** at subscription scope.
3. **Assigns** the initiative to the lab Resource Group so only allowed resource types, locations, and SKUs can be deployed by students.

## Labs

| Lab ID         | Description              | Lab-specific control       |
|----------------|--------------------------|----------------------------|
| `lab01-vm`     | Virtual Machine lab      | Allowed VM SKUs            |
| `lab02-storage`| Storage Account lab      | Allowed Storage SKUs       |
| `lab03-network`| Networking lab           | Deny public IP addresses   |

## Folder Structure

```text
azure-labs-bicep/
  README.md
  .gitignore
  scripts/
    deploy.sh          # Deploy a lab for a student
    destroy.sh         # Tear down a lab for a student
  bicep/
    shared/
      naming.bicep     # Naming-convention outputs module
      tags.bicep       # Standard tags outputs module
      policies/
        allowed-locations.bicep       # Deny resources outside allowed regions
        allowed-resource-types.bicep  # Deny non-whitelisted resource types
        allowed-vm-skus.bicep         # Deny non-whitelisted VM sizes (lab01)
        allowed-storage-skus.bicep    # Deny non-whitelisted storage SKUs (lab02)
        deny-public-ip.bicep          # Deny public IP addresses (lab03)
    labs/
      lab01-vm/
        main.bicep
        params.bicepparam
      lab02-storage/
        main.bicep
        params.bicepparam
      lab03-network/
        main.bicep
        params.bicepparam
```

## Naming Convention

| Resource            | Pattern                                          |
|---------------------|--------------------------------------------------|
| Resource Group      | `rg-cf-{cohort}-{labId}-{studentId}`            |
| Policy definition   | `pol-cf-{cohort}-{labId}-{control-name}`        |
| Initiative          | `init-cf-{cohort}-{labId}`                      |
| Policy assignment   | `asg-cf-{cohort}-{labId}-{studentId}`           |

## Prerequisites

- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli) — authenticated (`az login`)
- Bicep CLI — `az bicep install`
- **Contributor** + **Policy Contributor** roles on the target subscription

## Quick Start

### Deploy a lab

```bash
./scripts/deploy.sh <lab-id> <student-id> [cohort] [subscription-id]
```

Examples:

```bash
# Deploy lab01-vm for student001, cohort 2026
./scripts/deploy.sh lab01-vm student001 2026

# Specify an explicit subscription
./scripts/deploy.sh lab02-storage student042 2026 00000000-0000-0000-0000-000000000000
```

### Destroy / clean up a lab

```bash
./scripts/destroy.sh <lab-id> <student-id> [cohort] [subscription-id]
```

### Override default parameters

Edit the relevant `bicep/labs/<lab-id>/params.bicepparam` file, or pass individual
`--parameters key=value` flags when calling `az deployment sub create` directly.

## Bicep Design

- All **policy definitions and initiatives** are deployed at **subscription scope**.
- **Policy assignments** are scoped to the per-student **Resource Group** using
  `scope: rg` in Bicep.
- Each lab's `main.bicep` orchestrates RG creation, policy definition deployment,
  initiative creation, and initiative assignment in a single subscription-scoped
  deployment.

## Tags Applied to Every Resource Group

| Tag Key  | Value source                  |
|----------|-------------------------------|
| `module` | `CloudFundamentals` (fixed)   |
| `cohort` | `cohort` parameter            |
| `labId`  | lab identifier (e.g. lab01-vm)|
| `owner`  | `studentId` parameter         |
