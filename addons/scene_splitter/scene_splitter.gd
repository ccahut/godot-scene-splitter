@tool
extends EditorPlugin

const OUTPUT_DIR := "res://models/"


func _enter_tree() -> void:
	add_tool_menu_item("Scene Splitter: Split Scene", _on_split_pressed)


func _exit_tree() -> void:
	remove_tool_menu_item("Scene Splitter: Split Scene")


func _on_split_pressed() -> void:
	var root := EditorInterface.get_edited_scene_root()

	if root == null:
		_show_message("Scene Splitter", "Please open the scene you want to split first.")
		return

	var output_path := ProjectSettings.globalize_path(OUTPUT_DIR)
	DirAccess.make_dir_recursive_absolute(output_path)

	var count := 0

	for child in root.get_children():
		if child.owner == null:
			continue

		var category := get_category(child.name)
		var folder := OUTPUT_DIR + category + "/"

		DirAccess.make_dir_recursive_absolute(
			ProjectSettings.globalize_path(folder)
		)

		var new_root := Node3D.new()
		new_root.name = child.name

		var copy := child.duplicate(Node.DUPLICATE_USE_INSTANTIATION)

		# Place the model at the origin without changing its rotation or scale.
		copy.position = Vector3.ZERO

		new_root.add_child(copy)
		copy.owner = new_root

		var packed := PackedScene.new()
		var pack_error := packed.pack(new_root)

		if pack_error != OK:
			print("Scene Splitter ERROR: Failed to pack ", child.name)
			new_root.free()
			continue

		var file_path := folder + child.name + ".tscn"
		var save_error := ResourceSaver.save(packed, file_path)

		if save_error == OK:
			print("Scene Splitter: Created ", file_path)
			count += 1
		else:
			print("Scene Splitter ERROR: Failed to save ", file_path)

		new_root.free()

	_show_message(
		"Scene Splitter",
		"Done!\n\nScenes created: %d\n\nOutput folder:\n%s" % [count, OUTPUT_DIR]
	)


func get_category(object_name: String) -> String:
	var name := object_name.to_lower()
	var underscore := name.find("_")

	if underscore >= 0:
		return name.substr(0, underscore)

	return name


func _show_message(title: String, message: String) -> void:
	var dialog := AcceptDialog.new()
	dialog.title = title
	dialog.dialog_text = message
	dialog.ok_button_text = "OK"

	EditorInterface.get_base_control().add_child(dialog)
	dialog.popup_centered()

	# Free the dialog after it is closed.
	dialog.confirmed.connect(_on_dialog_confirmed.bind(dialog))


func _on_dialog_confirmed(dialog: AcceptDialog) -> void:
	dialog.queue_free()
