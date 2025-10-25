from fastapi import FastAPI
from fastapi.responses import HTMLResponse
from pydantic import BaseModel

import sqlite3
import threading

app = FastAPI()
users_table = 'users'
tasks_table = 'tasks'

database_name = 'tasks.sqlite'
connection = sqlite3.connect(database_name, check_same_thread = False)
semaphore = threading.Semaphore(1)

# Модель для запроса регистрации
class SignUp(BaseModel):
	first_name: str # имя
	last_name: str # фамилия
	login_or_email: str # логин для входа
	password: str # пароль

# Модель для запроса входа в систему
class SignIn(BaseModel):
	login_or_email: str # логин юзера
	password: str # пароль

# Модель для главного экрана для запроса списка задач
class Credentials(BaseModel):
	login_or_email: str # логин юзера

# Модель для создания задачи
class NewTask(BaseModel):
	date: str # дата задачи
	start_from: str # время начала
	end_at: str # время окончания
	start_time: int # время начала unixtime
	end_time: int # время завершения unixtime
	task_state: str # статус задачи
	task_description: str # описание
	login_or_email: str # логин пользователя

# Модель для запроса или удаления конкретной задачи по ID
class Task(BaseModel):
	task_id: int # айдишник задачи
	login_or_email: str # логин пользователя

# Модель для смены статуса задачи
class ChangeState(BaseModel):
	task_id: int # айди задачи
	task_state: str # новый статус
	login_or_email: str # логин пользователя

# Модель для обновления задачи
class UpdateTask(BaseModel):
	task_id: int # айди задачи
	start_from: str # время начала
	end_at: str # время завершения
	start_time: int # время начала unixtime
	end_time: int # время завершения unixtime
	task_description: str # описание задачи
	login_or_email: str # логин юзера

# Создаем таблицу для записи юзеров сервиса
def prepare_users_table():
	existence_cursor = connection.cursor()
	existence_cursor.execute("SELECT count(name) FROM sqlite_master WHERE type='table' AND name='" + users_table + "'")

	# таблица существует	
	if existence_cursor.fetchone()[0] == 1:
		print('Users table exists')
	else:
		# создаем таблицу
		creation_query = 'CREATE TABLE ' + users_table + '(first_name TEXT NOT NULL, last_name TEXT NOT NULL, login_or_email TEXT NOT NULL, password TEXT NOT NULL)'
		existence_cursor.execute(creation_query)
		existence_cursor.execute('CREATE INDEX users_index ON ' + users_table + '(login_or_email)')

	existence_cursor.close()

# Создание таблицы для хранения задач
def prepare_tasks_table():
	existence_cursor = connection.cursor()
	existence_cursor.execute("SELECT count(name) FROM sqlite_master WHERE type='table' AND name='" + tasks_table + "'")

	# таблица существует	
	if existence_cursor.fetchone()[0] == 1:
		print('Tasks table exists')
	else:
		# создаем таблицу
		creation_query = 'CREATE TABLE ' + tasks_table + '(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT NOT NULL, start_from TEXT NOT NULL, end_at TEXT NOT NULL, start_time INTEGER, end_time INTEGER, task_state TEXT NOT NULL, task_description TEXT NOT NULL, login_or_email TEXT NOT NULL)'
		existence_cursor.execute(creation_query)
		existence_cursor.execute('CREATE INDEX tasks_index ON ' + tasks_table + '(id)')

	existence_cursor.close()

prepare_users_table()
prepare_tasks_table()

# Корневой метод, просто редиректит на гитхаб
@app.get("/", response_class=HTMLResponse)
async def root():
	return '<meta http-equiv="refresh" content="0; url=https://github.com/McKayne/TaskManagerApp" />'

# Регистрация пользователя в приложении
@app.post("/signup/")
async def signup(details: SignUp):
	if semaphore.acquire:
		try:
			cursor = connection.cursor()

			# По идее тут нужно делать проверку что такой юзер уже зарегистрирован, но ок, в рамках этого тестового задания просто "перезапишем" юзера
			cursor.execute('DELETE FROM ' + users_table + ' WHERE login_or_email = ?', (details.login_or_email,))

			cursor.execute('INSERT INTO ' + users_table + ' VALUES(?, ?, ?, ?)', (details.first_name, details.last_name, details.login_or_email, details.password,))

			cursor.close()

			connection.commit()
			semaphore.release()

			return {'success': True}
		except Exception as e:
			print(e)
			semaphore.release()

	return {'success': False}

# Вход в приложение
@app.post("/signin/")
async def signin(details: SignIn):
	if semaphore.acquire:
		try:
			cursor = connection.cursor()

			cursor.execute('SELECT first_name, last_name FROM ' + users_table + ' WHERE login_or_email == ? AND password == ?', (details.login_or_email, details.password,))
			row = cursor.fetchone()

			cursor.close()
			semaphore.release()

			if row:
				return {'success': True, 'first_name': row[0], 'last_name': row[1]}
		except Exception as e:
			print(e)
			semaphore.release()

	return {'success': False}

# Запрос списка задач для пользователя
@app.post("/tasks/")
async def tasks(details: Credentials):
	if semaphore.acquire:
		try:
			cursor = connection.cursor()

			cursor.execute('SELECT * FROM ' + tasks_table + ' WHERE login_or_email == ?', (details.login_or_email,))
			rows = cursor.fetchall()

			cursor.close()
			semaphore.release()

			tasks = []
			for row in rows:
				task = {'id': row[0], 'date': row[1], 'start_from': row[2], 'end_at': row[3], 'start_time': row[4], 'end_time': row[5], 'task_state': row[6], 'task_description': row[7]}
				tasks.append(task)

			return {'success': True, 'tasks': tasks}
		except Exception as e:
			print(e)
			semaphore.release()

	return {'success': False}

# Создание новой задачи в приложении
@app.post("/newtask/")
async def newtask(details: NewTask):
	if semaphore.acquire:
		try:
			cursor = connection.cursor()

			cursor.execute('INSERT INTO ' + tasks_table + '(date, start_from, end_at, start_time, end_time, task_state, task_description, login_or_email) VALUES(?, ?, ?, ?, ?, ?, ?, ?)', (details.date, details.start_from, details.end_at, details.start_time, details.end_time, details.task_state, details.task_description, details.login_or_email,))
			task_id = cursor.lastrowid

			cursor.close()
			connection.commit()
			semaphore.release()

			return {'success': True, 'id': task_id}
		except Exception as e:
			print(e)
			semaphore.release()

	return {'success': False}

# Удаление задачи
@app.post("/deletetask/")
async def deletetask(details: Task):
	if semaphore.acquire:
		try:
			cursor = connection.cursor()

			cursor.execute('DELETE FROM ' + tasks_table + ' WHERE id == ? AND login_or_email == ?', (details.task_id, details.login_or_email,))

			cursor.close()
			connection.commit()
			semaphore.release()

			return {'success': True}
		except Exception as e:
			print(e)
			semaphore.release()

	return {'success': False}

# Смена статуса задачи
@app.post("/changestate/")
async def changestate(details: ChangeState):
	if semaphore.acquire:
		try:
			cursor = connection.cursor()

			cursor.execute('UPDATE ' + tasks_table + ' SET task_state = ? WHERE id == ? AND login_or_email == ?', (details.task_state, details.task_id, details.login_or_email,))

			cursor.close()
			connection.commit()
			semaphore.release()

			return {'success': True}
		except Exception as e:
			print(e)
			semaphore.release()

	return {'success': False}

# Обновление задачи
@app.post("/updatetask/")
async def updatetask(details: UpdateTask):
	if semaphore.acquire:
		try:
			cursor = connection.cursor()

			cursor.execute('UPDATE ' + tasks_table + ' SET start_from = ?, end_at = ?, start_time = ?, end_time = ?, task_description = ? WHERE id == ? AND login_or_email == ?', (details.start_from, details.end_at, details.start_time, details.end_time, details.task_description, details.task_id, details.login_or_email,))
			task_id = cursor.lastrowid

			cursor.close()
			connection.commit()
			semaphore.release()

			return {'success': True, 'id': task_id}
		except Exception as e:
			print(e)
			semaphore.release()

	return {'success': False}