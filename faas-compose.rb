#!/usr/bin/env ruby
require "yaml"

manifest = YAML.load(File.read("stack.yml"))

functions={}
 manifest['functions'].select{|f,d| d['lang']=='ruby-http'}.each{ |function,definition|
    functions[function] = {
        'build' => {
            'context' => definition['handler'],
            'dockerfile' => "../../Dockerfile.#{definition['lang']}"
        },
        'labels' => [
            "traefik.enable=true",
            "traefik.http.routers.#{function}.rule=Path(`/functions/#{function}`)",
            "traefik.http.routers.#{function}.entrypoints=web"
        ]
    }
    functions[function]['build']['args']=definition['build_args'] if definition['build_args']
    functions[function]['environment']=definition['environment'] if definition['environment']
}

File.open("faas-compose.yml","w"){|f|
  f << {'services' => functions}.to_yaml
}


