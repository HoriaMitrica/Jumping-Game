extends GDScript

const materials = [
	preload("res://Characters/Extras/TrayMaterials/FoodTray/FoodTrayBlue.tres"),
	preload("res://Characters/Extras/TrayMaterials/FoodTray/FoodTrayGreen.tres"),
	preload("res://Characters/Extras/TrayMaterials/FoodTray/FoodTrayOrange.tres"),
	preload("res://Characters/Extras/TrayMaterials/FoodTray/FoodTrayPurple.tres"),
	preload("res://Characters/Extras/TrayMaterials/FoodTray/FoodTrayRed.tres"),
	# Add more materials as needed
]

static func getRandomMaterial() -> Material:
	return materials[randi() % materials.size()]
