response=$(curl -s localhost:8081/api/track/health)
if [[ $response =~ "UP" ]]; then
  # 서비스가 실행 중인 경우
  echo "서비스가 실행 중입니다."
else
  # 서비스가 실행 중이지 않은 경우
  echo "서비스가 실행 중이지 않습니다."
fi