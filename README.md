# Sinatra Offline
codebase オフライン質問会の資料

## DB

DB作成<br>
```$ createdb offline_sinatra_app```

DBに入る<br>
```$ psql offline_sinatra_app```

posts tableを作る<br>
```create table posts (id serial primary key, title varchar(255), contents text, image text, user_id integer);```

users tableを作る<br>
```create table users (id serial primary key, name varchar(20), password varchar(30));```