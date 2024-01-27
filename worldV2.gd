extends Node2D

# Define floor dimensions
const FLOOR_SIZE = 160

# Define room sizes
const ROOM_32 = 32
const ROOM_16 = 16
const ROOM_8 = 8

# Function to generate floor layout
func generate_floor_layout():
	# Clear existing layout
	clear_layout()

	# Calculate positions for 32x32 rooms in the corners
	place_32x32_room(Vector2(0, 0))
	place_32x32_room(Vector2(FLOOR_SIZE - ROOM_32, 0))
	place_32x32_room(Vector2(0, FLOOR_SIZE - ROOM_32))
	place_32x32_room(Vector2(FLOOR_SIZE - ROOM_32, FLOOR_SIZE - ROOM_32))

	# Calculate positions for 16x16 rooms
	var x_offset = ROOM_32
	var y_offset = ROOM_32
	for i in range(4):
		place_16x16_rooms(Vector2(x_offset, y_offset))
		if i % 2 == 0:
			x_offset = FLOOR_SIZE - ROOM_32 - ROOM_16 * 4
		else:
			x_offset = ROOM_32
			y_offset += ROOM_16 * 4

	# Fill remaining space with 8x8 rooms
	place_8x8_rooms()

# Function to place 32x32 room at specified position
func place_32x32_room(position: Vector2):
	# Placeholder implementation to visualize room placement
	print("Placing 32x32 room at position:", position)

# Function to place 16x16 rooms starting from specified position
func place_16x16_rooms(position: Vector2):
	# Placeholder implementation to visualize room placement
	for x in range(4):
		for y in range(4):
			place_16x16_room(Vector2(position.x + x * ROOM_16, position.y + y * ROOM_16))

# Function to place individual 16x16 room at specified position
func place_16x16_room(position: Vector2):
	# Placeholder implementation to visualize room placement
	print("Placing 16x16 room at position:", position)

# Function to fill remaining space with 8x8 rooms
func place_8x8_rooms():
	# Placeholder implementation to visualize room placement
	remaining_space = FLOOR_SIZE - ROOM_32 * 2
	for x in range(remaining_space // ROOM_8):
		for y in range(remaining_space // ROOM_8):
			place_8x8_room(Vector2(ROOM_32 + x * ROOM_8, ROOM_32 + y * ROOM_8))

# Function to place individual 8x8 room at specified position
func place_8x8_room(position: Vector2):
	# Placeholder implementation to visualize room placement
	print("Placing 8x8 room at position:", position)

# Function to clear existing floor layout
func clear_layout():
	# Placeholder implementation to clear existing layout
	print("Clearing existing layout")

# Call the function to generate floor layout
generate_floor_layout()
