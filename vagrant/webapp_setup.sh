dnf install java-11-openjdk -y
dnf install git maven wget -y

git clone -b manual-deployment git@github.com:iatiqul/lms-devops-final.git
cd lms-devops-final
mvn spring-boot:run