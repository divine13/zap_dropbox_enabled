class Admin::BaseController < ApplicationController
	before_filter :auth_admin
	def index 
	end
end
