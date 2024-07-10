#!/bin/bash
sudo rm -rf /home/ubuntu/honeybadger/sub
sudo docker rm -f \$(docker ps -aqf "name=^\${DOCKERHUB_REPO}1") # 컨테이너 찾아서 종료
sudo docker pull \${DOCKERHUB_USERNAME}/\${DOCKERHUB_REPO}:latest
sudo docker run -d -p 3000:3000 -p 8080:8080 -v /home/ubuntu/honeybadger:/config --name "\${DOCKERHUB_REPO}1" \${DOCKERHUB_USERNAME}/\${DOCKERHUB_REPO}:latest
sudo docker image prune -f

count=0


while true; do
  # 실행할 명령어
  response=\$(curl -s localhost:8080/api/track/health)
  if [[ \${response} =~ "UP" ]]; then
    # 서비스가 실행 중인 경우
    sudo rm -rf /home/ubuntu/honeybadger/sub
    sudo docker rm -f \$(docker ps -aqf "name=^\${DOCKERHUB_REPO}2") # 컨테이너 찾아서 종료
    sudo docker pull \${DOCKERHUB_USERNAME}/\${DOCKERHUB_REPO}:latest
    sudo docker run -d -p 3001:3000 -p 8081:8080 -v /home/ubuntu/honeybadger:/config --name "\${DOCKERHUB_REPO}2" \${DOCKERHUB_USERNAME}/\${DOCKERHUB_REPO}:latest
    sudo docker image prune -f
    echo "main start"
    break
  else
    # 서비스가 실행 중이지 않은 경우
    count=count+1
    if [[ count > 100 ]]; then
      echo "main timeout"
      break
	fi
    sleep 1	
  fi  
done

count=0
while true; do
  # 실행할 명령어
  response=\$(curl -s localhost:8081/api/track/health)
  if [[ \${response} =~ "UP" ]]; then
    # 서비스가 실행 중인 경우
    sudo docker rm -f \$(docker ps -aqf "name=^\${DOCKERHUB_REPO}1") # 컨테이너 찾아서 종료        
    echo "sub start"
    break
  else
    # 서비스가 실행 중이지 않은 경우
    count=count+1
    if [[ count > 100 ]]; then
      echo "sub timeout"
      break
	fi
    sleep 1
  fi  
done