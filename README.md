# AlphaPool - Carpooling App

## Deliverables

- [Pitch and Routes Overview](https://drive.google.com/file/d/13nQAgCr1_TU2t8bW7994fP5tYgVNZY1A/view?usp=sharing)
- [App Demo](https://drive.google.com/file/d/1sfUtI75KI_a0GGyj7nDdigM1yJe2ZhDU/view?usp=sharing) 
- [AppSmith UI](https://appsmith.cs3200.net/applications#638496fb572d5f0d7ff200f4)

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the `webapp` user. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

## Test

Navigate to base route URI in a browser: http://localhost:8001/.

If you see a page welcoming you to the Alphapool API, you have spun up the service correctly!


