func _on_pick_up_area_area_entered(area):
	if area.is_in_group("jeremy"):
		area.queue_free()
