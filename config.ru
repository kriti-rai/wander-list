require './config/environment'

use Rack::MethodOverride
use UserController
use TripController
run ApplicationController
