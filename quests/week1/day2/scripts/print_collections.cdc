import Artist from "../contracts/Artist.cdc"

pub fun main(){
    let addresses:[Address] = [0x01,0x02,0x03,0x04,0x05]
    for address in addresses{
        log("Calling print function for ".concat(address.toString()))
        printCollection(address)
    }
}

pub fun printCollection(_ address: Address){
    let collectionRef = getAccount(address).getCapability(/public/ArtistPictureCollection).borrow<&Artist.Collection>()
    if collectionRef == nil {
        log("Collection is not there in ".concat(address.toString()))
    }
    else {
        log("Printing content for ".concat(address.toString()))
        log(collectionRef!.getCanvases())
        log(collectionRef!.currentPictureCount)
        for canvas in collectionRef!.getCanvases(){
            display(canvas: canvas)
        }
    }
}

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