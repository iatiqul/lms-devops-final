yum install java-11-openjdk -y
yum install git maven wget -y

git clone -b manual-deployment https://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@github.com/iatiqul/lms-devops-final.git
cd lms-devops-final
mvn clean install
mvn spring-boot:run