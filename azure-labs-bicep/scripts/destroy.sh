#!/usr/bin/env bash
# destroy.sh – Remove a Cloud Fundamentals Azure lab for a single student.
#
# Usage:
#   ./scripts/destroy.sh <lab-id> <student-id> [cohort] [subscription-id]
#
# Arguments:
#   lab-id          Lab identifier, e.g. lab01-vm | lab02-storage | lab03-network
#   student-id      Student (or group) identifier, e.g. student001
#   cohort          Cohort year (default: 2026)
#   subscription-id Azure subscription ID (default: current az account)
#
# The script removes (in order):
#   1. The policy assignment on the Resource Group
#   2. The Resource Group (and all resources within it)
#   3. The lab initiative (policy set definition)
#   4. All lab policy definitions

set -euo pipefail

# ---------------------------------------------------------------------------
# Arguments
# ---------------------------------------------------------------------------
LAB_ID="${1:?Error: lab-id is required. Usage: destroy.sh <lab-id> <student-id> [cohort] [subscription-id]}"
STUDENT_ID="${2:?Error: student-id is required. Usage: destroy.sh <lab-id> <student-id> [cohort] [subscription-id]}"
COHORT="${3:-2026}"
SUBSCRIPTION_ID="${4:-$(az account show --query id -o tsv)}"

# ---------------------------------------------------------------------------
# Derived names (must match naming convention in naming.bicep / main.bicep)
# ---------------------------------------------------------------------------
RG_NAME="rg-cf-${COHORT}-${LAB_ID}-${STUDENT_ID}"
ASSIGNMENT_NAME="asg-cf-${COHORT}-${LAB_ID}-${STUDENT_ID}"
INITIATIVE_NAME="init-cf-${COHORT}-${LAB_ID}"

echo "============================================================"
echo " Cloud Fundamentals – Lab Teardown"
echo "============================================================"
echo "  Lab:            ${LAB_ID}"
echo "  Student:        ${STUDENT_ID}"
echo "  Cohort:         ${COHORT}"
echo "  Subscription:   ${SUBSCRIPTION_ID}"
echo "  Resource Group: ${RG_NAME}"
echo "============================================================"

RG_SCOPE="/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RG_NAME}"

# 1. Remove policy assignment (best-effort)
echo ""
echo "Step 1/4: Removing policy assignment '${ASSIGNMENT_NAME}'..."
az policy assignment delete \
  --name "${ASSIGNMENT_NAME}" \
  --scope "${RG_SCOPE}" \
  --subscription "${SUBSCRIPTION_ID}" \
  2>/dev/null && echo "  Removed." || echo "  Not found – skipping."

# 2. Delete resource group (best-effort)
echo ""
echo "Step 2/4: Deleting resource group '${RG_NAME}'..."
az group delete \
  --name "${RG_NAME}" \
  --subscription "${SUBSCRIPTION_ID}" \
  --yes \
  2>/dev/null && echo "  Deleted." || echo "  Not found – skipping."

# 3. Remove initiative (best-effort)
echo ""
echo "Step 3/4: Removing initiative '${INITIATIVE_NAME}'..."
az policy set-definition delete \
  --name "${INITIATIVE_NAME}" \
  --subscription "${SUBSCRIPTION_ID}" \
  2>/dev/null && echo "  Removed." || echo "  Not found – skipping."

# 4. Remove policy definitions (best-effort)
echo ""
echo "Step 4/4: Removing policy definitions..."
POLICY_SUFFIXES=(
  "allowed-locations"
  "allowed-resource-types"
  "allowed-vm-skus"
  "allowed-storage-skus"
  "deny-public-ip"
)
for SUFFIX in "${POLICY_SUFFIXES[@]}"; do
  POLICY_NAME="pol-cf-${COHORT}-${LAB_ID}-${SUFFIX}"
  az policy definition delete \
    --name "${POLICY_NAME}" \
    --subscription "${SUBSCRIPTION_ID}" \
    2>/dev/null && echo "  Removed '${POLICY_NAME}'." || echo "  '${POLICY_NAME}' not found – skipping."
done

echo ""
echo "Teardown complete."
