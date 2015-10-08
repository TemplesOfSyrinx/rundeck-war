#!/usr/bin/env bash
# RunDeck app configuration - Defaults from rundeck/wiki/Tomcat-Deployment
export _CATALINA_OPTS=${JAVA_OPTIONS:--Xmx1024m -Xms256m}

export RDECK_BASE=${RDECK_BASE:-/rundeck}
export _CATALINA_OPTS="${_CATALINA_OPTS} -Drdeck.base=$RDECK_BASE"
mkdir -p $RDECK_BASE
cd $RDECK_BASE

#export SERVER_URL=${SERVER_URL:-http://$HOSTNAME:8080/$APP_CONTEXT/}
#export DATASOURCE_URL=${DATASOURCE_URL:-jdbc:h2:file:$RDECK_BASE/server/data/grailsdb}
# note, make sure this is set to "true" if you are using Oracle or Mysql
#export RDBSUPPORT=${RDBSUPPORT:-false}

#export RDECK_CONFIG_PROPS=$RDECK_BASE/rundeck-config.properties

#cat > $RDECK_CONFIG_PROPS <<CONFIG_PROPS
#grails.serverURL=$SERVER_URL 
#dataSource.dbCreate=update 
#dataSource.url=$DATASOURCE_URL 
#rundeck.v14.rdbsupport=$RDBSUPPORT
#CONFIG_PROPS

#export _CATALINA_OPTS="${_CATALINA_OPTS} -Drundeck.config.location=$RDECK_CONFIG_PROPS"

export CATALINA_OPTS=${CATALINA_OPTS:-${_CATALINA_OPTS}}

exec $@
