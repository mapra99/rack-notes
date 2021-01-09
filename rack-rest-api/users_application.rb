class UsersApplication
  def call(env)
    if env['PATH_INFO'] == ''
      [200, {}, [Database.users.to_s]]
    elsif env['PATH_INFO'] =~ %r{/\d+}
      id = env['PATH_INFO'].split('/').last.to_i
      [200, {}, [Database.user(id).to_s]]
    else
      [404, {}, ['Not Found!']]
    end
  end
end
