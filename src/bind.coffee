import { curry, binary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"

bind = curry binary do ->
  ( Generic.make "bind" ) 
    .define [ Object, Function ], ( self, f ) -> f.bind self
    .define [ Function, Object ], ( f, self ) -> f.bind self

export { bind }
export default bind