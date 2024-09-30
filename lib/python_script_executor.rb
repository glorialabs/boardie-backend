class PythonScriptExecutor
  include Interactor

  def call
    return if Rails.env.development?

    output = nil
    errors = nil
    Open3.popen3("python3",
                 (Rails.root + "external/python/add_to_whitelist.py").to_s,
                 context.address,
                 context.board_ids) do |stdin, stdout, stderr, thread|
      pid = thread.pid
      output = stdout.read
      errors = stderr.read
    end
    Rails.logger.info output.inspect
    Rails.logger.info errors.inspect
  end
end
