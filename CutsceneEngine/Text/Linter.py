import os
import string

# Get all the current names of portraits

portraits = []

for filename in os.listdir("C:/Users/Matthew/Documents/SpaceshipProject2/SpaceshipProject/Portraits"):
	if filename.endswith(".png"):
		portraits.append(filename[:-4])

f = open("Episode1.txt", "r")

lines = f.readlines()

errors = 0

for i in range(0, len(lines)):
	line = lines[i]
	portrait = ""

	# If any line has a : but is missing either a '<' or a '>', flag it
	if ":" in line and (("<" not in line) or (">" not in line)):
		print("Line " + str(i) + " is missing a '<' or a '>':")
		print(line + "\n")
		errors += 1

	# If any portrait described in a line doesn't exist on file, flag it
	if "<" in line and ">" in line:
		start = line.index("<")
		end = line.index(">")

		portrait = line[(start+1):end]

		if portrait not in portraits:
			print("Line " + str(i) + " has an invalid portrait:")
			print(line + "\n")
			errors += 1

print("Found " + str(errors) + " errors.")
print("Linting complete!")

f.close()