# 14813 Project Option 1

> Author: Yiren Zhou\<yirenzho@andrew.cmu.edu\>

This repository contains my implementation of Option 1. Please check out this (unlisted) [video demo](https://youtu.be/oos6j9aHdJs).

## 1 Checkpoint

Please see `Checkpoint.ipynb` for my detailed implementation and the output.

### 1.1 Constraints

To maximize the development efficiency, data was ingested into PostgreSQL using PySpark dataframes. Hence, data types were automatically handled by PySpark. However, `consts.py` includes the raw SQL statement for ingesting data into PostgreSQL. Please see `TABLE_STR` in `consts.py` for more details.

#### 1.1.1 Unique Identification

Apart from the existing columns, an `id` column has been added to make each record uniquely identifiable. This column is a monotonically increasing sequence.

#### 1.1.2 Other Constraints

Some other notable constraints have been listed below:

- `id`: `SERIAL`, `UNIQUE`, `PRIMARY KEY`
- `year`: greater than 2014
- `age`: greater than 0, less than 123 (122 is the recorded oldest age)
- `height`: greater than 0, less than 273 (272cm is the recorded tallest height)
- `weight`: greater than 0, less than 636 (635kg is the recorded heaviest weight)

### 1.2 Features Description

The features in the FIFA 22 player dataset are detailed statistics of all players from 2015 to 2022. Examples include roles, clubs, nations, ages, salaries, and skill rankings.

There are also low-level features of the players' capabilities. For example, `shooting`, `passing`, `dribbling`, and `defending` are numeric features that describe the competency of a player.

## 2 Docker Setup

### 2.1 Start the Container

Please ensure that Docker is available (including `docker compose`).

Within this directory, execute

```
docker compose up -d
```

which will install all the necessary dependencies.

After the container starts, we `exec` into the container by executing the script that I have made available:

```
./exec.sh
```

This will move us directly into the working directory `/workspace`.

### 2.2 Change user password of PostgreSQL and create schema

Let's start the PostgreSQL server:

```
service postgresql start
```

We need to create the schema `fifa` and make sure that our notebook has access to PostgreSQL using JDBC. We need to achieve the above two steps by getting into the shell:

```
sudo -u postgres psql
```

Then, we execute the following two SQL statements to 1) change the password and 2) create a schema named "fifa":

```sql
ALTER USER postgres PASSWORD 'bigdata';
CREATE SCHEMA fifa;
```

We then exit the shell:

```
\q
```

### 2.3 Jupyter notebook

Finally, we start the Jupyter notebook within the container by executing another script that I have made available:

```
./start_notebook.sh
```

which will give us a URL like this: `http://127.0.0.1:8888/?token=e4cf1b5d594781e622c85d670389389b8e1b43f4f80f28fe`. Please open it in your browser (**Note: please open the URL that starts with `127.0.0.1`**).

Open `Checkpoint.ipynb`, and execute the cells sequentially.

### 2.4 Exit and stop container

After exiting the Docker container, execute the following to stop the container

```
docker compose down
```
