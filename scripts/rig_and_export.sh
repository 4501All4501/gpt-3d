#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/rig_and_export.sh -i path/to/mesh.obj -o output_dir

Copies the input mesh and emits a minimal rig definition alongside it.
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
  echo "Mesh not found: ${mesh_path}" >&2
  exit 1
fi

mkdir -p "${output_dir}"
cp "${mesh_path}" "${output_dir}/rigged_mesh.obj"

cat <<'EOF' > "${output_dir}/rig.json"
{
  "skeleton": [
    { "name": "root", "parent": null },
    { "name": "spine", "parent": "root" },
    { "name": "head", "parent": "spine" }
  ]
}
EOF

echo "Rig data written to ${output_dir}/rig.json."
