# The current version of RunDeck requires Java 7 JRE
FROM tomcat:7-jre7

# Current version of RunDeck (target)
ENV RUNDECK_VERSION 2.5.3
ENV RUNDECK_DOWNLOAD_URL http://download.rundeck.org
ENV RUNDECK_WAR_URL $RUNDECK_DOWNLOAD_URL/war/rundeck-$RUNDECK_VERSION.war
ENV APP_CONTEXT rundeck

WORKDIR $CATALINA_HOME/webapps/$APP_CONTEXT

RUN set -x \
	&& curl -fSL "$RUNDECK_WAR_URL" -o rundeck.war \
	&& curl -fSL "$RUNDECK_WAR_URL.asc" -o rundeck.war.asc \
	&& unzip rundeck.war \
	&& rm rundeck.war*

# RunDeck app configuration - Defaults from rundeck/wiki/Tomcat-Deployment
ENV _CATALINA_OPTS ${JAVA_OPTIONS:--Xmx1024m -Xms256m}

ENV RDECK_BASE ${RDECK_BASE:-/rundeck}
ENV _CATALINA_OPTS "${_CATALINA_OPTS} -Drdeck.base=$RDECK_BASE"
WORKDIR $RDECK_BASE

ENV SERVER_URL ${SERVER_URL:-http://$HOSTNAME:8080/$APP_CONTEXT/}
ENV DATASOURCE_URL ${DATASOURCE_URL:-jdbc:h2:file:$RDECK_BASE/server/data/grailsdb}
# note, make sure this is set to "true" if you are using Oracle or Mysql
ENV RDBSUPPORT ${RDBSUPPORT:-false}

ENV RDECK_CONFIG_PROPS $RDECK_BASE/rundeck-config.properties 
RUN echo "grails.serverURL=$SERVER_URL" >> $RDECK_CONFIG_PROPS 
RUN echo "dataSource.dbCreate=update" >> $RDECK_CONFIG_PROPS 
RUN echo "dataSource.url=$DATASOURCE_URL" >> $RDECK_CONFIG_PROPS 
RUN echo "rundeck.v14.rdbsupport=$RDBSUPPORT" >> $RDECK_CONFIG_PROPS
ENV _CATALINA_OPTS "${_CATALINA_OPTS} -Drundeck.config.location=$RDECK_CONFIG_PROPS"

ENV CATALINA_OPTS ${CATALINA_OPTS:-${_CATALINA_OPTS}}

# Defaults to using CMD ["catalina.sh", "run"] from tomcat container.
