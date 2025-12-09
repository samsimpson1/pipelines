#!/usr/bin/env bash

BOX="${1}"

DATA=$(hcloud storage-box describe "$BOX" -o json)

USED_BYTES=$(jq -r '.stats.size' <<< "$DATA")
MAX_BYTES=$(jq -r '.storage_box_type.size' <<< "$DATA")

SNAPSHOTS=$(hcloud storage-box snapshot list "$BOX" -o json)
SNAPSHOT_COUNT=$(jq '. | length' <<< "$SNAPSHOTS")

cat <<EOF | curl --data-binary @- https://prometheus-push.int.simpson.id/metrics/job/storage-box
# HELP storage_box_used_bytes The amount of used storage in bytes
# TYPE storage_box_used_bytes gauge
storage_box_used_bytes{storage_box="$BOX"} $USED_BYTES
# HELP storage_box_max_bytes The maximum storage capacity of the storage box in bytes
# TYPE storage_box_max_bytes gauge
storage_box_max_bytes{storage_box="$BOX"} $MAX_BYTES
# HELP storage_box_snapshot_count The number of snapshots of the storage box
# TYPE storage_box_snapshot_count gauge
storage_box_snapshot_count{storage_box="$BOX"} $SNAPSHOT_COUNT
EOF