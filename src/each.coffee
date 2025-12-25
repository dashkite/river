import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

each = curry binary do ->
  
  ( Generic.make "each" )
  
    .define [ Function, isReactive ], ( f, i ) ->
      f.call @, x for await x from i
      undefined
        
    .define [ Function, isIterable ], ( f, i ) ->
      Iterator
        .from i
        .forEach f.bind @
        
    .define [ Function, Array ], ( f, ax ) ->
      ax.forEach f.bind @

export { each }
export default each