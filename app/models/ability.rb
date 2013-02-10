class Ability
include CanCan::Ability

	def initialize(user)
		if user.role_admin?
			can :manage, :all
			cannot [:begin,:end,:complete ,:finish ,:pause, :start], Subtask
		else
		  can [:show, :index], Project
		  can [:show, :index], Task
		  can [:index, :showc, :begin, :end ,:complete ,:finish ,:pause,:start], Subtask
		  can [:update,:destroy], Result
		end
	end

end
