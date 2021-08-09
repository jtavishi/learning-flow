import Artist from "../contracts/Artist.cdc"

transaction() {
  
  let pixels: String
  let picture: @Artist.Picture?
  let collection: &Artist.Collection

  prepare(account: AuthAccount) {
    let printerRef = getAccount(0x02)
      .getCapability<&Artist.Printer>(/public/ArtistPicturePrinter)
      .borrow()
      ?? panic("Couldn't borrow printer reference.")
    
    // Replace with your own drawings.
    self.pixels = "*   * * *   *   * * *   *"
    let canvas = Artist.Canvas(
      width: printerRef.width,
      height: printerRef.height,
      pixels: self.pixels
    )
    self.picture <- printerRef.print(canvas: canvas)

    let collectionRef = getAccount(0x02).getCapability<&Artist.Collection>(/public/ArtistPictureCollection)
        .borrow()
      ?? panic("Couldn't borrow printer reference.")
    self.collection = collectionRef
  }

  execute {
    if (self.picture == nil) {
      log("Picture with ".concat(self.pixels).concat(" already exists!"))
      destroy self.picture
    } else {
      log("Picture printed!")
      self.collection.deposit(picture: <- self.picture!)
    }
  }
}