#!/usr/bin/env puma
environment 'development'

pidfile 'tmp/puma.pid'
state_path 'tmp/puma.state'
stdout_redirect 'log/puma.stdout', 'log/puma.stderr', true

bind 'unix://tmp/puma.sock'

workers 2

activate_control_app 'unix://tmp/pumactl.sock', { no_token: true }

require 'fileutils'
def add_service_status_task
  FileUtils.rm('.service-unavailable', force: true)
  server = Puma::Server.new(-> (env) {
    body = "OK"
    resp = [200, { 'Content-Type' => 'text/plain', 'Content-Length' => body.length.to_s }, [body] ] 
    bad_resp = [500, { 'Content-Type' => 'text/plain', 'Content-Length' => "BAD".length.to_s }, ["BAD"] ] 
    
    if (env["REQUEST_METHOD"] == "POST") && (env["PATH_INFO"] == "/set-service-unavailable")
      FileUtils.touch('.service-unavailable')
      resp 
    else
      bad_resp
    end
  })

  server.add_tcp_listener("localhost", 50301)
  server.run
end
add_service_status_task
