pub struct Canvas {

  pub let width: Int
  pub let height: Int
  pub let pixels: [String]

  init(width: Int, height: Int, pixels: [String]) {
    self.width = width
    self.height = height
    self.pixels = pixels
  }
}


pub fun display(canvas: Canvas){
    var frameBoundary = "+"
    var i = 0
    while i < canvas.width{
        frameBoundary = frameBoundary.concat("-")
        i=i+1
    }
    frameBoundary = frameBoundary.concat("+")
    log(frameBoundary)
    for element in canvas.pixels{
        var elementsRow = "|"
        elementsRow = elementsRow.concat(element)
        elementsRow = elementsRow.concat("|")
        log(elementsRow)
    }
    log(frameBoundary)
}

pub fun main() {
  let pixelsX = [
    "*   *",
    " * * ",
    "  *  ",
    " * * ",
    "*   *"
  ]
//   let pixelsX = [
//     "*   ",
//     " * *"
//   ]
  let canvasX = Canvas(
    width: pixelsX[0].length,
    height: pixelsX.length,
    pixels: pixelsX
  )
  display(canvas: canvasX)
}

