require './config/environment'

use Rack::MethodOverride
use UserController
use TripController
use BoardController
run ApplicationController
