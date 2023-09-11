# Свободное погружение в СУБД

Конспект и решение задач курса на платформе Stepik [Свободное погружение в СУБД](https://stepik.org/course/70710)

## Проектирование схемы, часть I

### Декомпозиция

- Пусть в таблице T есть атрибуты A, B и C:  
  `T = {A, B, C}`
- В каком случае можно безопасно декомпозировать её на две таблицы?  
  `T1 = {A, B}` и `T2 = {B, C}`
- Безопасная декомпозиция, или декомпозиция без потерь позволяет получить оригинальную таблицу соединением (`JOIN`)
  новых таблиц

### Декомпозиция без потерь

- Пусть в таблице T есть атрибуты A, B и C:  
  `T = {A, B, C}`
- Если B → C, то декомпозиция  
  `T1 = {A, B}` и `T2 = {B, C}`  
  является декомпозицией без потерь и  
  `T = T1 JOIN T2`

### Функциональная зависимость

- Мы кое-что знаем о природе наших данных
- Пусть нам известно правило: если в двух строках одинаковое значение в столбце B ⇒  
  у них одинаковое значение в столбце C
- Пусть мы знаем, что не должно существовать экземпляров таблицы, в которых это правило нарушается
- Тогда B функционально определяет C:  
  `B -> C`

[Wiki: Функциональная зависимость (программирование)](https://ru.wikipedia.org/wiki/Функциональная_зависимость_(программирование))

## Проектирование схемы, часть II

### Ключи

#### Потенциальный ключ (CANDIDATE KEY)

Подмножество атрибутов отношения, удовлетворяющее требованиям уникальности и несократимости (минимальности):

- Уникальность означает, что нет и не может быть двух кортежей данного отношения, в которых значения этого подмножества
  атрибутов совпадают (равны).
- Минимальность (несократимость) означает, что в составе потенциального ключа отсутствует меньшее подмножество
  атрибутов, удовлетворяющее условию уникальности. Иными словами, если из потенциального ключа убрать любой атрибут, он
  утратит свойство уникальности.

#### Первичный ключ (PRIMARY KEY)

Один из потенциальных ключей отношения, выбранный в качестве основного ключа (или ключа по умолчанию).

**Классификация:**

- **Простой ключ** - состоит из единственного атрибута.
- **Составной ключ** - состоит из двух и более атрибутов.
- **Естественный ключ** - состоит только из информационных полей таблицы.
- **Суррогатный ключ** - генерируется искусственно.

#### Внешний ключ (FOREIGN KEY)

- Связывает два столбца из двух таблиц:  
  `T1.Откуда → T2.Куда`
- Столбец Куда должен быть ключом в своей таблице T2
- Внешний ключ даёт гарантию, что в столбце Откуда не может появиться значения, не имеющегося в столбце Куда

### Критерии качества схемы

#### Нормальная форма Бойса-Кодда

**Определение:** В любой нетривиальной функциональной зависимости детерминантом является ключ.

- Пусть R является переменной отношения, а X и Y — произвольными подмножествами множества атрибутов переменной отношения
  R.
- Y функционально зависимо от X тогда и только тогда, когда для любого допустимого значения переменной отношения R, если
  два кортежа переменной отношения R совпадают по значению X, они также совпадают и по значению Y.
- Подмножество X называют детерминантом, а Y — зависимой частью.
- Функциональная зависимость тривиальна тогда и только тогда, когда её правая (зависимая) часть является подмножеством
  её левой части (детерминанта).
- Функциональная зависимость называется неприводимой слева, если ни один атрибут не может быть опущен из её детерминанта
  без нарушения зависимости (иными словами, детерминант неизбыточен).

### Грабли

#### Зависимость от подключа

Researcher, Conference - составной ключ

| Uni      | Researcher (PK) | Conference (PK) | City          |
|----------|-----------------|-----------------|---------------|
| Stanford | Jennifer        | VLDB’11         | Seattle, US   |
| MIT      | Samuel          | VLDB’11         | Seattle, US   |
| ETH      | Donald          | SIGMOD’14       | Snowbird, US  |
| Stanford | Jennifer        | SIGMOD’15       | Melbourne, AU |

`Researcher, Conference → Uni`  
`Researcher, Conference → City`   
`Conference → City`  
`Researcher → Uni`

#### Транзитивные зависимости

| Uni      | Address       | Researcher (PK) |
|----------|---------------|-----------------|
| Stanford | Seattle, US   | Jennifer        |
| MIT      | Seattle, US   | Samuel          |
| ETH      | Snowbird, US  | Donald          |
| Stanford | Melbourne, AU | Jennifer        |

`Researcher → Uni`  
`Researcher → Address`  
`Uni → Address`

#### Ключей может быть много

**Researcher**
Uni Researcher Email

| Uni      | Researcher (K1) | Email (K2)       |
|----------|-----------------|------------------|
| Stanford | Jennifer        | jen@stanford.edu |
| MIT      | Samuel          | samuel@mit.edu   |
| ETH      | Donald          | donald@ethz.ch   |
| Stanford | Jennifer        | jen@stanford.edu |

В таблице может быть не более одного первичного ключа (PRIMARY KEY) но сколько угодно потенциальных ключей (candidate
key, ключевое слово UNIQUE)

#### Связь 1:N вместо M:N

#### Связь M:N вместо 1:N

#### Суррогатный ключ

- AUTO_INCREMENT в MySQL
- SERIAL в PostgreSQL
- IDENTITY в Microsoft SQL Server и IBM DB2
- SEQUENCE в Oracle


- (+) Удобно использовать для связей
- (+) Занимает мало места на диске
- (+) Часто является первичным ключом
- (-) Часто только им и ограничиваются
- (-) Часто делают ложные предположения о его значениях

### Проектируя схему БД

- Объявляйте естественные ключи
- Убедитесь, что таблицы находятся в нормальной форме Бойса-Кодда
- Проверяйте, правильные ли получились связи и объявлены ли внешние ключи
- Помните, что суррогатные ключи не гарантируют ничего, кроме уникальности значений

## СУБД и приложение, часть I

### Жизнь запроса

- Приложение посылает текст серверу БД
- Сервер делает синтаксический разбор запроса
- Проверяет использованные имена
- Составляет план выполнения запроса
- Выполняет запрос
- Формирует результат и отсылает приложению

### План запроса и его выполнение

- План включает в себя инструкции по физическому выполнению запроса
- Простейший план: последовательно просмотреть всю таблицу
- Таблицы хранятся на дисковых страницах размером 4-8 Кб
- Время чтения одной случайной страницы с диска ≈ 5 мс
- Скорость последовательного чтения с диска ≈ 200-300 Мб/сек

### Стоимость чтения одного сектора

`Стоимость чтения = стоимость позиционирования (2-10 ms) + стоимость вращения (< 10 ms)`

### Стоимость просмотра одной таблицы

- В таблице Participant 2-3 мегабайта и примерно 200-300 страниц
- Если бы страницы читались только с диска, то один просмотр занял бы 1-2 секунды
- 1000 просмотров выполнились бы за 1000 секунд
- В самом хорошем случае за 10 секунд

### Кеш страниц

- СУБД держит недавно использованные страницы в кеше в оперативной памяти
- Наша БД скорее всего целиком помещается в память

### Hash Join

Выполняет соединение R ▷◁ S за B(R + S) операций чтения диска, где B(R + S) – суммарное количество дисковых страниц в
обеих таблицах, при условии, что одна из таблиц помещается в памяти

### Сессии

- Открытие сессии – дорогая операция
- Закрывать сессии
- Использовать пул сессий (session pool, connection pool)
- Использовать контекстные объекты
- Python try-finally, with
- Java try-finally, try with resources
- C++ деструкторы, умные указатели

### СУБД и приложение

- Не перекладывай работу СУБД на приложение
- Закрывай сессии
- Пользуйся пулом сессий
- Параметризуй контекстом объекты доступа к данным

## СУБД и приложение, часть II

### Функции представлений

- Настройка схемы БД для разных ролей пользователей
- Сокращение текста запросов
- Разграничение прав доступа
- Устойчивость приложений к изменениям

### Хранимые процедуры

- SQL + императивные конструкции  
  _переменные, условные операторы, циклы, вот это вот всё_
- Хранятся в базе данных и выполняются ядром СУБД
- Могут принимать аргументы и возвращать значения
- Могут быть вызваны из приложения через стандартизированный API

#### Плюсы

- Нет накладных расходов на передачу данных по сети
- Возможен более изощренный контроль над правами доступа
- Код и схема БД рядом ⇒ есть шансы, что изменения будут синхронизированы
- Приложение получает интерфейс для действий над данными

#### Минусы

- Синтаксис и поведение плохо стандартизированы
- Отладка несколько затруднена
- Код и схема БД в отрыве от приложения ⇒ есть шансы, что изменения будут рассинхронизированы

### Между приложением и базой данных

#### JDBC: самый низкий уровень

- Набор стандартных Java-интерфейсов: подключение, запрос, результат
- Драйвер для конкретной реализации СУБД
- URL для подключения к конкретному экземпляру СУБД
- Приложение посылает текст SQL запросов

#### Объектно-реляционные отображения

- ORM - это библиотеки/фреймфорки
- Сохранение Java-объектов в базе данных
- Упрощённый язык запросов, транслирующийся в диалекты SQL
- Автоматическая генерация схемы
- Java Persistence Architecture (JPA) - стандартный интерфейс
- Разные реализации: Hibernate, EclipseLink, TopLink, SpringJPA
- Реализации могут расширять JPA
- В других языках: SQLAlchemy, DjangoORM, ActiveRecord, Exposed...

#### Между приложением и БД

- Данные таблично-ориентированы, приложение объектно-ориентированы  
  _а ваша СУБД поддерживает наследование? а в ваших классах есть двусторонние ассоциации?_
- Низкоуровневые интерфейсы
- Объектно-реляционные отображения
- Ваш собственный интерфейс

### Что нужно запомнить

- Сделай приложению интерфейс для чтения данных  
  `CREATE VIEW`
- И для записи тоже сделай  
  _хранимые процедуры или объекты бизнес-логики в приложении_
- Минимизируй зависимость от реализации хранилища данных  
  _ты же не знаешь, какой SQL будет в моде завтра_

## Агрегатные и оконные функции

### Агрегатные функции

```sql
SELECT MIN(value),
       MAX(value),
       AVG(value),
       SUM(value),
       COUNT(*)
FROM T
```

### Группировка записей

#### Группировка

```sql
SELECT COUNT(*) AS paper_count
FROM PaperConference
GROUP BY conference_id
```

#### Фильтрация

```sql
SELECT conference_id, COUNT(*)
FROM PaperConference
GROUP BY conference_id
HAVING COUNT(*) > 100
```

#### Порядок вычислений

1. FROM-WHERE
2. GROUP BY
3. HAVING
4. SELECT

### Обобщенные табличные выражения

```sql
WITH SubmittedPapers AS (SELECT conference_id,
                                COUNT(*) AS paper_count
                         FROM PaperConference
                         GROUP BY conference_id),
     KwPerPaper AS (SELECT P.id                AS paper_id,
                           SUM(CASE
                                   WHEN PK.keyword_id IS NULL THEN 0
                                   ELSE 1 END) AS kw_count
                    FROM Paper P
                             LEFT OUTER JOIN PaperKeyword PK
                                             ON P.id = PK.paper_id
                    GROUP BY P.id)
----------------------------------------------------- 
SELECT *
FROM KwPerPaper KP
         JOIN PaperConference PC ON KP.paper_id = PC.paper_id
         JOIN SubmittedPapers SP ON SP.conference_id = PC.conference_id
WHERE SP.paper_count > 100
  AND KP.kw_count < 2;
```

### Оконные функции

- Разбивает выборку на партиции (аналогично группировке строк)
- Сортирует каждую партицию по какому-то признаку
- SELECT кроме текущей строки может оперировать с окном, состоящим из строк из той же партиции

```sql
SELECT year,
       name,
       paper_count::FLOAT / FIRST_VALUE(paper_count) OVER (
           PARTITION BY name ORDER BY year ASC
           ROWS BETWEEN 1 PRECEDING AND CURRENT ROW ) AS yoy_growth
FROM SubmittedPapersPerEvent
```

### Что нужно запомнить

- СУБД может эффективно выполнять сложные вычисления над большими массивами записей
- GROUP BY и базовые агрегатные функции реализованы практически везде
- Каждый производитель добавляет свои и/или возможность писать пользовательские агрегатные функции
- Оконные функции существенно упрощают написание сложных запросов

## Древовидные структуры и рекурсивные запросы

## Совместный доступ к данным

## Оптимизация выполнения запросов

## Нереляционные возможности

