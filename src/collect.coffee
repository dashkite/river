import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

collect = do ->
  
  ( Generic.make "collect" )
  
    .define [ isReactive ], ( i ) -> x for await x from i
        
    .define [ isIterable ], ( i ) -> Array.from i
        
    .define [ Array ], ( array ) -> array

export { collect }
export default collect