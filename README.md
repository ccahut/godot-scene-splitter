# \# Scene Splitter

# 

# Godot 4 editor plugin that splits the direct children of the currently opened scene into separate `.tscn` files and organizes them into folders.

# 

# Useful when you import a large 3D scene (for example from Blender) and want to quickly turn each object into its own reusable scene.

# 

# \## Features

# 

# \- Splits all direct children of the current scene into individual `.tscn` files

# \- Automatically creates folders based on object name prefixes (e.g. `prop\_table` → `models/prop/`)

# \- Places each model at the origin (keeps rotation and scale)

# \- Simple one-click workflow through the editor menu

# 

# \## Installation

# 

# 1\. Download or clone this repository

# 2\. Copy the `addons/scene\_splitter` folder into your project's `addons/` directory

# 3\. Go to \*\*Project → Project Settings → Plugins\*\*

# 4\. Enable \*\*Scene Splitter\*\*

# 

# \## How to use

# 

# 1\. Open the scene you want to split (usually an imported `.glb` / `.gltf` / `.fbx`)

# 2\. Go to \*\*Project → Tools → Scene Splitter: Split Scene\*\*

# 3\. The plugin will create separate `.tscn` files in `res://models/`

# 

# \### Folder structure example

# 

# If your scene contains nodes named:

# \- `prop\_table`

# \- `prop\_chair`

# \- `building\_house`

# \- `tree\_oak`

# 

# The result will be:

# res://models/

# ├── prop/

# │   ├── prop\_table.tscn

# │   └── prop\_chair.tscn

# ├── building/

# │   └── building\_house.tscn

# └── tree/

# └── tree\_oak.tscn

# text## Notes

# 

# \- Only \*\*direct children\*\* of the root node are processed

# \- Nodes without an owner are skipped

# \- Output folder is currently hardcoded to `res://models/`

# \- Works with Godot 4.x

# 

# \## License

# 

# MIT License

