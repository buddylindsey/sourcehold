require_relative 'db'

class ActionLog < DB

  def initialize
    init
  end
  
  def log_action(user_id, action)
    @conn.query("INSERT INTO action_logs (`user_id`, `action`, `created_at`, `updated_at`) VALUES (#{user_id}, '#{action}', NOW(), NOW())")
  end
end
