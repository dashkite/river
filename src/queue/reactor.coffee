class ReactorQueue

  @make: -> new @

  constructor: ->
    @buffer = []
    @resolvers = []
    @closed = false

  enqueue: ( value ) ->
    if !@closed
      if @resolvers.length > 0
        @resolvers
          .shift()
          .resolve
          .call null, value
      else
        @buffer.push value
    @

  dequeue: ->
    if @buffer.length > 0
      Promise.resolve @buffer.shift()
    else if !@closed
      { promise, resolve, reject } = Promise.withResolvers()
      @resolvers.push { resolve, reject }
      promise
    else Promise.resolve undefined
      
  close: -> 
    @closed = true
    error = new Error "queue closed with pending items"
    ( reject error ) for { reject } in @resolvers
    @resolvers = []
    @

  [ Symbol.asyncIterator ]: -> @

  next: ->
    if !@closed || ( @buffer.length > 0 )
      pending = @dequeue()
      pending.then ( value ) -> { value, done: false }
    else Promise.resolve done: true
    
export { ReactorQueue }
export default ReactorQueue

