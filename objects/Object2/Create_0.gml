#region Promise
	
	//Promise
	new Promise(function(_value){
		show_debug_message("Promise Working correctly\n")
	},
	function(_error){
		show_debug_message("Promise Failed with error :: "+_error)
	})
	
	Promise.Then(function(_value){
		show_debug_message("Promise.Then Working correctly\n")
	})
	
	Promise.Resolve("Resolving")
	.Finally(function(_value){
		show_debug_message("Promise.Resolve Working correctly\n")
	})
	
	//Promise with then
	Promise.Reject("Rejection intentional")
	.Catch(function(_reason){
		show_debug_message("Promise.Reject Working correctly\n")
	})
	
	//Promise with finally
	Promise.Resolve(10)
	.Finally(function(_value){
		show_debug_message(_value);
		show_debug_message("Promise.Finally Working correctly\n")
	})
	.Catch(function(_reason) {
		show_debug_message("Promise.Then :: FAILED\n");
	})
	
	//Promise with catch
	Promise.Then(function(_value){
		throw "intentionally throwing error to test .catch"
	})
	.Finally(function(_value) {
		show_debug_message("Promise.Then :: FAILED\n");
	})
	.Catch(function(_reason){
		show_debug_message("Promise failed with reason: " + _reason);
		show_debug_message("Promise.Catch Working correctly\n")
	})
	
#endregion

#region Promise.All
	
	//success
	var p1 = Promise.Resolve(1);
	var p2 = Promise.Resolve(2);
	
	Promise.All([p1, p2])
	.Then(function(_value) {
		show_debug_message("All Promises resolved with values: " + string(_value));
		show_debug_message("Promise.All.Then Working correctly\n");
	})
	.Finally(function(_value) {
		show_debug_message("All Promises resolved with values: " + string(_value));
		show_debug_message("Promise.All.Finally Working correctly\n")
	})
	.Catch(function(_reason) {
		show_debug_message("Promise.All failed with reason: " + _reason);
		show_debug_message("Promise.All.Finally :: FAILED\n");
	});
	
	//failure
	var p1 = Promise.Resolve(3);
	var p2 = Promise.Reject("error!");
	
	Promise.All([p1, p2])
	.Then(function(_values) {
		show_debug_message("All Promises resolved with values: " + string(_values));
	})
	.Finally(function(_value) {
		show_debug_message("Promise.All.Catch :: FAILED\n");
	})
	.Catch(function(_reason) {
		show_debug_message("Promise.All failed with reason: " + _reason);
		show_debug_message("Promise.All.Catch Working correctly\n")
	});
	
#endregion

#region Promise.AllSettled
	
	var p1 = Promise.Resolve(10);
	var p2 = Promise.Reject("error");
	
	Promise.AllSettled([p1, p2])
	.Then(function(_results) {
		show_debug_message("All Promises settled with results: " + string(_results));
		show_debug_message("Promise.AllSettled.Then Working correctly\n");
	})
	.Finally(function(_results) {
		show_debug_message("All Promises settled with results: " + string(_results));
		show_debug_message("Promise.AllSettled.Finally Working correctly\n")
	})
	.Catch(function(_reason) {
		show_debug_message("Promise.AllSettled.Finally :: FAILED\n");
	});
	
	//Expected Output: "All Promises settled with results: [{status: 'fulfilled', value: 10}, {status: 'rejected', reason: 'error'}]"
	
	/// 
	/// NOTE: it is not possible to reach a catch statement when using Promise.AllSettled
	/// 
	
	
#endregion

#region Promise.Any
	
	//resolve
	var p1 = Promise.Reject("error1");
	var p2 = Promise.Resolve(20);
	
	Promise.Any([p1, p2])
	.Then(function(_value) {
		show_debug_message("At least one Promise resolved with value: " + string(_value));
		show_debug_message("Promise.Any.Then Working correctly\n");
	})
	.Finally(function(_value) {
		show_debug_message("At least one Promise resolved with value: " + string(_value));
		show_debug_message("Promise.Any.Finally Working correctly\n");
	})
	.Catch(function(_reason) {
		show_debug_message("Promise.Any.Finally :: FAILED\n");
	});
	
	//reject
	var p1 = Promise.Reject("error1");
	var p2 = Promise.Reject("error2");
	
	Promise.Any([p1, p2])
	.Then(function(_value) {
		show_debug_message("At least one Promise resolved with value: " + string(_value));
	})
	.Finally(function(_value) {
		show_debug_message("Promise.Any.Catch :: FAILED\n");
	})
	.Catch(function(_reason) {
		show_debug_message("All Promises failed: " + _reason);
		show_debug_message("Promise.Any.Catch Working correctly\n")
	});
	
#endregion

#region Promise.Race
	
	//resolve
	var p1 = Promise.Resolve(10);
	var p2 = Promise.Reject("error");
	
	Promise.Race([p1, p2])
	.Then(function(value) {
		show_debug_message("First resolved Promise value: " + string(value));
		show_debug_message("Promise.Race.Then Working correctly\n")
	})
	.Finally(function(value) {
		show_debug_message("First resolved Promise value: " + string(value));
		show_debug_message("Promise.Race.Finally Working correctly\n")
	})
	
	//reject
	var p1 = Promise.Reject("error");
	var p2 = Promise.Resolve(20);
	
	Promise.Race([p1, p2])
	.Then(function(value) {
		show_debug_message("First resolved Promise value: " + string(value));
	})
	.Catch(function(reason) {
		show_debug_message("First settled Promise was rejected: " + reason);
		show_debug_message("Promise.Race.Catch Working correctly\n")
	});
	
#endregion

#region Async Events
http_get_promise("https://github.com/tinkerer-red")
.Then(function(_async_load){
	show_debug_message("URL :: "+string(_async_load.url))
})
.Then(function(_async_load){
	show_debug_message("Http Status :: "+string(_async_load.http_status))
})
.Catch(function(_error){
	show_debug_message(_error)
})
#endregion
