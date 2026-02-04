#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/animate_pack.sh -i path/to/rigged_mesh.obj -o output_dir

Creates a simple animation manifest for idle, walk, and run clips.
USAGE
}

mesh_path=""
output_dir=""

while getopts ":i:o:h" opt; do
  case "${opt}" in
    i) mesh_path="${OPTARG}" ;;
    o) output_dir="${OPTARG}" ;;
    h) usage; exit 0 ;;
    \?) usage; exit 1 ;;
  esac
done

if [[ -z "${mesh_path}" || -z "${output_dir}" ]]; then
  usage
  exit 1
fi

if [[ ! -f "${mesh_path}" ]]; then
  echo "Rigged mesh not found: ${mesh_path}" >&2
  exit 1
fi

mkdir -p "${output_dir}/animations"
cp "${mesh_path}" "${output_dir}/animated_mesh.obj"

cat <<'EOF' > "${output_dir}/animations/manifest.json"
{
  "animations": [
    { "name": "idle", "frames": [0, 30] },
    { "name": "walk", "frames": [31, 90] },
    { "name": "run", "frames": [91, 150] }
  ]
}
EOF

echo "Animation manifest written to ${output_dir}/animations/manifest.json."
