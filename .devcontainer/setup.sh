#!/bin/bash
set -e

sudo sysctl --system

# Explicitly attach the FQ scheduler directly to eth0, bypassing global defaults
if ip link show eth0 > /dev/null 2>&1; then
    sudo tc qdisc replace dev eth0 root fq && echo "Success: attached fq scheduler to eth0"
else
    echo "Error: eth0 interface not found. Checking alternative host interfaces..."
    # If using network_mode: host, the interface might be named differently (e.g., ens3, eth1)
    ACTIVE_IFACE=$(ip -4 route show default | awk '{print $5}')
    if [ ! -z "$ACTIVE_IFACE" ]; then
        sudo tc qdisc replace dev "$ACTIVE_IFACE" root fq && echo "Success: attached fq scheduler to $ACTIVE_IFACE"
    fi
fi

echo "✅ Network optimization routine completed."
