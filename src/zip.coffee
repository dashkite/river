import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

zip = curry binary do ->
  
  ( Generic.make "zip" )
  
    .define [ isReactive, isReactive ], ( ri, rj ) ->

      # TODO use await using when available

      i = ri[ Symbol.asyncIterator ]()
      j = rj[ Symbol.asyncIterator ]()
      
      loop
        [ a, b ] = await Promise.all [ 
          i.next()
          j.next() 
        ]
        break if a.done || b.done
        yield [ a.value, b.value ]
        
    .define [ isIterable, isIterable ], ( i, j ) ->
      i = Iterator.from i
      j = Iterator.from j
      
      loop
        a = i.next()
        b = j.next()
        break if a.done || b.done
        yield [ a.value, b.value ]
          
export { zip }
export default zip