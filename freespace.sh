docker images --no-trunc| grep none | awk '{print }' | xargs -r docker rmi 
