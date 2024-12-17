require 'betterprint'.settings.mode = 'simple'

local String = "Hello, World!"
print(String) --> usage.lua:4: Hello, World!

local Animal_IDS = { ["dog"] = 0, ["cat"] = 1, ["squirrel"] = 2 }
print(Animal_IDS) --> usage.lua:7: {dog = 0, cat = 1, squirrel = 2}
