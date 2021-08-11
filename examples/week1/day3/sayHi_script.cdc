import Hello from "./hello.cdc"

pub fun main(name: String): String {
  return Hello.sayHi(to: name)
}