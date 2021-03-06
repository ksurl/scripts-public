#!/bin/bash

notify_discord() {
  local ts=$(date)
  local webhook="https://discord.com/api/webhooks/X/Y" # replace with your webhook
  curl $webhook \
  -H "Content-Type: application/json" \
  -X POST \
  -d @<(cat <<EOF
{
  "embeds": [
    {
      "title": "proxmox",
      "fields": [
        {
          "name": "Hostname",
          "value": "$1",
          "inline": true
        },
        {
          "name": "VM Type",
          "value": "$2",
          "inline": true
        },
        {
          "name": "Backup Mode",
          "value": "$3",
          "inline": true
        },
        {
          "name": "Backup Status",
          "value": "$4"
        },
        {
          "name": "Timestamp",
          "value": "$ts"
        }
      ],
      "color": "$5"
    }
  ]
}
EOF
)
}

vzdump_hook() {
  local phase="$1" # (job|backup)-(start|end|abort)/log-end/pre-(stop|restart)/post-restart
  case "$phase" in
    # set variables for the phases
    job-start|job-end|job-abort)
      ;;&
    backup-start|backup-end|backup-abort|log-end|pre-stop|pre-restart|post-restart)
      local mode="$2" # stop/suspend/snapshot
      local vmid="$3"
      local vmtype="$VMTYPE" # openvz/qemu
      local hostname="$HOSTNAME"      
      ;;&
    backup-end)
      local tarfile="$TARFILE"
      ;;&
    log-end)
      local logfile="$LOGFILE"
      ;;&
    job-start)
      ;;
    job-end)
      ;;
    job-abort)
      ;;
    backup-start)
      # notify start
      notify_discord $hostname $vmtype $mode "started" "12566463" # grey
      #notify_discord $hostname $vmtype $mode "started" "16110658" # yellow
      ;;
    backup-end)
      # notify finish
      notify_discord $hostname $vmtype $mode "completed" "6729778" # green
      curl -fsS "https://hc-ping.com/X" # replace with your healthchecks.io url
      ;;
    backup-abort)
      # notify abort
      notify_discord $hostname $vmtype $mode "aborted" "16711680" # red
      ;;
    log-end)
      ;;
    pre-stop)
      ;;
    pre-restart)
      ;;
    post-restart)
      ;;
    *)
      echo "unknown phase '$phase'"
      return 1
      ;;
  esac
}

vzdump_hook "$@"
