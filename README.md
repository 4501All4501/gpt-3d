# GPT-3D

GPT-3D is a Hugging Face–hosted project concept that turns text or images into 3D models without requiring an API key. It focuses on fast iteration, approachable UX, and strong out‑of‑the‑box results for creators who want usable assets rather than research demos.

## Highlights
- **Text‑to‑3D and Image‑to‑3D** generation with a simple prompt or single reference image.
- **No API key required** for core workflows.
- **Best‑effort quality defaults** tuned for clean meshes, balanced topology, and rapid preview.
- **Rigging and animation‑ready** exports for common DCC tools and game engines.
- **Chat‑driven variants** powered by GPT models (e.g., gpt‑4o‑mini, gpt‑4o) for iterative refinement.
- **Body type presets** for humanoids, cats, and dogs.

## Scripts
Use these scripts to kick off common workflows (paths shown relative to the repo root).
- `scripts/text_to_3d.sh` — generate a simple OBJ mesh plus prompt metadata from a text prompt.
- `scripts/image_to_3d.sh` — generate a simple OBJ mesh and store the reference image alongside metadata.
- `scripts/rig_and_export.sh` — copy a mesh and emit a minimal rig definition for downstream tools.
- `scripts/animate_pack.sh` — create an animation manifest for idle/walk/run clips.

## Example Use Cases
- Rapidly prototype a humanoid character, rig it, and export to a game engine.
- Generate a stylized cat or dog mesh from a photo and auto‑apply a skeleton.
- Iterate on a concept by chatting: “make it more athletic,” “shorten the tail,” or “add armor.”

## Roadmap
- Expand the body‑type library with more animal and creature presets.
- Improve auto‑rigging for non‑bipedal characters.
- Add animation packs (idle, walk, run) as optional exports.

## License
See [LICENSE](LICENSE).
