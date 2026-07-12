# Recipes

## Fetching and parsing JSON streams

This guide demonstrates fetching and parsing JSON data from a sequence of URLs. River enables this by allowing creators to compose functional pipelines of standard iterator and reactor transformations.

```coffeescript
import { pipe } from "@dashkite/joy/function"
import {
  collect
  map
  resolve
} from "@dashkite/river"

# external complexity
# json = ( response ) -> response.json()

get = pipe [
  map fetch
  resolve
  map json
  resolve
  collect
]

values = await get [ "https://httpbin.org/json" ]
```

### Algorithm

1. The creator maps the `fetch` function over the incoming URLs, creating an iterator of promises.
2. The `resolve` function awaits each promise, converting the iterator into a reactor yielding `Response` objects.
3. The `map` function applies the `json` parsing function to each response, producing a reactor of promises.
4. The `resolve` function awaits the parsed JSON data, yielding a reactor of values.
5. The `collect` function consumes the reactor and gathers all final values into an array.

## Partitioning and categorizing event streams

This guide demonstrates routing a stream of incoming events into two separate streams based on a condition, processing them independently, and grouping the critical events by their source. River enables this by providing stream-splitting tools like `partition` and aggregation tools like `group`.

### Composed pipeline

We recommend leaning on compositional strategies. Here is how the creator can define the processing pipelines using `pipe`. Because River functions are curried, they can be composed into higher-order functions like `processCritical`.

```coffeescript
import { pipe } from "@dashkite/joy/function"
import {
  partition
  group
  collect
} from "@dashkite/river"

# external complexity
# isCritical = ( event ) -> event.priority > 5
# getSource = ( event ) -> event.sourceId

processCritical = group getSource
processStandard = collect

processEvents = pipe [
  partition isCritical
  ( [ criticalStream, standardStream ] ) ->
    criticalGroups: processCritical criticalStream
    standardList: processStandard standardStream
]

# execute the pipeline
# results = processEvents events
```

### Imperative flow

The creator can also write this imperatively, which may be useful when debugging complex branching logic.

```coffeescript
processEventsImperative = ( events ) ->
  [ criticalStream, standardStream ] = partition isCritical, events
  
  criticalGroups = group getSource, criticalStream
  standardList = collect standardStream

  { criticalGroups, standardList }
```

### Algorithm

1. The creator partitions the incoming stream of events into `criticalStream` and `standardStream` using the `isCritical` predicate.
2. The `group` function consumes the `criticalStream` and categorizes the events by their source into a Map.
3. The `collect` function consumes the `standardStream` and gathers the non-critical events into an array.
4. The creator returns an object containing both the grouped critical events and the array of standard events.

## Interleaving multiple asynchronous sources

This guide demonstrates combining two separate data streams into a single interleaved stream. River enables this through the `merge` function, which accepts two iterators or reactors and produces a single stream.

### Composed pipeline

By using `pipe`, the creator can construct a linear sequence of transformations to process the merged stream.

```coffeescript
import { pipe } from "@dashkite/joy/function"
import {
  merge
  take
  collect
  map
} from "@dashkite/river"

# external complexity
# getSensorA = -> ... returns reactor of sensor readings
# getSensorB = -> ... returns reactor of sensor readings
# formatReading = ( reading ) -> ... formats the reading

monitorSensors = ( sourceA, sourceB ) ->
  process = pipe [
    map formatReading
    take 100
    collect
  ]
  
  process merge sourceA, sourceB
```

### Imperative flow

The creator can also write this out step-by-step to expose intermediate states.

```coffeescript
monitorSensorsImperative = ->
  combinedStream = merge getSensorA(), getSensorB()
  formattedStream = map formatReading, combinedStream
  limitedStream = take 100, formattedStream
  
  collect limitedStream
```

### Algorithm

1. The creator merges the reactors from two different sensors into a single `combinedStream`.
2. The `map` function applies a formatting transformation to every reading yielded by the merged stream.
3. The `take` function restricts the flow, creating a stream that yields only the first 100 formatted readings.
4. The `collect` function consumes the limited stream and returns an array of the final readings.
