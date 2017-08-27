var sprites = [
  ["bow", 1],
  ["boomerang", 1],
  ["hookshot", 1],
  ["bombs", 1],
  ["mushroom", 1],
  ["fireRod", 1],
  ["iceRod", 1],
  ["bombos", 1],
  ["ether", 1],
  ["quake", 1],
  ["lamp", 1],
  ["hammer", 1],
  ["flute", 1],
  ["bugNet", 1],
  ["book", 1],
  ["somaria", 1],
  ["byrna", 1],
  ["cape", 1],
  ["mirror", 2],
  ["gloves", 1],
  ["boots", 1],
  ["flippers", 1],
  ["moonPearl", 1],
  ["sword", 1],
  ["shield", 1],
  ["armor", 0],
  ["bottle", 1],
  ["bottle2", 1],
  ["bottle3", 1],
  ["bottle4", 1],
  ["green_med", 1],
  ["blue_med", 1],
  ["red_med", 1],
  ["crystal_1", 1],
  ["crystal_2", 1],
  ["crystal_3", 1],
  ["crystal_4", 1],
  ["crystal_5", 1],
  ["crystal_6", 1],
  ["crystal_7", 1],
  ["boomerang", 2],
  ["sword", 2],
  ["sword", 3],
  ["sword", 4],
  ["armor", 1],
  ["armor", 2],
  ["gloves", 2],
  ["shield", 2],
  ["shield", 3],
  ["mushroom", 2],
  ["flute", 2],
  ["bow", 2],
  ["bow", 3],
  ["bottle", 3],
  ["bottle", 4],
  ["bottle", 5],
  ["bottle", 6],
  ["bottle", 7]
]

var update = function() {
  // console.log("reloading items: " + new Date().getTime())
  document.getElementById("hud-data").remove()

  var script = document.createElement("script")
  script.id = "hud-data"
  script.type = "text/javascript"
  script.src = "items-data.js?" + new Date().getTime()
  document.head.appendChild(script)

  var itemDivs = document.getElementsByClassName("item")

  for(var i = 0; i < itemDivs.length; i++) {
    var div = itemDivs.item(i)
    var firstSpriteIndex = null
    var spriteIndex = null
    var itemName = div.id

    if (itemName.indexOf("bottle") > -1) itemName = "bottle"

    for (var j = 0; j < sprites.length; j++) {
      if (sprites[j][0] == itemName && sprites[j][1] <= items[div.id]) {
        spriteIndex = j
      } else if (sprites[j][0] == itemName && firstSpriteIndex == null) {
        firstSpriteIndex = j
      }
    }

    if (spriteIndex == null) {
      div.style.backgroundPositionX = (firstSpriteIndex * -16) + "px"
      div.style.opacity = 0.5
    } else {
      div.style.backgroundPositionX = (spriteIndex * -16) + "px"
      div.style.opacity = 1
    }
  }
}

update()
setInterval(update, 1000)
