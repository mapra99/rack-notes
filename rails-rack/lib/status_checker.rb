class StatusCheckerApplication
  def call(_env)
    [200, {}, ['ok']]
  end
end
