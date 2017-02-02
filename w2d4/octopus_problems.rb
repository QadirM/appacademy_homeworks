fish = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
def sluggish_octopus(fish)
  sorted = false

  until sorted
    sorted = true
    i = 0
    while i < (fish.length - 1)
      j = i + 1
      while j < fish.length
        if fish[i].length >  fish[j].length
          sorted = false
          fish[i], fish[j] = fish[j], fish[i]
        end
        j += 1
      end
      i += 1
    end
  end
  fish
end

def dominant_octopus(fish)
  return fish if fish.length <= 1

  pivot = fish[0]

  left = fish[1..-1].select{ |fish| fish.length < pivot.length}
  right = fish[1..-1].select{ |fish| fish.length >= pivot.length}

  dominant_octopus(left) + [pivot] + dominant_octopus(right)
end

def clever_octopus(fish)
  max = fish[0]
  fish[1..-1].each do |f|
    if f.length > max.length
      max = f
    end
  end
  max
end


p sluggish_octopus(fish).last
p dominant_octopus(fish).last
p clever_octopus(fish)


tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

def slow_dance(direction, tiles_array)
  tiles_array.each_with_index do |tile, index|
    return index if tile == direction
  end
end


tiles_hash = {
    "up" => 0,
    "right-up" => 1,
    "right"=> 2,
    "right-down" => 3,
    "down" => 4,
    "left-down" => 5,
    "left" => 6,
    "left-up" => 7
}

def fast_dance(direction, tiles_hash)
  tiles_hash[direction]
end

p slow_dance("up", tiles_array)
p slow_dance("right-down", tiles_array)

p fast_dance("up", tiles_hash)
p fast_dance("right-down", tiles_hash)
