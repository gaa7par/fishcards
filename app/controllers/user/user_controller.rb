# frozen_string_literal: true
class User::UserController < ApplicationController
  before_action :authenticate_user!
end
