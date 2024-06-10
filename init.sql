CREATE DATABASE IF NOT EXISTS survey_app_development;
CREATE USER IF NOT EXISTS 'user'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON survey_app_development.* TO 'user'@'%';
FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS survey_app_test;
GRANT ALL PRIVILEGES ON survey_app_test.* TO 'user'@'%';
FLUSH PRIVILEGES;
