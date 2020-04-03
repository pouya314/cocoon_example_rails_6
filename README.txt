gem "cocoon"

yarn add github:nathanvda/cocoon#c24ba53

(application.js)
import "cocoon";

yarn add jquery bootstrap

(environments.js)
const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery'
}))

module.exports = environment


rails g scaffold Project name:string description:string

rails g model Task description:string done:boolean project:belongs_to

class Project < ActiveRecord::Base
  has_many :tasks, inverse_of: :project
  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true
end

class Task < ActiveRecord::Base
  belongs_to :project
end

(project_controller.rb)
  def project_params
    params.require(:project).permit(:name, :description, tasks_attributes: [:id, :description, :done, :_destroy])
  end

(Add to _form.html.erb)
  <h3>Tasks</h3>
  <div id="tasks">
	  <%= form.fields_for :tasks do |task| %>
	  	<%= render 'task_fields', f: task %>
	  <% end %>
	  <div class="links">
		  <%= link_to_add_association 'add task', form, :tasks %>	  	
	  </div>
  </div>

(Created _task_fields.html.erb)
<div class="nested-fields">
	<div class="field">
	    <%= f.label :description %>
	    <br/>
	    <%= f.text_field :description %>
	</div>
	<div class="field">
	    <%= f.check_box :done %>
	    <%= f.label :done %>
	</div>
	<div>
		<%= link_to_remove_association "remove task", f %>
	</div>
</div>

(Added to show.html.erb)
<div id="tasks">
	<% for task in @project.tasks %>
		- <%= task.description %> | Done? <%= task.done %><br/>
	<% end %>
</div>

Sortable JS lib:
https://github.com/SortableJS/Sortable