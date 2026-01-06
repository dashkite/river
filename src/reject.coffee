import { curry } from "@dashkite/joy/function"
import { negate } from "@dashkite/joy/predicate"
import select from "./select"

reject = curry ( predicate, i ) ->
  select.call @, ( negate predicate ), i

export { reject }
export default reject