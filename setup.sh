#!/bin/bash
set -e

sudo sysctl --system

# Explicitly attach the FQ scheduler directly to eth0, bypassing global defaults
IFACE=$(ip -4 route show default | awk '{print $5}')
if [ -z "$IFACE" ]; then
    IFACE="eth0"
fi

echo "Attaching fq qdisc to interface: $IFACE"
sudo tc qdisc replace dev "$IFACE" root fq >/dev/null 2>&1 || true

echo "✅ Network optimization completed."
