return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.2.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 10,
  height = 10,
  tilewidth = 8,
  tileheight = 8,
  nextlayerid = 2,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "test",
      firstgid = 1,
      filename = "test.tsx",
      tilewidth = 8,
      tileheight = 8,
      spacing = 0,
      margin = 0,
      columns = 10,
      image = "test.png",
      imagewidth = 80,
      imageheight = 8,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 8,
        height = 8
      },
      properties = {},
      terrains = {},
      tilecount = 10,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 1,
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        3, 3, 3, 3, 9, 9, 9, 3, 3, 3,
        2, 3, 10, 10, 10, 8, 5, 10, 7, 9,
        3, 3, 6, 10, 10, 10, 10, 10, 10, 8,
        3, 3, 7, 10, 10, 5, 10, 10, 10, 9,
        3, 3, 9, 9, 3, 4, 9, 6, 10, 3,
        3, 4, 3, 2, 3, 3, 8, 10, 5, 3,
        3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
        3, 3, 3, 3, 8, 3, 2, 3, 4, 3,
        7, 3, 3, 2, 9, 9, 3, 3, 3, 3,
        3, 3, 3, 3, 3, 9, 9, 9, 3, 3
      }
    }
  }
}
