#!/bin/bash
set -e

echo "=================================================="
echo "[WARNING] EMERGENCY ROLLBACK INITIATED!"
echo "[INFO] Reverting Live Traffic Back to Stable BLUE (v1.0)..."
echo "=================================================="

# Execute switch-to-blue.sh
if [ -f "./switch-to-blue.sh" ]; then
    ./switch-to-blue.sh
else
    bash switch-to-blue.sh
fi

echo "=================================================="
echo "[SUCCESS] ROLLBACK COMPLETE! Production Traffic Safely Restored to BLUE v1.0!"
echo "=================================================="
