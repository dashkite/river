import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

spread = curry binary do ->
  
  ( Generic.make "spread" )
  
    .define [ Function, isReactive], ( transform, i ) ->
      for await x from i
        for await nested from transform.call @, x
          yield nested
        
    .define [ Function, isIterable ], ( transform, i ) ->
      Iterator
        .from i
        .flatMap transform.bind @
        
    .define [ Function, Iterator ], ( transform, i ) ->
      i.flatMap transform.bind @
      
    .define [ Function, Array ], ( transform, ax ) ->
      ax.values().flatMap transform.bind @

export { spread }
export default spread