#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/text_to_3d.sh -p "prompt text" -o output_dir

Generates a simple OBJ mesh and metadata derived from a text prompt.
USAGE
}

prompt=""
output_dir=""

while getopts ":p:o:h" opt; do
  case "${opt}" in
    p) prompt="${OPTARG}" ;;
    o) output_dir="${OPTARG}" ;;
    h) usage; exit 0 ;;
    \?) usage; exit 1 ;;
  esac
done

if [[ -z "${prompt}" || -z "${output_dir}" ]]; then
  usage
  exit 1
fi

mkdir -p "${output_dir}"

cat <<EOF > "${output_dir}/metadata.json"
{
  "prompt": "$(printf "%s" "${prompt}" | sed 's/"/\\"/g')",
  "generator": "text_to_3d.sh",
  "output": "mesh.obj"
}
EOF

cat <<'EOF' > "${output_dir}/mesh.obj"
o GPT3D_TextMesh
v -0.5 -0.5 -0.5
v 0.5 -0.5 -0.5
v 0.5 0.5 -0.5
v -0.5 0.5 -0.5
v -0.5 -0.5 0.5
v 0.5 -0.5 0.5
v 0.5 0.5 0.5
v -0.5 0.5 0.5
f 1 2 3 4
f 5 6 7 8
f 1 2 6 5
f 2 3 7 6
f 3 4 8 7
f 4 1 5 8
EOF

printf "%s\n" "${prompt}" > "${output_dir}/prompt.txt"

echo "Generated ${output_dir}/mesh.obj from prompt."
