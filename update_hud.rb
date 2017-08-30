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

SAVE_DIR = ARGV[1] + "Quick Save State.oesavestate"
SAVE_FILE = SAVE_DIR + "/State"
STARTING_ADDRESS = 0x1AC0
ITEMS_OFFSET = STARTING_ADDRESS + 0x340
AGA_OFFSET = STARTING_ADDRESS + 0x3C5
PENDANTS_OFFSET = STARTING_ADDRESS + 0x374
CRYSTALS_OFFSET = STARTING_ADDRESS + 0x37A

def update
  puts "Updating..."

  # `./SaveOpenEmuState.applescript`

  io = File.open(SAVE_FILE)
  read_header(io)

  name = nil
  data = nil

  while data.nil?
    name, data = read_block(io)
    data = nil if name != "SRA"
  end

  sram = StringIO.new(data)
  sram.pos = ITEMS_OFFSET

  puts "Items..."

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

  sram.pos = PENDANTS_OFFSET
  pendants = sram.read(1).ord
  items[:pendants] = ("%08b" % pendants).split("").reverse[0..2].map(&:to_i)

  sram.pos = CRYSTALS_OFFSET
  crystals = sram.read(1).ord
  items[:crystals] = ("%08b" % crystals).split("").reverse[0..6].map(&:to_i)

  sram.pos = AGA_OFFSET
  items[:aga] = sram.read(1).ord >= 3 ? 1 : 0

  # sram.rewind

  # sram.each_byte.with_index do |b, i|
  #   if b.ord == 3
  #     puts (i - STARTING_ADDRESS).to_s(16)
  #   end
  # end

  sram.close
  io.close

  File.write(
    "items-data.js",
    "var items = " + JSON.pretty_generate(items)
  )

  sleep ARGV[0].to_i
end

if ARGV[0] == "--listen"
  require "listen"
  Listen.to(SAVE_DIR) do
    update
  end.start
  sleep
else
  while true
    update
    sleep ARGV[0].to_i
  end
end

