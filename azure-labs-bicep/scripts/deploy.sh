#!/usr/bin/env bash
# deploy.sh – Deploy a Cloud Fundamentals Azure lab for a single student.
#
# Usage:
#   ./scripts/deploy.sh <lab-id> <student-id> [cohort] [subscription-id]
#
# Arguments:
#   lab-id          Lab identifier, e.g. lab01-vm | lab02-storage | lab03-network
#   student-id      Student (or group) identifier, e.g. student001
#   cohort          Cohort year (default: 2026)
#   subscription-id Azure subscription ID (default: current az account)
#
# Examples:
#   ./scripts/deploy.sh lab01-vm student001
#   ./scripts/deploy.sh lab02-storage student042 2026 00000000-0000-0000-0000-000000000000

set -euo pipefail

# ---------------------------------------------------------------------------
# Arguments
# ---------------------------------------------------------------------------
LAB_ID="${1:?Error: lab-id is required. Usage: deploy.sh <lab-id> <student-id> [cohort] [subscription-id]}"
STUDENT_ID="${2:?Error: student-id is required. Usage: deploy.sh <lab-id> <student-id> [cohort] [subscription-id]}"
COHORT="${3:-2026}"
SUBSCRIPTION_ID="${4:-$(az account show --query id -o tsv)}"

# ---------------------------------------------------------------------------
# Resolve paths
# ---------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BICEP_DIR="${SCRIPT_DIR}/../bicep/labs/${LAB_ID}"
PARAMS_FILE="${BICEP_DIR}/params.bicepparam"

if [[ ! -d "${BICEP_DIR}" ]]; then
  echo "Error: Lab '${LAB_ID}' not found. Expected directory: ${BICEP_DIR}" >&2
  echo "Available labs:" >&2
  ls "${SCRIPT_DIR}/../bicep/labs/" >&2
  exit 1
fi

# ---------------------------------------------------------------------------
# Deploy
# ---------------------------------------------------------------------------
DEPLOYMENT_NAME="deploy-cf-${COHORT}-${LAB_ID}-${STUDENT_ID}-$(date -u +%Y%m%d%H%M%S)"
DEPLOY_LOCATION="uksouth"

echo "============================================================"
echo " Cloud Fundamentals – Lab Deployment"
echo "============================================================"
echo "  Lab:            ${LAB_ID}"
echo "  Student:        ${STUDENT_ID}"
echo "  Cohort:         ${COHORT}"
echo "  Subscription:   ${SUBSCRIPTION_ID}"
echo "  Deployment:     ${DEPLOYMENT_NAME}"
echo "============================================================"

az deployment sub create \
  --subscription  "${SUBSCRIPTION_ID}" \
  --location      "${DEPLOY_LOCATION}" \
  --name          "${DEPLOYMENT_NAME}" \
  --template-file "${BICEP_DIR}/main.bicep" \
  --parameters    "${PARAMS_FILE}" \
  --parameters    cohort="${COHORT}" studentId="${STUDENT_ID}"

echo ""
echo "Deployment complete."
echo "  Resource Group: rg-cf-${COHORT}-${LAB_ID}-${STUDENT_ID}"
