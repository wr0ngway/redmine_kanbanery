class KanbaneryAPI
  include HTTParty
  include ActionController::UrlWriter

  def initialize()
    self.class.default_params :api_token => Setting.plugin_redmine_kanbanery['api_key']
    self.class.base_uri "https://#{Setting.plugin_redmine_kanbanery['workspace_name']}.kanbanery.com/api/v1"
  end

  def find_task(task_id)
    task = nil
    response = self.class.get("/tasks/#{task_id}.json")
    if response.code == 200
      task = response.parsed_response
    end
    return task
  end

  def create_task(task)
    response = self.class.post("/projects/#{Setting.plugin_redmine_kanbanery['project_id']}/tasks.json", {:body => task})

    if response.code >= 200 &&response.code < 300
      return response.parsed_response
    else
      raise "Failed to create task: #{response.inspect}"
    end
  end

  def update_task(task_id, task)
    response = self.class.put("/tasks/#{task_id}.json", {:body => task})

    if response.code >= 200 &&response.code < 300
      return response.parsed_response
    else
      raise "Failed to update task: #{response.inspect}"
    end
  end

  def destroy_task(task_id)
    response = self.class.delete("tasks/#{task_id}.json")

    if response.code >= 200 &&response.code < 300
      return response.parsed_response
    else
      raise "Failed to destroy task: #{response.inspect}"
    end
  end

end
