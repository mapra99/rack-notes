class RidesApplication
  def call(env)
    if env['PATH_INFO'] == ''
      [200, {}, [Database.rides.to_s]]
    elsif env['PATH_INFO'] =~ %r{/\d+}
      id = env['PATH_INFO'].split('/').last.to_i
      [200, {}, [Database.ride(id).to_s]]
    else
      [404, {}, ['Not Found!']]
    end
  end
end
