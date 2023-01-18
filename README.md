# ClickMe Video Version

# Setup

To run ClickMe Video, clone this repository onto whatever will act as the server publicly hosting the website. The recommended method is using a Google TPU virtual machine and hosting it there (if doing this, make a TPU-VM, SSH into it, and clone the repository there). The host server needs to have either a GPU or TPU availabe. After cloning the repository, do the following steps (the rest of the instructions will assume being on a TPU-VM).

## 0. SSH into the TPU-VM

It is recommended that you do this in either a screen or tmux window so that the SSH connection doesn't die

	gcloud alpha compute tpus tpu-vm ssh <TPU_NAME> --zone=<ZONE_NAME>

## 1. Initial installs:
	
	sudo apt-get update
	sudo apt-get install npm nodejs
	cd clickme_video/
	npm install

Note: if using anaconda, you may need to use the following commands:
* ```conda install nomkl numpy scipy scikit-learn numexpr```
* ```conda remove mkl mkl-service```

## 2. Prepare postgresql databse

Install posetgresql with online installer

	sudo apt-get install postgresql libpq-dev postgresql-client postgresql-client-common
	sudo -u postgres psql

You will now be in the postgres interface

	create role mircs WITH LOGIN superuser password 'serrelab';
	alter role mircs superuser;
	create database mircs with owner mircs; 
	\q

Enter the next commands using the password created above ('serrelab')

	sudo -u postgres psql mircs -h 127.0.0.1 -d mircs < node_modules/connect-pg-simple/table.sql
	sudo -u postgres psql mircs -h 127.0.0.1 -d mircs
	create table images (_id bigserial primary key, image_path varchar, syn_name varchar, click_path json, answers json, generations bigint);
	create table image_count (_id bigserial primary key,num_images bigint, current_generation bigint, iteration_generation bigint, generations_per_epoch bigint);
	create table cnn (_id bigserial primary key, sixteen_baseline_accuracy float, nineteen_baseline_accuracy float, sixteen_attention_accuracy float, nineteen_attention_accuracy float, epochs bigint, date varchar);
	create table clicks (_id bigserial primary key, high_score float, date timestamp with time zone);
	create table users (_id bigserial primary key, cookie varchar unique, name varchar, score float, email varchar, last_click_time timestamp with time zone);
	
	create table video_cats (_id bigserial primary key, video_path varchar, syn_name varchar, generations bigint);
	create table specific_video_paths (_id bigserial primary key, video_paths varchar[], syn_name varchar, generations bigint);
	\q

Some final installs

	npm install express pg express-server connect-pg-simple request yargs
	pip3 install psycopg2

## 3. Initialize images into the database

	python3 prepare_ims.py

Run the CNN guess server (this is the backend that runs the harmonized CNN and sends the prediction to the frontend)

	cd guess_server
	pip3 install flask
	python3 guess_server.py

## 4. Run the frontend

Detach from the screen/tmux window you are on, open a new one, and reconnect to the TPU

	gcloud alpha compute tpus tpu-vm ssh <TPU_NAME> --zone=<ZONE_NAME>

Run the frontend

	cd clickme_video/
	node main.js
