wget http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar

declare -A PLUGINS=(
  [ansicolor]=0.7.5
  [greenballs]=1.15.1
  [prometheus]=2.0.10
  [jobConfigHistory]=2.27
  [rebuild]=1.32
  [uno-choice]=2.5.6
  [logstash]=2.4.0
  [metrics]=4.0.2.7
  [github-oauth]=0.33
  [variant]=1.3
  [build-name-setter]=2.2.0
  [build-user-vars-plugin]=1.7
  [envinject]=2.4.0
  [saml]=1.0.4
  [envinject-api]=1.6
)

for i in "${!PLUGINS[@]}"
do
  echo "Installing ${i}"
  java -jar ./jenkins-cli.jar -s http://127.0.0.1:8080 -auth admin:admin install-plugin \
    https://updates.jenkins-ci.org/download/plugins/$i/${PLUGINS[$i]}/$i.hpi
done

java -jar ./jenkins-cli.jar -s http://127.0.0.1:8080 -auth admin:admin restart

