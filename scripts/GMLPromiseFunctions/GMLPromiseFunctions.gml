function audio_free_play_queue_promise(queueId,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: audio_free_play_queue_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.AUDIO_PLAYBACK;
	var _async_id = audio_free_play_queue(queueId);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function audio_group_load_promise( groupid ,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: audio_group_load_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.SAVE_LOAD;
	var _async_id = audio_group_load( groupid );
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function audio_start_recording_promise(recorder_num,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: audio_start_recording_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.AUDIO_RECORDING;
	var _async_id = audio_start_recording(recorder_num);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function audio_stop_recording_promise(channel_index){
	//these dont actually generate an async event id, so they are only here for consistancy sake
	audio_stop_recording(channel_index);
}
function buffer_async_group_begin_promise(groupname){
	//these dont actually generate an async event id, so they are only here for consistancy sake
	buffer_async_group_begin(groupname);
}
function buffer_async_group_end_promise(
_resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: buffer_async_group_end_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.SAVE_LOAD;
	var _async_id = buffer_async_group_end();
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function buffer_async_group_option_promise(optionname,optionvalue){
	//these dont actually generate an async event id, so they are only here for consistancy sake
	buffer_async_group_option(optionname,optionvalue);
}
function buffer_load_async_promise(bufferid,filename,offset,size,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: buffer_load_async_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.SAVE_LOAD;
	var _async_id = buffer_load_async(bufferid,filename,offset,size);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function buffer_save_async_promise(bufferid,filename,offset,size,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: buffer_save_async_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.SAVE_LOAD;
	var _async_id = buffer_save_async(bufferid,filename,offset,size);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function get_integer_async_promise(str,def,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: get_integer_async_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.DIALOG;
	var _async_id = get_integer_async(str,def);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function get_login_async_promise(username,password,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: get_login_async_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.DIALOG;
	var _async_id = get_login_async(username,password);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function get_string_async_promise(str,def,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: get_string_async_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.DIALOG;
	var _async_id = get_string_async(str,def);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function http_get_promise(url,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: http_get_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.HTTP;
	var _async_id = http_get(url);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function http_get_file_promise(url, dest,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: http_get_file_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.HTTP;
	var _async_id = http_get_file(url, dest);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function http_post_string_promise(url, str,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message("Promise :: http_post_string_promise :: Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.HTTP;
	var _async_id = http_post_string(url, str);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function http_request_promise(url, _method, header_map, body,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message("Promise :: http_request_promise :: Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.HTTP;
	var _async_id = http_request(url, _method, header_map, body);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function http_set_request_crossorigin_promise(crossorigin_type,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message("Promise :: http_set_request_crossorigin_promise :: Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.HTTP;
	var _async_id = http_set_request_crossorigin(crossorigin_type);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function keyboard_virtual_hide_promise(
_resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: keyboard_virtual_hide_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.SYSTEM;
	var _async_id = keyboard_virtual_hide();
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function network_connect_async_promise(socket, url, port,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: network_connect_async_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.NETWORKING;
	var _async_id = network_connect_async(socket, url, port);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function network_connect_raw_async_promise(socket, url, port,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: network_connect_raw_async_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.NETWORKING;
	var _async_id = network_connect_raw_async(socket, url, port);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function show_message_async_promise(str,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: show_message_async_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.DIALOG;
	var _async_id = show_message_async(str);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function show_question_async_promise(str,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: show_question_async_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.DIALOG;
	var _async_id = show_question_async(str);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function sprite_add_promise(fname,imgnumb,removeback,smooth,xorg,yorig,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: sprite_add_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.IMAGE_LOADED;
	var _async_id = sprite_add(fname,imgnumb,removeback,smooth,xorg,yorig);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function sprite_add_ext_promise(fname,imgnumb,xorg,yorig,prefetch,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: sprite_add_ext_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.IMAGE_LOADED;
	var _async_id = sprite_add_ext(fname,imgnumb,xorg,yorig,prefetch);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
function zip_unzip_async_promise(file, destPath,
 _resolve_callback=undefined, _reject_callback=function(_reason){ show_debug_message(":: zip_unzip_async_promise :: Promise Failed with error : "+_reason) }){
	var _async_type = ASYNC_EVENT.SAVE_LOAD;
	var _async_id = zip_unzip_async(file, destPath);
	return __registerAsyncHandler(_async_type, _async_id, _resolve_callback, _reject_callback);
}
