#!/bin/bash
# Kill zombie Claude processes that consume high CPU
# Run this when CPU usage is high

echo "🔍 Finding Claude processes with high CPU..."

# Get all Claude native-binary processes
pids=$(ps aux | grep "claude-code.*native-binary/claude" | grep -v grep | awk '{print $2}')

if [ -z "$pids" ]; then
    echo "✅ No Claude zombie processes found."
    exit 0
fi

count=$(echo "$pids" | wc -l | tr -d ' ')
echo "⚠️  Found $count Claude processes"

# Show processes before killing
echo ""
echo "Processes to kill:"
ps aux | grep "claude-code.*native-binary/claude" | grep -v grep | awk '{printf "PID: %s  CPU: %s%%\n", $2, $3}'

echo ""
read -p "Kill all these processes? (y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "$pids" | xargs kill -9 2>/dev/null
    echo "✅ Killed $count Claude processes"
else
    echo "❌ Cancelled"
fi
