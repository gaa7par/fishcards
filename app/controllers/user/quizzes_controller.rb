class User::QuizzesController < ApplicationController
  before_action :authenticate_user!
end
