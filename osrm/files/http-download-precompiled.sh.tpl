#!/usr/bin/env bash
set -euo pipefail

ensure_dependency() {
  if ! which "$1" &>/dev/null ; then
    echo "$1 not found"
    exit 1
  fi
}

ensure_dependency wget
ensure_dependency tar

uri="{{ .Values.map.http.uri }}"
version="{{ .Values.map.http.version | default "unversioned" }}"

mkdir -p "/data/maps/${version}"
cd "/data/maps/${version}"

files=(
  "map.osrm"
  "map.osrm.cell_metrics"
  "map.osrm.cells"
  "map.osrm.cnbg"
  "map.osrm.cnbg_to_ebg"
  "map.osrm.datasource_names"
  "map.osrm.ebg"
  "map.osrm.ebg_nodes"
  "map.osrm.edges"
  "map.osrm.enw"
  "map.osrm.fileIndex"
  "map.osrm.geometry"
  "map.osrm.icd"
  "map.osrm.maneuver_overrides"
  "map.osrm.mldgr"
  "map.osrm.names"
  "map.osrm.nbg_nodes"
  "map.osrm.partition"
  "map.osrm.properties"
  "map.osrm.ramIndex"
  "map.osrm.restrictions"
  "map.osrm.timestamp"
  "map.osrm.tld"
  "map.osrm.tls"
  "map.osrm.turn_duration_penalties"
  "map.osrm.turn_penalties_index"
  "map.osrm.turn_weight_penalties"
)

if [ ! -r downloaded.lock ]; then
  printf "${uri}/%s\n" "${files[@]}" > files.txt
  wget -i files.txt

  touch downloaded.lock
fi

echo "Done!"
exit 0
