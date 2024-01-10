extends GDScript

const materials = [
	preload("res://Materials/FoodTray/FoodTrayBlue.tres"),
	preload("res://Materials/FoodTray/FoodTrayGreen.tres"),
	preload("res://Materials/FoodTray/FoodTrayOrange.tres"),
	preload("res://Materials/FoodTray/FoodTrayPurple.tres"),
	preload("res://Materials/FoodTray/FoodTrayRed.tres"),
	# Add more materials as needed
]

static func getRandomMaterial() -> Material:
	return materials[randi() % materials.size()]
