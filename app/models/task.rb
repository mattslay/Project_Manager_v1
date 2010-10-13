class Task < ActiveRecord::Base

  belongs_to :project

  def pretty_date

     self.completed_at #.strftime("%m/%d/%Y")

  end

end
