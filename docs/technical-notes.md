# Technical Notes

### Reactive Programming

DashKite River draws conceptual lineage from [Reactive Programming](https://en.wikipedia.org/wiki/Reactive_programming). While River does not implement a full observable paradigm, it models asynchronous data streams and their transformations. Creators can compose these streams in a functional manner to respond dynamically to incoming data over time.

### JavaScript Iterators

JavaScript provides native [Iterators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Iterator) and Asynchronous Iterators (reactors) as language-level constructs for representing sequences of data. While less commonly utilized in typical application code compared to arrays, iterators offer powerful capabilities for processing potentially infinite or lazily-evaluated data structures. River builds upon these standard interfaces, providing a unified functional toolkit to manipulate them.

### Iterator Helpers

The JavaScript ecosystem is standardizing native iterator manipulations via the upcoming [Iterator Helpers API](https://web.dev/blog/baseline-iterator-helpers). River anticipates this pattern by offering a superset of these capabilities as curried, composable functions. As the native Iterator Helpers enter general availability across platforms, we plan to transition River's internal implementation to utilize those native interfaces directly, continuing to build our functional API on top of them. River ensures these helpers function symmetrically across both synchronous iterators and asynchronous reactors.

### Joy Queue Affordance

River relies on the queue affordances provided by the DashKite Joy library to implement its generalizing iterator structure. This underlying mechanism handles the buffering and synchronization required to coordinate complex stream splits, such as those performed by `tee` or `partition`.

### IteratorQueue

A synchronous FIFO queue that can be consumed as an iterator.

### ReactorQueue

An asynchronous FIFO queue that can be consumed as a reactor.

### BufferedIterator

Composes a buffer and an iterator, allowing for shared iterators that push values into a buffer until they are ready to be consumed.

### BufferedReactor

Composes a buffer and a reactor, allowing for shared reactors that push values into a buffer until they are ready to be consumed.
