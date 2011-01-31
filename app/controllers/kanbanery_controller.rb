class KanbaneryController < ApplicationController
  unloadable

  def push
    back_url = params[:back_url] || "/"
    api = KanbaneryAPI.new()

    Issue.find(params[:ids]).each do |issue|

      kanbanery = KanbaneryIssue.find_by_issue_id(issue.id)
      kanbanery = KanbaneryIssue.new(:issue_id =>issue.id) unless kanbanery

      if kanbanery.task_id.to_i > 0 && api.find_task(kanbanery.task_id)
        api.update_task(kanbanery.task_id, build_task(issue))
        flash[:notice] = "Updated issues in kanbanery"
      else
        result = api.create_task(build_task(issue))
        kanbanery.task_id = result['id']
        kanbanery.save!
        flash[:notice] = "Pushed issues to kanbanery"
      end

    end

    redirect_to back_url
  end

  private

  def build_task(issue)
    task = {}
    task[:title] = issue.subject
    description = issue_url(issue)
    description << "\n\n#{issue.description}" if issue.description.present?
    task[:description] = description
    task[:task_type_name] = case issue.tracker.name
      when 'Feature' then 'Story'
      else 'Bug'
    end

    return {:task => task}
  end

end
