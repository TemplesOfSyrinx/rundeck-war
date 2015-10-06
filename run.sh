#!/usr/bin/env bash
# RunDeck app configuration - Defaults from rundeck/wiki/Tomcat-Deployment
export _CATALINA_OPTS ${JAVA_OPTIONS:--Xmx1024m -Xms256m}

export RDECK_BASE ${RDECK_BASE:-/rundeck}
export _CATALINA_OPTS "${_CATALINA_OPTS} -Drdeck.base=$RDECK_BASE"
cd $RDECK_BASE

export SERVER_URL ${SERVER_URL:-http://$HOSTNAME:8080/$APP_CONTEXT/}
export DATASOURCE_URL ${DATASOURCE_URL:-jdbc:h2:file:$RDECK_BASE/server/data/grailsdb}
# note, make sure this is set to "true" if you are using Oracle or Mysql
export RDBSUPPORT ${RDBSUPPORT:-false}

export RDECK_CONFIG_PROPS $RDECK_BASE/rundeck-config.properties 
echo "grails.serverURL=$SERVER_URL" >> $RDECK_CONFIG_PROPS 
echo "dataSource.dbCreate=update" >> $RDECK_CONFIG_PROPS 
echo "dataSource.url=$DATASOURCE_URL" >> $RDECK_CONFIG_PROPS 
echo "rundeck.v14.rdbsupport=$RDBSUPPORT" >> $RDECK_CONFIG_PROPS

export _CATALINA_OPTS "${_CATALINA_OPTS} -Drundeck.config.location=$RDECK_CONFIG_PROPS"

export CATALINA_OPTS ${CATALINA_OPTS:-${_CATALINA_OPTS}}

exec $1
