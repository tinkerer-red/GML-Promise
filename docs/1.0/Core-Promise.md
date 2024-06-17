# Core Promise

## `Promise()` → *Struct.Promise*
The Promise() constructor creates Promise objects. It is primarily used to wrap callback-based APIs that do not already support promises.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Function} callback : A function to asynchronously execute when this promise becomes settled. Its return value is ignored unless the returned value is a rejected promise. |
|`` | |{Function} errback : A function to asynchronously execute when this promise becomes rejected. Its return value becomes the fulfillment value of the promise returned by catch(). |

## `Then()` → *Struct.Promise*
The Then() method of Promise instances takes a callback function for the fulfilled case of the Promise. It immediately returns another Promise object, allowing you to chain calls to other promise methods.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Function} callback : A function to asynchronously execute when this promise becomes fulfilled. Its return value becomes the fulfillment value of the promise returned by then(). |

## `Catch()` → *Struct.Promise*
The Catch() method of Promise instances schedules a function to be called when the promise is rejected. It immediately returns another Promise object, allowing you to chain calls to other promise methods.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Function} errback : A function to asynchronously execute when this promise becomes rejected. Its return value becomes the fulfillment value of the promise returned by catch(). |

## `Finally()` → *Struct.Promise*
The Finally() method of Promise instances schedules a function to be called when the promise is settled (either fulfilled or rejected). It immediately returns another Promise object, allowing you to chain calls to other promise methods.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Function} callback : A function to asynchronously execute when this promise becomes settled. Its return value is ignored unless the returned value is a rejected promise. |

## `Resolve()` → *Struct.Promise*
The Promise.Resolve() static method "resolves" a given value to a Promise. If the value is a promise, that promise is returned; if the value is a thenable, Promise.Resolve() will call the then() method with two callbacks it prepared; otherwise the returned promise will be fulfilled with the value.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Any} value : Argument to be resolved by this Promise. Can also be a Promise or a thenable to resolve. |

## `Reject()` → *Struct.Promise*
The Promise.reject() static method returns a Promise object that is rejected with a given reason.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Any} reason : Reason why this Promise rejected. |

## `All()` → *Struct.Promise*
The Promise.All() static method takes an iterable of promises as input and returns a single Promise. This returned promise fulfills when all of the input's promises fulfill (including when an empty iterable is passed), with an array of the fulfillment values. It rejects when any of the input's promises rejects, with this first rejection reason.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Array<Struct.Promise>} arr_of_promises : Array of Promises to be used as children |

## `AllSettled()` → *Struct.Promise*
The Promise.AllSettled() static method takes an iterable of promises as input and returns a single Promise. This returned promise fulfills when all of the input's promises settle (including when an empty iterable is passed), with an array of objects that describe the outcome of each promise.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Array<Struct.Promise>} arr_of_promises : Array of Promises to be used as children |

## `Any()` → *Struct.Promise*
The Promise.any() static method takes an iterable of promises as input and returns a single Promise. This returned promise fulfills when any of the input's promises fulfills, with this first fulfillment value. It rejects when all of the input's promises reject (including when an empty iterable is passed), with an AggregateError containing an array of rejection reasons.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Array<Struct.Promise>} arr_of_promises : Array of Promises to be used as children |

## `Race()` → *Struct.Promise*
The Promise.Race() static method takes an iterable of promises as input and returns a single Promise. This returned promise settles with the eventual state of the first promise that settles.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Array<Struct.Promise>} arr_of_promises : Array of Promises to be used as children |
