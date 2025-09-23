#!/bin/bash
yum update -y
yum install -y git wget unzip

# Install Java 21
cd /opt
wget https://download.java.net/java/GA/jdk21/2/GPL/openjdk-21_linux-x64_bin.tar.gz
tar -xzf openjdk-21_linux-x64_bin.tar.gz
export JAVA_HOME=/opt/jdk-21
export PATH=$JAVA_HOME/bin:$PATH

# Install Maven
wget https://downloads.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip
unzip apache-maven-3.9.6-bin.zip
export MAVEN_HOME=/opt/apache-maven-3.9.6
export PATH=$MAVEN_HOME/bin:$PATH

# Clone repo and build
git clone https://github.com/Trainings-TechEazy/test-repo-for-devops
cd test-repo-for-devops
mvn clean package

# Open port 80
yum install -y firewalld
systemctl start firewalld
firewall-cmd --add-port=80/tcp --permanent
firewall-cmd --reload

# Run app
nohup java -jar target/techeazy-devops-0.0.1-SNAPSHOT.jar --server.port=80 > /dev/null 2>&1 &
