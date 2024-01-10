extends GDScript

enum Anim_Prefix {
	Normal,
	Flip,
	Spin,
	Max_Animation
}
static func getRandomAnimationPrefix() -> String:
	return str(Anim_Prefix.find_key(randi_range(0,int(Anim_Prefix.Max_Animation-1))))+"Jump"
