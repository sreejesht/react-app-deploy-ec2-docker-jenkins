#!/bin/bash

echo "🔧 EC2 Rescue Script - Starting..."

# Step 1: Detect attached volume
DEVICE="/dev/xvdf"
MOUNT_POINT="/mnt/rescue"

# Step 2: Create mount directory
echo "📁 Creating mount point at $MOUNT_POINT..."
mkdir -p $MOUNT_POINT

# Step 3: Identify if partition exists
echo "🔍 Checking partitions..."
PARTITION=$(lsblk -ln $DEVICE | awk '{print $1}' | grep -v "^$" | head -n 1)

if [ -n "$PARTITION" ]; then
  echo "📦 Found partition: $PARTITION"
  MOUNT_DEV="/dev/$PARTITION"
else
  echo "📦 No partition found, using whole device."
  MOUNT_DEV="$DEVICE"
fi

# Step 4: Mount volume
echo "🗂️ Mounting $MOUNT_DEV to $MOUNT_POINT..."
mount $MOUNT_DEV $MOUNT_POINT

if [ $? -ne 0 ]; then
  echo "❌ Failed to mount volume. Exiting."
  exit 1
fi

# Step 5: Diagnostics

echo "📊 Disk usage:"
df -h $MOUNT_POINT

echo "🔥 Top 10 large files/folders:"
du -sh $MOUNT_POINT/* 2>/dev/null | sort -hr | head -n 10

echo "🛡️ Checking for iptables or firewall rules..."
if [ -f $MOUNT_POINT/etc/iptables/rules.v4 ]; then
  echo "Found iptables rules:"
  cat $MOUNT_POINT/etc/iptables/rules.v4
else
  echo "No iptables rules found."
fi

echo "🧾 Last 50 lines of syslog:"
if [ -f $MOUNT_POINT/var/log/syslog ]; then
  tail -n 50 $MOUNT_POINT/var/log/syslog
else
  echo "No syslog found."
fi

# Final Instructions
echo "✅ Review the logs and fix issues inside $MOUNT_POINT"
echo "💡 To unmount after you're done: sudo umount $MOUNT_POINT"
echo "🔁 Then detach this volume and reattach to the original instance as /dev/xvda"


