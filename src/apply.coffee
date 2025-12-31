import { curry, ternary } from "@dashkite/joy/function"
import Generic from "@dashkite/generic"

apply = curry ternary do ->
  ( Generic.make "apply" ) 
    .define [ Object, Array, Function ], ( self, args, f ) -> f.apply self, args
    .define [ Function, Object, Array ], ( f, self, args ) -> f.apply self, args

export { apply }
export default apply