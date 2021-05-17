# XFaaS

XFaaS is a *docker-compose* based runner for your *OpenFaaS* functions.

You can develop your *OpenFaaS* functions as usual and then run them with docker-compose as containers with *traefik* in front.

It currently supports only *ruby* functions.

## Usage

Clone this repository or download all files and place them in your project folder.

### Create new function

```
  faas template pull https://github.com/openfaas/ruby-http
  faas-cli new --lang ruby-http --append stack.yml myfunction
```

### Deploy functions
```
   ./faas-compose.rb
   docker-compose -f docker-compose.yml -f faas-compose.yml up
```

## Internals

*fass-cli* generates function skeleton and adds function to *stack.yml*.

*faas-compose.rb* reads *stack.yml* and generates *faas-compose.yml* which is than used as second configuration file for docker-compose.

*docker-compose* starts *traefik*, functions and registers all funcions on *traefik*.

