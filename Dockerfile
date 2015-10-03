# The current version of RunDeck requires Java 7 JRE
FROM tomcat:7-jre7

WORKDIR $CATALINA_HOME/webapps/rundeck

# Current version of RunDeck (target)
ENV RUNDECK_VERSION 2.5.3
ENV RUNDECK_DOWNLOAD_URL http://download.rundeck.org
ENV RUNDECK_WAR_URL $RUNDECK_DOWNLOAD_URL/war/rundeck-$RUNDECK_VERSION.war

RUN set -x \
	&& curl -fSL "$RUNDECK_WAR_URL" -o rundeck.war \
	&& curl -fSL "$RUNDECK_WAR_URL.asc" -o rundeck.war.asc \
	&& unzip rundeck.war \
	&& rm rundeck.war*

ENV RDECK_BASE "/rundeck"
WORKDIR $RDECK_BASE

ENV CATALINA_OPTS "-Xmx1024m -Xms256m -Drdeck.base=$RDECK_BASE -Drundeck.config.location=$RDECK_BASE/rundeck-config.properties"
