#macro PROMISE_MAX_TIME (1/60 * 1_000 * 1_000) * (1/16) //the max time in milli seconds to spend on the promises, default is 1/16 of frame time of a 60 fps game

enum PROMISE_STATE {
	PENDING,
	RESOLVED,
	REJECTED,
	PAUSED,
};

function Promise(_resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message("Promise Failed with error : "+_reason) }) constructor {
	
	// State and value of the promise
	executors = [];
	state = PROMISE_STATE.PENDING;
	value = undefined;
	reason = undefined;
	on_resolved = _resolve_callback;
	on_rejected = _reject_callback;
	
	static Then = function(_executor) {
		var _this_promise = (is_instanceof(self, Promise)) ? self : new Promise();
		
		array_push(_this_promise.executors, _executor);
		
		return _this_promise;
	};
	static Catch = function(_rejected_callback) {
		var _this_promise = (is_instanceof(self, Promise)) ? self : new Promise();
		
		_this_promise.on_rejected = _rejected_callback;
		
		return _this_promise;
	};
	static Finally = function(_resolved_callback) {
		var _this_promise = (is_instanceof(self, Promise)) ? self : new Promise();
		
		_this_promise.on_resolved = _resolved_callback;
		
		return _this_promise;
	};
	
	static Resolve = function(_value) {
		var _this_promise = (is_instanceof(self, Promise)) ? self : new Promise();
		
		_this_promise.state = PROMISE_STATE.PENDING;
		_this_promise.value = _value;
			
		return _this_promise;
	};
	static Reject = function(_reason) {
		var _this_promise = (is_instanceof(self, Promise)) ? self : new Promise();
		
		_this_promise.state = PROMISE_STATE.REJECTED;
		_this_promise.reason = _reason;
		
		return _this_promise;
	};
	
	#region Promise Parenting
	
	static All = function(_arr_of_promises) {
		var _parent_promise = new Promise();
		
		_parent_promise.state = PROMISE_STATE.PAUSED;
		_parent_promise.sub_promises = _arr_of_promises;
		_parent_promise.resolved_count = 0;
		_parent_promise.value = [];
		
		var _i=0; repeat(array_length(_arr_of_promises)) {
			var _promise = _arr_of_promises[_i];
			_promise.parent = _parent_promise;
			_promise.index_in_parent = _i;
			
			_promise.Then(method(_promise, function(_value){
				parent.value[index_in_parent] = _value;
				parent.resolved_count += 1;
					
				if (parent.resolved_count == array_length(parent.sub_promises)) {
					parent.state = PROMISE_STATE.PENDING;
				}
					
				return _value;
			}))
			.Catch(method(_parent_promise, function(_reason) {
				if (state != PROMISE_STATE.REJECTED) {
					state = PROMISE_STATE.REJECTED;
					reason = _reason;
				}
			}));
			
		_i+=1;}//end repeat loop
		
		return _parent_promise;
	};
	
	//wait for all to finish, then get reports
	static AllSettled = function(_arr_of_promises) {
		var _parent_promise = new Promise();
		
		_parent_promise.state = PROMISE_STATE.PAUSED;
		_parent_promise.sub_promises = _arr_of_promises;
		_parent_promise.resolved_count = 0;
		_parent_promise.value = [];
		
		var _i=0; repeat(array_length(_arr_of_promises)) {
			var _promise = _arr_of_promises[_i];
			_promise.parent = _parent_promise;
			_promise.index_in_parent = _i;
			
			_promise.Then(method(_promise, function(_value){
				parent.value[index_in_parent] = { status: "RESOLVED", value: _value };
				parent.resolved_count += 1;
					
				if (parent.resolved_count == array_length(parent.sub_promises)) {
					parent.state = PROMISE_STATE.PENDING;
				}
					
				return _value;
			}))
			.Catch(method(_promise, function(_reason) {
				var _error = (is_struct(_reason)) ? _reason.message : _reason;
				parent.value[index_in_parent] = { status: "rejected", reason: _error };
				parent.resolved_count += 1;
				
				if (parent.resolved_count == array_length(parent.sub_promises)) {
					parent.state = PROMISE_STATE.PENDING;
				}
			}));
			
		_i+=1;}//end repeat loop
		
		return _parent_promise;
	};
	
	//if any succeed
	static Any = function(_arr_of_promises) {
		var _parent_promise = new Promise();
		
		_parent_promise.state = PROMISE_STATE.PAUSED;
		_parent_promise.sub_promises = _arr_of_promises;
		_parent_promise.resolved_count = 0;
		_parent_promise.value = [];
		
		var _i=0; repeat(array_length(_arr_of_promises)) {
			var _promise = _arr_of_promises[_i];
			_promise.parent = _parent_promise;
			_promise.index_in_parent = _i;
			
			_promise.Then(method(_parent_promise, function(_value) {
				state = PROMISE_STATE.PENDING;
				value = _value;
				
				return _value;
			}))
			.Catch(method(_parent_promise, function(_reason){
				resolved_count += 1;
				if (resolved_count == array_length(sub_promises)) {
					state = PROMISE_STATE.REJECTED;
					reason = _reason;
				}
			}));
			
		_i+=1;}//end repeat loop
		
		return _parent_promise;
	};
	
	//first come first server
	static Race = function(_arr_of_promises) {
		var _parent_promise = new Promise();
		
		_parent_promise.state = PROMISE_STATE.PAUSED;
		_parent_promise.sub_promises = _arr_of_promises;
		_parent_promise.resolved_count = 0;
		_parent_promise.value = [];
		
		var _i=0; repeat(array_length(_arr_of_promises)) {
			var _promise = _arr_of_promises[_i];
			_promise.parent = _parent_promise;
			_promise.index_in_parent = _i;
			
			_promise.Then(method(_parent_promise, function(_value) {
				if (state == PROMISE_STATE.PAUSED) {
					state = PROMISE_STATE.RESOLVED;
					value = _value;
				}
				
				return _value;
			}))
			.Catch(method(_parent_promise, function(_reason) {
				if (state == PROMISE_STATE.PAUSED) {
					state = PROMISE_STATE.REJECTED;
					reason = _reason;
				}
			}));
			
		_i+=1;}//end repeat loop
		
		return _parent_promise;
	};
	
	#endregion
	
	//note providing no start time will force the promise to execute all sub processes
	static Execute = function(_time_to_live=infinity) {
		if (state == PROMISE_STATE.PAUSED) {
			return;
		}
			
		if (state == PROMISE_STATE.PENDING) {
			if (array_length(executors)) {
				try {
					var _j=0; repeat(array_length(executors)) {
						var _executor = executors[0];
						var _val = _executor(value);
						array_delete(executors, 0, 1);
						value = (is_undefined(_val)) ? value : _val;
						
						if (array_length(executors) == 0) {
							state = PROMISE_STATE.RESOLVED;
							break;
						}
						
						//early out
						if (get_timer() >= _time_to_live) {
							break;
						}
							
					_j+=1;}//end repeat loop
				}
				catch (_error) {
					state = PROMISE_STATE.REJECTED;
					reason = _error;
				}
			}
			else {
				state = PROMISE_STATE.RESOLVED;
			}
		}
				
		if (state == PROMISE_STATE.RESOLVED) {
			if (on_resolved != undefined) {
				on_resolved(value);
			}
		}
				
		if (state == PROMISE_STATE.REJECTED) {
			if (on_rejected != undefined) {
				var _error = (is_struct(reason)) ? reason.message : reason;
				on_rejected(_error);
			}
		}
			
		return true;
	}
	
	var _promise = self;
	
	#region Private
		
		static __promise_id = 0;
		__promise_id+=1;
		_promise.promise_id = __promise_id;
		
		static __global = __PromiseNamespace__();
		time_source_start(__global.promises_time_source);
		
		array_push(__global.active_promises, _promise);
		
	#endregion
	
	return _promise;
}

//init statics and start timers
new Promise();
time_source_start(__PromiseNamespace__.__global.async_obj_spawn_time_source);