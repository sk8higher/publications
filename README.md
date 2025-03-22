# Запуск приложения

Нужны .env.local и .env.local.test

.env.local

`DATABASE_URL=postgresql://postgres:password@postgres:5432/publications_development`

.env.test.local

`DATABASE_URL=postgresql://postgres:password@postgres:5432/publications_test`

Для запуска

`docker compose up`
