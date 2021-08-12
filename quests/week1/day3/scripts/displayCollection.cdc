import Artist from "../contracts/Artist.cdc"

pub fun display(canvas: Artist.Canvas){
    var frameBoundary = "+"
    var i:UInt8 = 0
    while i < canvas.width{
        frameBoundary = frameBoundary.concat("-")
        i=i+1
    }
    frameBoundary = frameBoundary.concat("+")
    log(frameBoundary)
    var j = 0
    while j < Int(canvas.height){
        var elementsRow = "|"
        var line = canvas.pixels.slice(from: j * Int(canvas.width), upTo: j * Int(canvas.width) + Int(canvas.width))
        elementsRow = elementsRow.concat(line)
        elementsRow = elementsRow.concat("|")
        log(elementsRow)
        j = j + 1  
    }
    log(frameBoundary)
}

// Return an array of formatted Pictures that exist in the account with the a specific address.
// Return nil if that account doesn't have a Picture Collection.
pub fun main(address: Address): [String]? {

	let account = getAccount(address)
  let collectionCap = account.getCapability<&Artist.Collection>(/public/ArtistPictureCollection)

	if collectionCap.check() == false {
		return nil
	}
  let collection = collectionCap.borrow()

  let count = collection!.picCount
  var id:UInt64 = 0

	var results:[String] = []
  for canvas in collection!.getCanvases(){
            display(canvas: canvas)
            results.append(canvas.pixels)
        }

	return results
}