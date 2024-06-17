# Built in Async Promises

## `audio_free_play_queue_promise()` → *Struct.Promise*
This function is used to free up the memory associated with the given audio queue. The queue index is the value returned when you created the queue using the function audio_create_play_queue(), and this function should be called when the queue is no longer required to prevent memory leaks. Freeing the queue will stop any sound that is be playing, and you cannot delete the buffer that a sound is being streamed from until the queue it is assigned to has been freed. This function will trigger an Audio Playback Asynchronous Event, and in this event a special DS map will be created in the variable async_load with the following key/value pairs:

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Real} queueindex : The index of the queue to free. |

## `audio_group_load_promise()` → *Struct.Promise*
This function will load all the sounds that are flagged as belonging to the given Audio Group into memory. The function will return true if loading is initiated and false if the group ID is invalid, or it has already been flagged for loading. The function is asynchronous so your game will continue to run while the audio is loaded in the background. This means that it will also trigger an Asynchronous Load/Save Event to inform you that the whole group has been loaded into memory and the sounds can now be used.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Asset.GMAudioGroup} groupid : The index of the audio group to load (as defined in the Audio Groups Window) |

## `audio_start_recording_promise()` → *Struct.Promise*
This function will start recording audio from the recorder source indexed. You can get the number of recorder sources using the function audio_get_recorder_count(), and once you start recording the audio will be stored in a temporary buffer and start triggering an Audio Recording Asynchronous Event. This event is triggered every step that recording takes place and will create the special DS map in the variable async_load with the following key/value pairs:

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Real} recorder_index : The index of the recorder source to use. |

## `audio_stop_recording_promise()` → *Struct.Promise*
This function will stop recording on the given recorder channel (the channel index is returned when you call the function audio_start_recording()). When you stop recording, no further Audio Recording Asynchronous Events will be triggered for the given recorder channel, so you would normally use this function in the actual asynchronous event to ensure that you have captured all the data.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Real} channel_index : The index of the recorder channel to stop. |

## `buffer_async_group_begin_promise()` → *Struct.Promise*
This function is called when you want to begin the saving out of multiple buffers to multiple files. The "groupname" is a string and will be used as the directory name for where the files will be saved, and should be used as part of the file path when loading the files back into the IDE later (using any of the buffer_load() functions). This function is only for use with the buffer_save_async() function and you must also finish the save definition by calling buffer_async_group_end() function otherwise the files will not be saved out.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{String} groupname : The name of the group (as a string). |

## `buffer_async_group_end_promise()` → *Struct.Promise*
This function finishes the definition of a buffer save group. You must have previously called the function buffer_async_group_begin() to initiate the group, then call the function buffer_save_async() for each file that you wish to save out. Finally you call this function, which will start the saving of the files. The function will return a unique ID value for the save, which can then be used in the Asynchronous Save / Load event to parse the results from the async_load DS map.

## `buffer_async_group_option_promise()` → *Struct.Promise*
With this function you can set some platform specific options for the buffer group being saved. The options available are as follows:

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{String} option : The option to set. |
|`` | |{Any} value : The value to set (can be string or real, depending on the option). |

## `buffer_load_async_promise()` → *Struct.Promise*
With this function you can load a file that you have created previously using the buffer_save() function (or any of the other functions for saving buffers) into a buffer. The "offset" defines the start position within the buffer for loading (in bytes), and the "size" is the size of the buffer area to be loaded from that offset onwards (also in bytes). You can supply a value of -1 for the size argument and the entire buffer will be loaded. Note that the function will load from a "default" folder, which does not need to be included as part of the file path you provide. This folder will be created if it doesn't exist or when you save a file using buffer_save_async().

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Id.Buffer} buffer : The index of the buffer to load. |
|`` | |{String} filename : The name of the file to load. |
|`` | |{Real} offset : The offset within the buffer to load to (in bytes). |
|`` | |{Real} size : The size of the buffer area to load (in bytes). |

## `buffer_save_async_promise()` → *Struct.Promise*
With this function you can save part of the contents of a buffer to a file, ready to be read back into memory using the buffer_load() function (or any of the other functions for loading buffers). The "offset" defines the start position within the buffer for saving (in bytes), and the "size" is the size of the buffer area to be saved from that offset onwards (also in bytes). This function works asynchronously, and so the game will continue running while being saved, and all files saved using this function will be placed in a "default" folder. This folder does not need to be included in the filename as it is added automatically by GameMaker. For example the filename path "Data\Player_Save.sav" would actually be saved to "default\Data\Player_Save.sav". However, if you then load the file using the function buffer_load_async(), you do not need to supply the "default" part of the path either (but any other file function will require it, except on consoles Xbox One, PS4 and Nintendo Switch).

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Id.Buffer} buffer : The index of the buffer to save. |
|`` | |{String} filename : The name of the file to save as. |
|`` | |{Real} offset : The offset within the buffer to save from (in bytes). |
|`` | |{Real} size : The size of the buffer area to save (in bytes). |

## `get_integer_async_promise()` → *Struct.Promise*
This function opens a window and displays message as well as a space for the user to input a value (which will contain the supplied default value to start with). This is an asynchronous function, and as such GameMaker does not block the device it is being run on while waiting for an answer, but rather keeps on running events as normal. Once the user has typed out their string and pressed the "Okay" button, an asynchronous Dialog event is triggered which, for the duration of that event only, will have a DS map stored in the variable async_load.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{String} string : The message to show in the dialog. |
|`` | |{Real} default : The default value. |

## `get_login_async_promise()` → *Struct.Promise*
This function opens a window that asks the user to input a username and password. These arguments can be set as an empty string or you can store previously entered values to use if you wish. This is an asynchronous function, and as such GameMaker does not block the device it is being run on while waiting for an answer, but rather keeps on running events as normal. Once the user has input the details and pressed the "Okay" button, an asynchronous User Interaction event is triggered which, for the duration of that event only, will have a DS map stored in the variable async_load.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{String} username : The default user name |
|`` | |{String} password : The default password |

## `get_string_async_promise()` → *Struct.Promise*
This function opens a window and displays message as well as a space for the user to input a string (which will contain the supplied default string to start with). This is an asynchronous function, and as such GameMaker does not block the device it is being run on while waiting for an answer, but rather keeps on running events as normal. Once the user has typed out their string and pressed the "Okay" button, an asynchronous Dialog event is triggered which, for the duration of that event only, will have a DS map stored in the variable async_load.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{String} string : The message to show in the dialog. |
|`` | |{String} default : The default string. |

## `http_get_promise()` → *Struct.Promise*
With this function, you connect to the specified URL in order to retrieve information. As this is an asynchronous function, GameMaker will not block while waiting for a reply, but will keep on running unless it gets callback information. This information will be in the form of a string and will trigger an Async Event in any instance that has one defined in their object properties. You should also note that HTTP request parameters (the bits sometimes "tacked on" to the end of a URL when you submit a form on a web page) are perfectly acceptable when using this function, for example:

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{String} url : The web address of the server that you wish to get information from |

## `http_get_file_promise()` → *Struct.Promise*
With this function, you can connect to the specified URL in order to retrieve information in the form of a file. As this is an asynchronous function, GameMaker will not block while waiting for a reply, but will keep on running unless it gets callback information. This information will be in the form of a string and will trigger an Async Event in any instance that has one defined in their object properties.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{String} url : The web address of the server that you wish to get file from |
|`` | |{String} local_target : The local storage path to save the file to |

## `http_post_string_promise()` → *Struct.Promise*
In computing, a post request is used when the client needs to send data to the server as part of the retrieval request, such as when uploading a file or submitting a completed form, and the same is true of this function in GameMaker. In contrast to the http_get() request method where only a URL is sent to the server, http_post_string() also includes a string that is sent to the server and may result in the creation of a new resource or the update of an existing resource or both. It should be noted that HTTP request parameters (the bits sometimes "tacked on" to the end of a URL when you submit a form on a web page) are perfectly acceptable when using this function too.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{String} url : The web address of the server that you wish to get information from |
|`` | |{String} string : The string you wish to send to the specified URL |

## `http_request_promise()` → *Struct.Promise*
With this function, you can create an HTTP header request to define the operating parameters of an HTTP transaction, which can be used for many things like (for example) authentication via HTTP headers if you use RESTful APIs. The function requires the full IP address of the server to request from as well as the type of request to make (as a string, see the note below): "GET", "HEAD", "POST", "PUT", "DELETE", "TRACE", "OPTIONS", or "CONNECT". You will also need to supply a DS map of key/value pairs (as strings, where the key is the header field and the value is the required data for the header), and the final argument is an optional data string that you can add to the request, and if it's not needed then it can be either 0 or an empty string "". Note that you can also send a buffer (see the section on Buffers for more details), in which case the last argument would be the "handle" of the buffer to send.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{String} url : The web address of the server that you wish to get information from |
|`` | |{String} method : The request method (normally "POST" or "GET", but all methods are supported) |
|`` | |{Id.DsMap} header_map : A ds_map with the required header fields |
|`` | |{Real,String,Id.Buffer} body : The data to be transmitted following the headers (can be a binary buffer handle) |

## `http_set_request_crossorigin_promise()` → *Struct.Promise*
With this function you can set the cross origin type to use when loading images from a file. The function is exclusively for the HTML5 platform and is only useful when loading sprites from a file using the sprite_add() function. Note that when set to "use-credentials" you no longer need to give an absolute path to the sprite being loaded, but instead would give a relative path (as shown in the example below). By default the cross origin type is set to "anonymous".

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{String} origin_type : The cross origin type to use (a string) |

## `keyboard_virtual_hide_promise()` → *Struct.Promise*
This function can be used to hide the virtual keyboard on the device running the game. Calling this function will generate a System Asynchronous Event, in which the async_load DS map will be populated with the following key/value pairs:

## `network_connect_async_promise()` → *Struct.Promise*
With this function you can send a request to connect to a server. The function takes the socket id to connect through (see network_create_socket()) and requires you to give the IP address to connect to (a string) as well as the port to connect through, and if the connection fails a value of less than 0 will be returned. The connection uses a special protocol that ensures only GameMaker games connect to each other, however if you need to connect to a server that is not a GameMaker game, you can use network_connect_async_raw(). Note that this function is asynchronous, generating an Asynchronous Networking event of the type network_type_non_blocking_connect.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Id.Socket} socket : The id of the socket to use. |
|`` | |{String} url : The URL or IP to connect to (a string). |
|`` | |{Real} port : The port to connect to. |

## `network_connect_raw_async_promise()` → *Struct.Promise*
With this function you can send a request to connect to a server. The function takes the socket id to connect through (see network_create_socket()) and requires you to give the IP address to connect to (a string) as well as the port to connect through, and if the connection fails a value of less than 0 will be returned. The difference between this function and network_connect_async()is that this function can connect to any server and does nothing to the raw data, meaning that you have to implement the protocols yourself at the server end. Note that this function is asynchronous, generating an Asynchronous Networking event of the type network_type_non_blocking_connect.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Id.Socket} socket : The id of the socket to use. |
|`` | |{String} url : The URL or IP to connect to (a string). |
|`` | |{Real} port : The port to connect to. |

## `show_message_async_promise()` → *Struct.Promise*
This function opens a window and displays the message you define in the function to the user. This is an asynchronous function, and as such GameMaker does not block the device it is being run on while waiting for an answer, but rather keeps on running events as normal. Once the user has pressed the "Okay" button, an asynchronous Dialog event is triggered which, for the duration of that event only, will have a ds_map stored in the variable async_load.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{Any} string : The message to show to the user. |

## `show_question_async_promise()` → *Struct.Promise*
This function opens a window and displays the question you define in the function to the user. This is an asynchronous function, and as such GameMaker does not block the device it is being run on while waiting for an answer, but rather keeps on running events as normal. The function has two buttons that show "Yes" and "No", and once the user has pressed one, an asynchronous Dialog event is triggered which, for the duration of that event only, will have a DS map stored in the variable async_load.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{String} string : The question to ask to the user. |

## `sprite_add_promise()` → *Struct.Promise*
With this function you can add an image as a sprite, loading it from an external source where the image file to be loaded should always be in either *.png, *.gif, *.jpg/jpeg or *.json format (*json files are used for loading skeleton animation sprites made with Spine). The function returns the new sprite index which must then be used in all further code that relates to the sprite. If you use this function with HTML5 or are getting an image from a URL, this function will also generate an Image Loaded asynchronous event. See this page for more information.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{String} fname : The name (a string file path) of the file to add. |
|`` | |{Real} imgnum : Use to indicate the number of sub-images (1 for a single image or for a *.gif). |
|`` | |{Bool} removeback : Indicates whether to make all pixels with the background colour (left-bottom pixel) transparent. |
|`` | |{Bool} smooth : Indicates whether to smooth the edges if transparent. |
|`` | |{Real} xorig : Indicate the x position of the origin in the sprite. |
|`` | |{Real} yorig : Indicate the y position of the origin in the sprite. |

## `sprite_add_ext_promise()` → *Struct.Promise*
With this function you can asynchronously add an image as a sprite, loading it from an external source where the image file to be loaded should always be in either *.png, *.gif, *.jpg/jpeg or *.json format (*json files are used for loading skeleton animation sprites made with Spine). The function returns the new sprite index which must then be used in all further code that relates to the sprite. This function will generate an Image Loaded asynchronous event when the sprite has been loaded. See this page for more information.

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{String} fname : The name (a string file path) of the file to add. |
|`` | |{Real} imgnum : Use to indicate the number of sub-images (1 for a single image or for a *.gif). |
|`` | |{Real} xorig : Indicate the x position of the origin in the sprite. |
|`` | |{Real} yorig : Indicate the y position of the origin in the sprite. |
|`` | |{Bool} prefetch : Indicates whether the sprite should be loaded to GPU memory. |

## `zip_unzip_async_promise()` → *Struct.Promise*
This function will open a stored zip file and extract its contents to the given directory asynchronously. Note that if you do not supply a full path to the ZIP directory then the current drive root will be used, and if you want to place it in a relative path to the game bundle working directory then you should use the working_directory variable as part of the path (relative paths using "." or ".." will not work as expected so should be avoided). Note too that the zip must be either part of the game bundle (ie: an Included File) or have been downloaded to the storage area using http_get_file().

| Parameter | Datatype  | Purpose |
|-----------|-----------|---------|
|`` | |{String} zip_file : The zip file to open |
|`` | |{String} target_directory : The target directory to extract the files to |
