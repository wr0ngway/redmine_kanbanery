class KanbaneryAPI
  include HTTParty
  include ActionController::UrlWriter

  def initialize()
    self.class.default_params :api_token => Setting.plugin_redmine_kanbanery['api_key']
    self.class.base_uri "https://#{Setting.plugin_redmine_kanbanery['workspace_name']}.kanbanery.com/api/v1"
  end

  def find_task(task_id)
    task = nil
    url = "/tasks/#{task_id}.json"
    response = self.class.get(url)
    if response.code == 200
      task = response.parsed_response
    end
    return task
  end

  def create_task(task)
    url = "/projects/#{Setting.plugin_redmine_kanbanery['project_id']}/tasks.json"
    response = self.class.post(url, {:body => task})

    if response.code >= 200 &&response.code < 300
      return response.parsed_response
    else
      raise "Failed to create task (#{url} - #{task.inspect}): #{response.inspect}"
    end
  end

  def update_task(task_id, task)
    url = "/tasks/#{task_id}.json"
    response = self.class.put(url, {:body => task})

    if response.code >= 200 &&response.code < 300
      return response.parsed_response
    else
      raise "Failed to update task (#{url} - #{task.inspect}): #{response.inspect}"
    end
  end

  def destroy_task(task_id)
    url = "/tasks/#{task_id}.json"
    response = self.class.delete(url)

    if response.code >= 200 &&response.code < 300
      return response.parsed_response
    else
      raise "Failed to destroy task (#{url}): #{response.inspect}"
    end
  end

end
