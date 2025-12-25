import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

map = curry binary do ->
  
  ( Generic.make "map" )
  
    .define [ Function, isReactive ], ( transform, i ) ->
      yield transform.call @, x for await x from i
        
    .define [ Function, isIterable ], ( transform, i ) ->
      Iterator
        .from i
        .map transform.bind @
        
    .define [ Function, Iterator ], ( transform, i ) ->
      i.map transform.bind @
      
    .define [ Function, Array ], ( transform, ax ) ->
      ax.values().map transform.bind @

export { map }
export default map