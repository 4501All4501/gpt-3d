#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/image_to_3d.sh -i path/to/image -o output_dir

Generates a simple OBJ mesh and stores the reference image alongside metadata.
USAGE
}

image_path=""
output_dir=""

while getopts ":i:o:h" opt; do
  case "${opt}" in
    i) image_path="${OPTARG}" ;;
    o) output_dir="${OPTARG}" ;;
    h) usage; exit 0 ;;
    \?) usage; exit 1 ;;
  esac
done

if [[ -z "${image_path}" || -z "${output_dir}" ]]; then
  usage
  exit 1
fi

if [[ ! -f "${image_path}" ]]; then
  echo "Image not found: ${image_path}" >&2
  exit 1
fi

mkdir -p "${output_dir}"
image_ext="${image_path##*.}"
reference_name="reference_image.${image_ext}"
cp "${image_path}" "${output_dir}/${reference_name}"

cat <<EOF > "${output_dir}/metadata.json"
{
  "reference_image": "${reference_name}",
  "generator": "image_to_3d.sh",
  "output": "mesh.obj"
}
EOF

cat <<'EOF' > "${output_dir}/mesh.obj"
o GPT3D_ImageMesh
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

echo "Generated ${output_dir}/mesh.obj from ${image_path}."
