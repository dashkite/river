import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

spread = curry binary do ->
  
  ( Generic.make "spread" )
  
    .define [ Function, isReactive], ( mapper, i ) ->
      for await x from i
        for await nested from mapper x
          yield nested
        
    .define [ Function, isIterable ], ( mapper, i ) ->
      Iterator
        .from i
        .flatMap mapper
        
    .define [ Function, Iterator ], ( mapper, i ) ->
      i.flatMap mapper
      
    .define [ Function, Array ], ( mapper, ax ) ->
      ax.values().flatMap mapper

export { spread }
export default spread