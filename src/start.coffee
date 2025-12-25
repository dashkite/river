import Generic from "@dashkite/generic"
import {
  isIterable
  isReactive
} from "./helpers"

start = do ->
  
  ( Generic.make "start" )
  
    .define [ isReactive ], ( i ) ->
      undefined for await x from i
      return
        
    .define [ isIterable ], ( i ) ->
      undefined for x from Iterator.from i
      return
      
export { start }
export default start