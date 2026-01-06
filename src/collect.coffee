import Generic from "@dashkite/generic"
import { unary } from "@dashkite/joy/function"
import {
  isIterable
  isReactive
} from "@dashkite/joy/type"

collect = unary do ->
  
  ( Generic.make "collect" )
  
    .define [ isReactive ], ( i ) -> x for await x from i
        
    .define [ isIterable ], ( i ) -> Array.from i
        
    .define [ Array ], ( array ) -> array

export { collect }
export default collect