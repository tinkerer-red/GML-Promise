/// @ignore
function __PromiseNamespace__() {
	//used to help evacuate the global struct so the variables are not easily accessed by users
	static __global = {
		promises_time_source : time_source_create(time_source_game, 1, time_source_units_frames, function() {
			static __global = __PromiseNamespace__()
			//handle all of the currently active processes
			var _time_to_live = get_timer() + PROMISE_MAX_TIME;
			
			var _i=0; repeat(array_length(__global.active_promises)) {
				var _promise = __global.active_promises[_i];
				
				_promise.Execute(_time_to_live);
				
				if (_promise.state == PROMISE_STATE.RESOLVED)
				|| (_promise.state == PROMISE_STATE.REJECTED) {
					array_delete(__global.active_promises, _i, 1);
					_i-=1;
				}
				
				//early out
				if (get_timer() >= _time_to_live) {
					break;
				}
				
			_i+=1;}//end repeat loop
			
			//if we have completed all promises
			if (array_length(__global.active_promises) == 0) {
				time_source_pause(__global.promises_time_source)
			}
			
		}, [], -1),
		async_obj_spawn_time_source : time_source_create(time_source_game, 1, time_source_units_frames, function() {
			static __global = __PromiseNamespace__();
			if (!instance_exists(__obj_promise)) instance_create_depth(0,0,0,__obj_promise);
			time_source_destroy(__global.async_obj_spawn_time_source, true);
		}, [], 1),
		active_promises : [],
		async_handlers: {},
	};
	
	return __global;
}

/// @ignore
function __handleAsyncEvent(_async_type, _async_load) {
	static __global = __PromiseNamespace__();
	
	var _type_struct = __global.async_handlers[$ _async_type];
	if (_type_struct != undefined) {
		
		var _async_id = _async_load[? "id"];
		var _handler = _type_struct[$ _async_id];
		
		if (_handler != undefined) {
			if (_async_load[? "status"] < 0) {
				_handler.reject_callback(_async_load[? "http_status"] ?? ":: Unknown Error occurred in async operation, ID = "+string(_async_id)+" ::");
				// Remove the handler
				struct_remove(_type_struct, _async_id);
			}
			else if (_async_load[? "status"] == 0) {
				_handler.resolve_callback(_async_load);
				// Remove the handler
				struct_remove(_type_struct, _async_id);
			}
		}
		
		
		
	}
}

//Use this function if you would like to add promises to your library.
/// @ignore
function __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback) {
	static __global = __PromiseNamespace__();
	
	var _promise = Promise.Then(_resolve_callback).Catch(_reject_callback);
	_promise.state = PROMISE_STATE.PAUSED;
	
	var _resolve = method(_promise, function(_async_load){
		state = PROMISE_STATE.PENDING;
		value = json_parse(json_encode(_async_load));
	});
	
	var _reject = method(_promise, function(_error){
		state = PROMISE_STATE.REJECTED;
		reason = _error;
	});
	
	var handler = {
		type: _async_type,
		async_id: _async_id,
		resolve_callback: _resolve,
		reject_callback: _reject,
	};
	
	//add a new reference
	if (!struct_exists(__global.async_handlers, _async_type)) __global.async_handlers[$ _async_type] = {};
	
	//add handler
	if (!struct_exists(__global.async_handlers[$ _async_type], _async_id)) __global.async_handlers[$ _async_type][$ _async_id] = handler;
	
	return _promise;
}

/// @ignore
enum ASYNC_EVENT {
	AUDIO_PLAYBACK,
	AUDIO_PLAYBACK_ENDED,
	AUDIO_RECORDING,
	CLOUD,
	DIALOG,
	HTTP,
	IN_APP_PURCHASE,
	IMAGE_LOADED,
	NETWORKING,
	PUSH_NOTIFICATIONS,
	SAVE_LOAD,
	SOCIAL,
	STEAM,
	SYSTEM,
	__SIZE__,
}
