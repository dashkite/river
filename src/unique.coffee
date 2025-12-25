import { identity } from "@dashkite/joy/function"
import uniquely from "./uniquely"

unique = ( i ) -> uniquely identity, i

export { unique }
export default unique