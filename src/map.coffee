import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

map = curry binary do ->
  
  ( Generic.make "map" )
  
    .define [ Function, isReactive ], ( mapper, i ) ->
      yield mapper x for await x from i
        
    .define [ Function, isIterable ], ( mapper, i ) ->
      Iterator
        .from i
        .map mapper
        
    .define [ Function, Iterator ], ( mapper, i ) ->
      i.map mapper
      
    .define [ Function, Array ], ( mapper, ax ) ->
      ax.values().map mapper

export { map }
export default map