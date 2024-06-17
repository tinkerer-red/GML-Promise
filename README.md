# GML Promises v1.0.0
Asynchronous Handling for GameMaker 2022.5+

### Quick Disclaimer!
This library does not introduce true multithreading into GML but allows asynchronous operations to be handled more predictably through promises. This is similar to breaking down code to be spread across several frames rather than executing long operations directly within a step event, potentially blocking the main game loop.

If you need any assistance, feel free to raise issues directly on this GitHub repository.

This library mimics the JavaScript Promise model, making it possible to manage asynchronous operations like HTTP requests, file loading/saving, and more, directly within GameMaker Studio using a familiar promise-based approach.

## Features
- Asynchronous operations return promises that can be chained with `.then`, `.catch`, and `.finally`.
- Supports handling multiple asynchronous types like HTTP requests, file operations, and audio management.
- Promises in this library can be resolved or rejected manually, and handlers can be attached even after the promise has settled.

## API Methods
## Basic Methods

### `.Then(method)`
Attaches a fulfillment handler to the promise. This handler is called when the promise is successfully resolved. Returns a new promise that can be further chained.

### `.Catch(method)`
Attaches a rejection handler to the promise. This handler is called if the promise is rejected. Returns a new promise that resolves to the return value of the handler if it is called, or to its original fulfillment value if the promise is instead fulfilled.

### `.Finally(method)`
Attaches a handler that will be executed regardless of the promise's fulfillment or rejection. This method does not receive any argument, and it returns a new promise that resolves when the original promise is settled.

### `.Resolve(value)`
Resolves the promise with the provided value. If the value is a promise, the current promise will adopt the state of the provided promise.

### `.Reject(reason)`
Rejects the promise with the provided reason, typically an error message or an object describing the error.

## Advanced Parenting Methods

These methods are used to handle multiple promises together, providing powerful patterns for managing complex asynchronous logic.

### `.All(array_of_promises)`
Takes an array of promises and returns a new promise that resolves when all of the input promises have resolved, or rejects as soon as one of the input promises rejects. The returned promise resolves to an array of the results of the input promises.

### `.AllSettled(array_of_promises)`
Similar to `.All()`, but instead of waiting for all promises to succeed, it resolves after all the promises have settled (each may resolve or reject). Returns a promise that resolves with an array of objects, each representing the outcome of each promise, with a status of either "fulfilled" or "rejected".

### `.Any(array_of_promises)`
Takes an array of promises and returns a new promise that resolves as soon as any of the input promises resolves, with the value of the resolved promise. If all the input promises are rejected, the returned promise is rejected with an AggregateError.

### `.Race(array_of_promises)`
Returns a promise that resolves or rejects as soon as one of the promises in the input array resolves or rejects, with the value or reason from that promise.

### GML Functions
Here is a list of all the supported GML async functions which can return promises now.
```gml
audio_free_play_queue_promise(queueId)
audio_group_load_promise( groupid )
audio_start_recording_promise(recorder_num)
audio_stop_recording_promise(channel_index)
buffer_async_group_begin_promise(groupname)
buffer_async_group_end_promise()
buffer_async_group_option_promise(optionname,optionvalue)
buffer_load_async_promise(bufferid,filename,offset,size)
buffer_save_async_promise(bufferid,filename,offset,size)
get_integer_async_promise(str,def)
get_login_async_promise(username,password)
get_string_async_promise(str,def)
http_get_promise(url)
http_get_file_promise(url, dest)
http_post_string_promise(url, str)
http_request_promise(url, _method, header_map, body)
http_set_request_crossorigin_promise(crossorigin_type)
keyboard_virtual_hide_promise()
network_connect_async_promise(socket, url, port)
network_connect_raw_async_promise(socket, url, port)
show_message_async_promise(str)
show_question_async_promise(str)
sprite_add_promise(fname,imgnumb,removeback,smooth,xorg,yorig)
sprite_add_ext_promise(fname,imgnumb,xorg,yorig,prefetch)
zip_unzip_async_promise(file, destPath)
```

## Basic Usage
Here is how you can use the promise to handle an HTTP GET request:

```gml
http_get_promise("http://example.com/data.json")
  .Then(function(data) {
    show_debug_message("Data loaded: " + string(data));
  })
  .Catch(function(error) {
    show_debug_message("Failed to load data: " + string(error));
  });
```
Example with Asynchronous File Loading
```gml
// Suppose we need to load an image asynchronously
sprite_add_promise("sprite.png", 1, false, true, 32, 32)
  .Then(function(sprite_index) {
    show_debug_message("Sprite loaded with index: " + string(sprite_index));
  })
  .Catch(function(error) {
    show_debug_message("Failed to load sprite: " + string(error));
  });
```

### Advanced Usage
Handling multiple asynchronous operations with Promise.all:
```gml
var p1 = http_get_promise("http://example.com/data1.json");
var p2 = http_get_promise("http://example.com/data2.json");

Promise.all([p1, p2])
  .Then(function(results) {
    show_debug_message("Data 1: " + string(results[0]));
    show_debug_message("Data 2: " + string(results[1]));
  })
  .Catch(function(error) {
    show_debug_message("Error loading data: " + string(error));
  });
```
Handling Network Requests
```gml
network_connect_async_promise("127.0.0.1", 8080)
  .Then(function(connection) {
    show_debug_message("Connected to server!");
  })
  .Catch(function(error) {
    show_debug_message("Failed to connect: " + string(error));
  });
```
### Conclusion
This library brings the power and flexibility of JavaScript-like promises to GameMaker Studio, helping to manage asynchronous operations cleanly and effectively. For more complex scenarios, consider chaining multiple promises or handling errors at different stages of your game's logic.