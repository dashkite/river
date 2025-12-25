import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

each = curry binary do ->
  
  ( Generic.make "each" )
  
    .define [ Function, isReactive ], ( f, i ) ->
      f x for await x from i
      undefined
        
    .define [ Function, isIterable ], ( f, i ) ->
      Iterator
        .from i
        .forEach f
        
    .define [ Function, Array ], ( f, ax ) ->
      ax.forEach f

export { each }
export default each