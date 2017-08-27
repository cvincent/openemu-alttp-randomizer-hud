require "stringio"
require "json"

def read_header(io)
  io.read(14)
end

def read_block(io)
  name = io.read(3)
  io.read(1)
  size = io.read(6).to_i
  io.read(1)
  data = io.read(size)
  return [name, data]
end

while true
  puts "Updating..."

  `./SaveOpenEmuState.applescript`

  io = File.open(ARGV[1] + "Quick Save State.oesavestate/State")
  read_header(io)

  name = nil
  data = nil

  while data.nil?
    name, data = read_block(io)
    data = nil if name != "SRA"
  end

  sram = StringIO.new(data)
  sram.pos = 0x1E00

  items = {
    bow: sram.read(1).ord,
    boomerang: sram.read(1).ord,
    hookshot: sram.read(1).ord,
    bombs: sram.read(1).ord,
    mushroom: sram.read(1).ord,
    fireRod: sram.read(1).ord,
    iceRod: sram.read(1).ord,
    bombos: sram.read(1).ord,
    ether: sram.read(1).ord,
    quake: sram.read(1).ord,
    lamp: sram.read(1).ord,
    hammer: sram.read(1).ord,
    flute: sram.read(1).ord,
    bugNet: sram.read(1).ord,
    book: sram.read(1).ord,
    hasBottles: sram.read(1).ord,
    somaria: sram.read(1).ord,
    byrna: sram.read(1).ord,
    cape: sram.read(1).ord,
    mirror: sram.read(1).ord,
    gloves: sram.read(1).ord,
    boots: sram.read(1).ord,
    flippers: sram.read(1).ord,
    moonPearl: sram.read(1).ord,
    unused: sram.read(1).ord,
    sword: sram.read(1).ord,
    shield: sram.read(1).ord,
    armor: sram.read(1).ord,
    bottle1: sram.read(1).ord,
    bottle2: sram.read(1).ord,
    bottle3: sram.read(1).ord,
    bottle4: sram.read(1).ord,
  }

  io.close

  File.write(
    "items-data.js",
    "var items = " + items.to_json
  )

  sleep ARGV[0].to_i
end
