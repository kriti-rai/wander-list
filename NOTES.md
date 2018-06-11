##User
*has many boards
*has many trips thru boards*

-has a username
-has an email address
-has a password

##Board
*belongs to a user
*has_and_belongs_to_many trips*

-has a name

##Trip
*has_and_belongs_to_many boards
*has many users through boards*

-has a name
-has a URL(?)

-method to add a trip (add_trip) to a board
-method to delete a trip (delete_trip) from a board



##Controllers

###ApplicationController

1. shows homepage 'index.erb'

###UserController

1. registration
  a) '/signup' - render signup form
  b) sign up form posts to post '/signup'
  c) session[:id] = user.id
  d) user is automatically logged in
2. session
  a) get '/login' - render login form
  b) login form posts to post '/login'
3. logout
  a) get '/logout' - clears session - redirect to home


###BoardController
1. Create a board
  - get '/boards/new' - shows the form in new.erb
  - post '/boards' - gets params from new.erb and shows the new board
2. Read
  - get '/boards'
  - get '/boards/:id'
3. edit
  - get '/boards/edit/:id'
  - patch '/boards/:id'
4. delete '/boards/delete/:id'


###TripController
- user should be able to delete/add trips from their board
1. index
  -view all trips available (maybe scrape a list from a website or use static list)
2. '/trips/:slug'
  - look up a trip by slug
