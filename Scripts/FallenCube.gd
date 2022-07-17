extends MeshInstance
class_name FallenCube

func setup_from(cube : Cube):
	self.global_transform = cube.global_transform
