module BaseFiles
  
  def copy_docker_compose 
    template "base/docker-compose.yml", 'docker-compose.yml', @env_hash
  end
  
  def copy_roro 
    directory 'base/roro/containers/app', "roro/containers/#{@env_hash[:app_name]}", @env_hash
    directory 'base/roro/containers/database', "roro/containers/#{@env_hash[:database_container]}", @env_hash
    directory 'base/roro/containers/frontend', "roro/containers/#{@env_hash[:frontend_container]}", @env_hash
  end
  
  def copy_config_database_yml 
    copy_file "base/config/database.yml", 'config/database.yml', force: true
  end

  def copy_base_files
    copy_circleci
    copy_roro 
    copy_docker_compose 
    copy_config_database_yml
  end
end