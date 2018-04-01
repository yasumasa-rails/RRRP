yarn add axios
## yarn add qs 
## yarn add element-ui
yarn add @hscmap/vue-menu
yarn add typescript ts-loader
cp -r  /mnt/c/ubuntu/ruby243/b514/app /mnt/c/ubuntu/ruby243/c514/
cp     /mnt/c/ubuntu/ruby243/b514/config/routes.rb /mnt/c/ubuntu/ruby243/c514/config/routes.rb
cp     /mnt/c/ubuntu/ruby243/a514/config/database.yml /mnt/c/ubuntu/ruby243/c514/config/database.yml
##
###  drop users cascade  ###--> user pswを引き継ぐ　環境を作成するとき export後実施
rails g devise:install
bundle install
rails g devise user
rake db:migrate
###  import users 