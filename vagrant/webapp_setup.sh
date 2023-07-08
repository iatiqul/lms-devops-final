dnf install java-11-openjdk -y
dnf install git maven wget -y

git clone -b manual-deployment https://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@github.com/iatiqul/lms-devops-final.git
cd lms-devops-final
./mvnw clean install
./mvnw spring-boot:run