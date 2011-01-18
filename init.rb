require 'redmine'
require 'httparty'

require_dependency 'kanbanery/hooks'

Redmine::Plugin.register :redmine_kanbanery do
  name 'Redmine Kanbanery plugin'
  author 'Matt Conway'
  description 'This plugins allows one to push issues to kanbanery.com'
  version '0.1.0'
  url 'http://github.com/wr0ngway/redmine_kanbanery'
  author_url 'http://github.com/wr0ngway'

  permission :push_to_kanbanery, {:kanbanery => :push}
  settings :default => {'api_key' => '', 'workspace_name' => '', 'project_id' => ''}, :partial => 'settings/settings'
end
