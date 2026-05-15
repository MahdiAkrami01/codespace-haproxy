#!/bin/bash
set -e

echo "🚀 Applying kernel and network optimizations..."

# FS Optimizations
sudo sysctl -w fs.pipe-max-size=1048576
sudo sysctl -w fs.file-max=2097152

# Network Queue Discipline & Congestion Control
sudo sysctl -w net.core.default_qdisc=fq
sudo sysctl -w net.ipv4.tcp_congestion_control=bbr

# TCP Buffer Memory Allocations
sudo sysctl -w net.core.rmem_max=16777216
sudo sysctl -w net.core.wmem_max=16777216
sudo sysctl -w net.core.rmem_default=8388608
sudo sysctl -w net.core.wmem_default=8388608
sudo sysctl -w net.ipv4.tcp_rmem="4096 87380 16777216"
sudo sysctl -w net.ipv4.tcp_wmem="4096 65536 16777216"

# Window Scaling & Backlog Backpressure
sudo sysctl -w net.ipv4.tcp_window_scaling=1
sudo sysctl -w net.core.netdev_max_backlog=4096

# Protocol Constraints (Disable MPTCP, Enable TFO)
sudo sysctl -w net.mptcp.enabled=0
sudo sysctl -w net.ipv4.tcp_fastopen=3

echo "✅ All sysctl profiles loaded successfully into the host namespace."
