# Instagram23

App flow/layout (app is 3 levels deep):

	1) login screen
		- webview with username/password fields
		- access token is saved in keychain for autologin during subsequent launches
    2) main tab bar page
		- photo stream tab
			- table view of recent media
			- pull down to refresh
			- double click photo to like
			- momentary 'thumbs up' indicator when liking a photo
			- 'thumbs up' button is tinted differently depending on whether user has liked or unliked
			- click 'thumbs up' button to toggle like/unlike
			- '# likes' button is shown if there are 1+ likes
				3) clicking '# likes' button shows list of users that liked the media
		- profile tab
			- views user info
			- log out
	- localize user-facing texts that are set programmatically
	- handle empty photo stream and api errors with a simple alert

External libraries:

	Alamofire - used for networking
		- pros:	- cleaner network code
		    	- url request generation is generated in a single file (Router.swift)
			    - supports session retrier to handle access token expiration
			    - supports session adapter to have a centralized place to insert common request headers instead of in every method
	    		- less code than using URLSession directly and having redundant cookie cutter code
	AlamofireImage - used for fetching server images
		- pros:	- elegant way of specifying image url and placeholder and having library fetch image asynchronously
				- placeholder image automatically gets rendered until the server image is fetched successfully
	SwiftyJSON - used for parsing json objects
		- pros:	- elegantly chain json response keys to get a particular value
	KeychainWrapper - used to read/write/delete from keychain
		- pros:	- simple way to use keychain
	External library cons:
		- bugfixes/updates dependent on library author(s)
		- another layer of code to debug if something doesn't work

Source code overview:

	- files are grouped in the following manner:
		- Models: contains all the classes representing each json response object
		- Resources: contains all app resources such localized strings and image assets
		- Rest: contains all the networking files
		- Storyboards: contains all the UI layout files
		- UI: contains all the custom UI class files 
		- Utilities: contains miscellaneous helper files
		- ViewControllers: contains all the screen class files

Known limitations/assumptions:

	- storyboards haven't been localized
	- the app may be in sandbox mode (ref: https://stackoverflow.com/questions/35373611/instagram-api-media-likes-endpoint-leaving-off-likes), causing the following effects:
		- getting recent media doesn't seem to display media from people that the user is following
		- getting a list of users that liked a media seems to always return 1
	- there doesn't seem to be an actual log out api, so the assumption is that the client only needs to clear the access token (from keychain and browser cookies in this case)
	- the pagination object being returned in the recent media endpoint seems to be empty.  may need to have a larger photo stream or resolve the sandboxing mode to get enough data to handle pagination
