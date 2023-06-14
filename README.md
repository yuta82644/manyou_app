

| カラム |データ型|
|id      | integer|
|title   |string |
|content |text   |



<h1>Herokuデプロイ手順</h1>
- $heroku create
- package.jsにnode.jsのバージョンを追記
- $git add
- $git commit
- git push heroku step2:master
- heroku run rails db:migrate
#