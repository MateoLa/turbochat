#### Behind Proxy

```sh
> docker compose up
  # ERROR [superline-worker internal] load metadata for docker.io/library/ruby:3.2.2-slim
  # Unknown desc = failed to fetch oauth token: Post "https://auth.docker.io/token": Proxy Authentication Required ( Forefront TMG requires authorization to fulfill the request. Access to the Web Proxy filter is denied.)
> docker pull ruby:3.2.2-slim
```

```sh
> docker compose run app bundle install
# Net::HTTPServerException: 407 "Proxy Authentication Required 

IN C:\Users\c510268\.docker\config.json
  "proxies": {
    "default": {
      "httpProxy": "http://c510268:xxxxxx@proxy.in.iantel.com.uy:80",
      "httpsProxy": "http://c510268:xxxxxx@proxy.in.iantel.com.uy:80",
      "noProxy": "localhost, 127.0.0.0/8"
    }
  }
```

#### Production Dockerfile

```sh
RUN SECRET_KEY_BASE=skb DB_ADAPTER=nulldb bundle exec rails assets:precompile
# Now running OK
```

#### Redis (Pending)

WARNING Memory overcommit must be enabled! Without it, a background save or replication may fail under low memory condition. Being disabled, it can can also cause failures without low memory condition, see https://github.com/jemalloc/jemalloc/issues/1328. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot.

#### entrypoint.sh - no such file or directory
  or
#### /usr/bin/env: ‘ruby\r’: No such file or directory

Those errors happens when you have incorrect line endings. <br>
* on Windows Git is set up to automatically convert EOL characters to CRLF.

Making Git retain original EOL characters (disabling autocrlf).
  Specify EOL type in .gitattributes with `text eol=lf` <br>
  or Disable autocrlf in Git's config file (.gitconfig) with `autocrlf=false`.
  
  Change your file EOL endings from CRLF to LF (with Notepad++, Sublime or VisualStudio)
  Example VisualStudio: go to the file that gives you the error (./bin/importmap in my case). <br>
  At the bottom right of the screen in VS Code there is a little button that says “LF” or “CRLF”: <br>
  select LF and save. Run you command again. :)

#### ActiveRecord::NoDatabaseError
(ActiveRecord::NoDatabaseError: We could not find your database: mbusch_production. Which can be found in the database configuration file located at config/database.yml)

* docker compose run -it --rm app bundle exec rails db:create

```sh
docker compose exec -it postgres bin/sh
# psql -U <your DB-USER>
# create database mbusch_production;
```

#### Cannot run migrations because another migration process is currently running.

* Restart docker compose.

#### The asset "application.css" is not present in the asset pipeline.

```sh
docker compose run --rm -it app yarn build
```

![Wrong response: ](wrong-response-1.png)

#### materialize: Could not find gems

```sh
docker compose run --rm -it app bundle install
```

#### Could not find a JavaScript runtime

* Rails 7 with importmaps woudn't need any js runtime (node.js or other)
* Some gem that are requiring execjs. Check your gemfile.lock.
* In my case were:
  * autoprefixer-rails (Required by bootstrap.)
  * babel-transpiler (Required by spree-frontend and spree-backend.)
  * terser

So, you have to install node.js if you want these gems to work.

#### Psych::DisallowedClass Exeption

* For Rails users >= 7.0.3.1, ActiveRecord 7.0.3.1 changed an internal call and it now calls safe_load directly. If you see a Psych related error during rails tests, you might be affected by this change.
(See https://discuss.rubyonrails.org/t/cve-2022-32224-possible-rce-escalation-bug-with-serialized-columns-in-active-record/81017)

To resolve it, you can add this to a new or existing initializer:

```sh
# In config/initializers/activerecord_yaml.rb
ActiveRecord.use_yaml_unsafe_load = true
# or
config.activeRecord.use_yaml_unsafe_load = true
# Or you may also use ActiveRecord.yaml_column_permitted_classes to configure the allowed classes instead.
config.active_record.yaml_column_permitted_classes = [Symbol, Date, Time]
```

* Another solution is to downgrade up to ruby 3.0.3 wich is the last version that doesn't uses Psych 4. 

#### JS: Uncaught SyntaxError: import declarations may only appear at top level of a module
    or
#### Could not find a declaration file for module '@spree/dashboard

```sh
docker compose run --rm -it app yarn build
```

#### /bin/sh: 1: esbuild: not found

```sh
docker compose run --rm -it app ./bin/rails javascript:install:esbuild
```

#### GitHub repo has .env file

*Because you are pushing from windows

```sh
git rm --cached .env
```


#### No route matches [GET] "/users/sign_out"
