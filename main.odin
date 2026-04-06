package rat
import "core:fmt"
import "vendor:raylib"

main :: proc() {
	// init
	world := create_world()

	if (load_sprite_manifest(&world.sprite_lib, "assets/sprites.json")) {
		fmt.println("Loaded sprite metadata.")
	}

	// create here
	create_object(
		&world,
		transform_t{position = {256, 256}, scale = {4, 4}, rotation = 0},
		ImageParams{sprite_name = "rat", image_index = 0, image_speed = 0.1},
		raylib.Vector2{32, 32},
	)
	// end creation

	raylib.InitWindow(512, 512, "Hi!")
	raylib.SetTargetFPS(60)
	defer raylib.CloseWindow()

	for !raylib.WindowShouldClose() {

		update_grid(&world)

		raylib.BeginDrawing()
		raylib.ClearBackground(raylib.RAYWHITE)

		render_system(&world)

		raylib.EndDrawing()
	}
}
